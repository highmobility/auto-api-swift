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
//  Lights.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 30/11/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation

#if os(iOS) || os(tvOS)
    import UIKit
#endif


public struct Lights: AAFullStandardCommand {

    public let ambientColour: Colour?
    public let emergencyBrakeState: AAActiveState?
    public let frontExterior: FrontLightState?
    public let interiorState: AAActiveState?
    public let rearExteriorState: AAActiveState?
    public let reverseState: AAActiveState?


    // MARK: AAFullStandardCommand

    public let properties: AAProperties


    init?(properties: AAProperties) {
        // Ordered by the ID
        frontExterior = FrontLightState(rawValue: properties.first(for: 0x01)?.monoValue)
        rearExteriorState = AAActiveState(rawValue: properties.first(for: 0x02)?.monoValue)
        interiorState = AAActiveState(rawValue: properties.first(for: 0x03)?.monoValue)

        if let bytes = properties.first(for: 0x04)?.value, bytes.count == 3 {
            let red = CGFloat(bytes[0]) / 255.0
            let green = CGFloat(bytes[1]) / 255.0
            let blue = CGFloat(bytes[2]) / 255.0

            ambientColour = Colour(red: red, green: green, blue: blue, alpha: 1.0)
        }
        else {
            ambientColour = nil
        }

        reverseState = AAActiveState(rawValue: properties.first(for: 0x05)?.monoValue)
        emergencyBrakeState = AAActiveState(rawValue: properties.first(for: 0x06)?.monoValue)

        // Properties
        self.properties = properties
    }
}

extension Lights: AAIdentifiable {

    public static var identifier: AACommandIdentifier = AACommandIdentifier(0x0036)
}

extension Lights: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getLightsState = 0x00
        case lightsState    = 0x01
        case controlLights  = 0x02
    }
}

public extension Lights {

    struct Control {
        public let frontExterior: FrontLightState?
        public let rearExteriorState: AAActiveState?
        public let interiorState: AAActiveState?
        public let ambientColour: Colour?

        public init(frontExterior: FrontLightState?, rearExteriorState: AAActiveState?, interiorState: AAActiveState?, ambientColour: Colour?) {
            self.frontExterior = frontExterior
            self.rearExteriorState = rearExteriorState
            self.interiorState = interiorState
            self.ambientColour = ambientColour
        }
    }


    static var controlLights: (Control) -> [UInt8] {
        return {
            let frontBytes: [UInt8] = $0.frontExterior?.propertyBytes(0x01) ?? []
            let rearBytes: [UInt8] = $0.rearExteriorState?.propertyBytes(0x02) ?? []
            let interiorBytes: [UInt8] = $0.interiorState?.propertyBytes(0x03) ?? []
            let ambientBytes: [UInt8] = $0.ambientColour?.propertyBytes(0x04) ?? []

            return commandPrefix(for: .controlLights) + frontBytes + rearBytes + interiorBytes + ambientBytes
        }
    }

    static var getLightsState: [UInt8] {
        return commandPrefix(for: .getLightsState)
    }
}
