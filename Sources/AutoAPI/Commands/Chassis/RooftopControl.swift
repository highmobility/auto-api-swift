//
// AutoAPI
// Copyright (C) 2018 High-Mobility GmbH
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program. If not, see http://www.gnu.org/licenses/.
//
// Please inquire about commercial licensing options at
// licensing@high-mobility.com
//
//
//  RooftopControl.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 01/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct RooftopControl: FullStandardCommand {

    public let convertibleState: ConvertibleRoofState?

    /// 100% denoting *opaque* and 0% *transparent*.
    public let dimming: PercentageInt?

    /// 100% denoting *fully open*, 50% denoting *intermediate* and 0% *closed*.
    public let position: PercentageInt?

    public let tiltState: PositionState?


    // MARK: FullStandardCommand

    public let properties: Properties


    init?(properties: Properties) {
        // Ordered by the ID
        dimming = properties.value(for: 0x01)
        position = properties.value(for: 0x02)
        convertibleState = ConvertibleRoofState(rawValue: properties.first(for: 0x03)?.monoValue)
        tiltState = PositionState(rawValue: properties.first(for: 0x04)?.monoValue)

        // Properties
        self.properties = properties
    }
}

extension RooftopControl: Identifiable {

    public static var identifier: Identifier = Identifier(0x0025)
}

extension RooftopControl: MessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getRooftopState    = 0x00
        case rooftopState       = 0x01
        case controlRooftop     = 0x02
    }
}

public extension RooftopControl {

    struct Control {
        public let dimming: PercentageInt?
        public let openClose: PercentageInt?

        public init(dimming: PercentageInt?, openClose: PercentageInt?) {
            self.dimming = dimming
            self.openClose = openClose
        }
    }


    static var controlRooftop: (Control) -> [UInt8] {
        return {
            let dimmingBytes: [UInt8] = $0.dimming?.propertyBytes(0x01) ?? []
            let openCloseBytes: [UInt8] = $0.openClose?.propertyBytes(0x02) ?? []

            return commandPrefix(for: .controlRooftop) + dimmingBytes + openCloseBytes
        }
    }

    static var getRooftopState: [UInt8] {
        return commandPrefix(for: .getRooftopState)
    }
}
