//
//  The MIT License
//
//  Copyright (c) 2014- High-Mobility GmbH (https://high-mobility.com)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//
//
//  Lights.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 30/11/2017.
//

import Foundation

#if os(iOS) || os(tvOS)
    import UIKit
#endif


public struct Lights: FullStandardCommand {

    public let ambientColour: Colour?
    public let isEmergencyBrakeActive: Bool?
    public let frontExterior: FrontLightState?
    public let isInteriorActive: Bool?
    public let isRearExteriorActive: Bool?
    public let isReverseActive: Bool?


    // MARK: FullStandardCommand

    public let properties: Properties


    init?(properties: Properties) {
        // Ordered by the ID
        frontExterior = FrontLightState(rawValue: properties.first(for: 0x01)?.monoValue)
        isRearExteriorActive = properties.value(for: 0x02)
        isInteriorActive = properties.value(for: 0x03)

        if let bytes = properties.first(for: 0x04)?.value, bytes.count == 3 {
            let red = CGFloat(bytes[0]) / 255.0
            let green = CGFloat(bytes[1]) / 255.0
            let blue = CGFloat(bytes[2]) / 255.0

            ambientColour = Colour(red: red, green: green, blue: blue, alpha: 1.0)
        }
        else {
            ambientColour = nil
        }

        isReverseActive = properties.value(for: 0x05)
        isEmergencyBrakeActive = properties.value(for: 0x06)

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
        public let isRearExteriorActive: Bool?
        public let isInteriorActive: Bool?
        public let ambientColour: Colour?

        public init(frontExterior: FrontLightState?, isRearExteriorActive: Bool?, isInteriorActive: Bool?, ambientColour: Colour?) {
            self.frontExterior = frontExterior
            self.isRearExteriorActive = isRearExteriorActive
            self.isInteriorActive = isInteriorActive
            self.ambientColour = ambientColour
        }
    }


    static var controlLights: (Control) -> [UInt8] {
        return {
            let frontBytes: [UInt8] = $0.frontExterior?.propertyBytes(0x01) ?? []
            let rearBytes: [UInt8] = $0.isRearExteriorActive?.propertyBytes(0x02) ?? []
            let interiorBytes: [UInt8] = $0.isInteriorActive?.propertyBytes(0x03) ?? []
            let ambientBytes: [UInt8] = $0.ambientColour?.propertyBytes(0x04) ?? []

            return commandPrefix(for: .controlLights) + frontBytes + rearBytes + interiorBytes + ambientBytes
        }
    }

    static var getLightsState: [UInt8] {
        return commandPrefix(for: .getLightsState)
    }
}
