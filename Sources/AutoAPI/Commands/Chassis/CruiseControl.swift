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
//  CruiseControl.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 24/04/2018.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct CruiseControl: FullStandardCommand {

    public let activeState: ActiveState?
    public let adaptiveState: ActiveState?
    public let adaptiveTargetSpeed: Int16?
    public let limiter: CruiseControlLimiter?
    public let targetSpeed: Int16?


    // MARK: FullStandardCommand

    public let properties: Properties


    init?(properties: Properties) {
        // Ordered by the ID
        activeState = ActiveState(rawValue: properties.first(for: 0x01)?.monoValue)
        limiter = CruiseControlLimiter(rawValue: properties.first(for: 0x02)?.monoValue)
        targetSpeed = properties.value(for: 0x03)
        adaptiveState = ActiveState(rawValue: properties.first(for: 0x04)?.monoValue)
        adaptiveTargetSpeed = properties.value(for: 0x05)

        // Properties
        self.properties = properties
    }
}

extension CruiseControl: Identifiable {

    public static var identifier: Identifier = Identifier(0x0062)
}

extension CruiseControl: MessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getCruiseControlState  = 0x00
        case cruiseControlState     = 0x01
        case controlCruiseControl   = 0x02
    }
}

public extension CruiseControl {

    struct Control {
        public let activeState: ActiveState
        public let targetSpeed: Int16?

        public init(activeState: ActiveState, targetSpeed: Int16?) {
            self.activeState = activeState
            self.targetSpeed = targetSpeed
        }
    }


    static var activateCruiseControl: (Control) -> [UInt8] {
        return {
            let activationBytes = $0.activeState.propertyBytes(0x01)
            let speedBytes: [UInt8] = $0.targetSpeed?.propertyBytes(0x02) ?? []

            return commandPrefix(for: .controlCruiseControl) + activationBytes + speedBytes
        }
    }

    static var getCruiseControlState: [UInt8] {
        return commandPrefix(for: .getCruiseControlState)
    }
}
