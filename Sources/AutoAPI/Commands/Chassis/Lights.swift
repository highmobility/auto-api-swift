//
// AutoAPI
// Copyright (C) 2017 High-Mobility GmbH
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
//  Copyright © 2017 High Mobility. All rights reserved.
//

import Foundation

#if os(iOS) || os(tvOS)
    import UIKit
#endif


public struct Lights: FullStandardCommand {

    public let ambientColour: Colour?
    public let frontExterior: FrontLightState?
    public let interior: LightState?
    public let rearExterior: LightState?


    // MARK: FullStandardCommand

    public let properties: Properties


    init?(properties: Properties) {
        // Ordered by the ID
        frontExterior = FrontLightState(rawValue: properties.first(for: 0x01)?.monoValue)
        rearExterior = properties.value(for: 0x02)
        interior = properties.value(for: 0x03)

        if let bytes = properties.first(for: 0x04)?.value, bytes.count == 3 {
            let red = CGFloat(bytes[0]) / 255.0
            let green = CGFloat(bytes[1]) / 255.0
            let blue = CGFloat(bytes[2]) / 255.0

            ambientColour = Colour(red: red, green: green, blue: blue, alpha: 1.0)
        }
        else {
            ambientColour = nil
        }

        // Properties
        self.properties = properties
    }
}

extension Lights: Identifiable {

    public static var identifier: Identifier = Identifier(0x0036)
}

extension Lights: MessageTypesGettable {

    public enum MessageTypes: UInt8, MessageTypesKind {

        case getLightsState = 0x00
        case lightsState    = 0x01
        case controlLights  = 0x02


        public static var all: [Lights.MessageTypes] {
            return [self.getLightsState,
                    self.lightsState,
                    self.controlLights]
        }
    }
}

public extension Lights {

    struct Control {
        public let frontExterior: FrontLightState?
        public let rearExterior: LightState?
        public let interior: LightState?
        public let ambientColour: Colour?

        public init(frontExterior: FrontLightState?, rearExterior: LightState?, interior: LightState?, ambientColour: Colour?) {
            self.frontExterior = frontExterior
            self.rearExterior = rearExterior
            self.interior = interior
            self.ambientColour = ambientColour
        }
    }


    static var controlLights: (Control) -> [UInt8] {
        return {
            let frontBytes: [UInt8] = $0.frontExterior?.propertyBytes(0x01) ?? []
            let rearBytes: [UInt8] = $0.rearExterior?.propertyBytes(0x02) ?? []
            let interiorBytes: [UInt8] = $0.interior?.propertyBytes(0x03) ?? []
            let ambientBytes: [UInt8] = $0.ambientColour?.propertyBytes(0x04) ?? []

            return commandPrefix(for: .controlLights) + frontBytes + rearBytes + interiorBytes + ambientBytes
        }
    }

    static var getLightsState: [UInt8] {
        return commandPrefix(for: .getLightsState)
    }
}
