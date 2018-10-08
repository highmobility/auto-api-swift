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
//  AALights.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 30/11/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation

#if os(iOS) || os(tvOS)
    import UIKit
#endif


public struct AALights: AAFullStandardCommand {

    public let ambientColour: AAColour?
    public let emergencyBrakeState: AAActiveState?
    public let frontExterior: AAFrontLightState?
    public let interiorState: AAActiveState?
    public let rearExteriorState: AAActiveState?
    public let reverseState: AAActiveState?


    // MARK: AAFullStandardCommand

    public let properties: AAProperties


    init?(properties: AAProperties) {
        // Ordered by the ID
        frontExterior = AAFrontLightState(properties: properties, keyPath: \AALights.frontExterior)
        rearExteriorState = properties.value(for: \AALights.rearExteriorState)
        interiorState = properties.value(for: \AALights.interiorState)
        ambientColour = properties.first(for: \AALights.ambientColour)?.value.colour
        reverseState = properties.value(for: \AALights.reverseState)
        emergencyBrakeState = properties.value(for: \AALights.emergencyBrakeState)

        // Properties
        self.properties = properties
    }
}

extension AALights: AAIdentifiable {

    public static var identifier: AACommandIdentifier = 0x0036
}

extension AALights: AALegacyGettable {

    public struct Legacy: AALegacyType {

        public enum MessageTypes: UInt8, CaseIterable {

            case getLightsState = 0x00
            case lightsState    = 0x01
            case controlLights  = 0x02
        }


        public init(properties: AAProperties) {

        }
    }
}

extension AALights: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getLightsState = 0x00
        case lightsState    = 0x01
        case controlLights  = 0x12
    }
}

extension AALights: AAPropertyIdentifierGettable {

    static func propertyID(for keyPath: PartialKeyPath<AALights>) -> AAPropertyIdentifier {
        switch keyPath {
        case \AALights.frontExterior:       return 0x01
        case \AALights.rearExteriorState:   return 0x02
        case \AALights.interiorState:       return 0x03
        case \AALights.ambientColour:       return 0x04
        case \AALights.reverseState:        return 0x05
        case \AALights.emergencyBrakeState: return 0x06

        default:
            return 0x00
        }
    }
}


// MARK: Commands

public extension AALights {

    static var getLightsState: [UInt8] {
        return commandPrefix(for: .getLightsState)
    }


    /// At least *one* value needs to be entered, instead of all being `nil`.
    static func controlLights(frontExterior: AAFrontLightState? = nil,
                              rearExterior: AAActiveState? = nil,
                              interior: AAActiveState? = nil,
                              ambientColour: AAColour? = nil) -> [UInt8]? {
        guard (frontExterior != nil) || (rearExterior != nil) || (interior != nil) || (ambientColour != nil) else {
            return nil
        }

        return commandPrefix(for: .controlLights) + [frontExterior?.propertyBytes(0x01),
                                                     rearExterior?.propertyBytes(0x02),
                                                     interior?.propertyBytes(0x03),
                                                     ambientColour?.propertyBytes(0x04)].propertiesValuesCombined
    }
}

public extension AALights.Legacy {

    struct Control {
        public let frontExterior: AAFrontLightState?
        public let isRearExteriorActive: Bool?
        public let isInteriorActive: Bool?
        public let ambientColour: AAColour?

        public init(frontExterior: AAFrontLightState?, isRearExteriorActive: Bool?, isInteriorActive: Bool?, ambientColour: AAColour?) {
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

            return commandPrefix(for: AALights.self, messageType: .controlLights) + frontBytes + rearBytes + interiorBytes + ambientBytes
        }
    }

    static var getLightsState: [UInt8] {
        return commandPrefix(for: AALights.self, messageType: .getLightsState)
    }
}


private extension Collection where Element == UInt8 {

    var colour: AAColour? {
        guard count == 3 else {
            return nil
        }

        let red = CGFloat(bytes[0]) / 255.0
        let green = CGFloat(bytes[1]) / 255.0
        let blue = CGFloat(bytes[2]) / 255.0

        return AAColour(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
