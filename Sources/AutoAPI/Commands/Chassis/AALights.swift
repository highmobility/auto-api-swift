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
    public let fogLights: [AAFogLight]?
    public let frontExterior: AAFrontLightState?
    public let interiorLamps: [AAInteriorLamp]?
    public let readingLamps: [AAReadingLamp]?
    public let rearExteriorState: AAActiveState?
    public let reverseState: AAActiveState?


    // MARK: AAFullStandardCommand

    public let properties: AAProperties


    init?(properties: AAProperties) {
        // Ordered by the ID
        frontExterior = AAFrontLightState(properties: properties, keyPath: \AALights.frontExterior)
        rearExteriorState = properties.value(for: \AALights.rearExteriorState)
        ambientColour = properties.first(for: \AALights.ambientColour)?.value.colour
        reverseState = properties.value(for: \AALights.reverseState)
        emergencyBrakeState = properties.value(for: \AALights.emergencyBrakeState)
        /* Level 9 */
        fogLights = properties.flatMap(for: \AALights.fogLights) { AAFogLight($0.value) }
        readingLamps = properties.flatMap(for: \AALights.readingLamps) { AAReadingLamp($0.value) }
        interiorLamps = properties.flatMap(for: \AALights.interiorLamps) { AAInteriorLamp($0.value) }

        // Properties
        self.properties = properties
    }
}

extension AALights: AAIdentifiable {

    public static var identifier: AACommandIdentifier = 0x0036
}

extension AALights: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getLightsState = 0x00
        case lightsState    = 0x01
        case controlLights  = 0x12
    }
}

extension AALights: AAPropertyIdentifierGettable {

    static func propertyID<Type>(for keyPath: KeyPath<AALights, Type>) -> AAPropertyIdentifier {
        switch keyPath {
        case \AALights.frontExterior:       return 0x01
        case \AALights.rearExteriorState:   return 0x02
        case \AALights.ambientColour:       return 0x04
        case \AALights.reverseState:        return 0x05
        case \AALights.emergencyBrakeState: return 0x06
            /* Level 9 */
        case \AALights.fogLights:       return 0x07
        case \AALights.readingLamps:    return 0x08
        case \AALights.interiorLamps:   return 0x09

        default:
            return 0x00
        }
    }
}

public extension AALights {

    static var getLightsState: [UInt8] {
        return commandPrefix(for: .getLightsState)
    }


    static func controlLights(frontExterior: AAFrontLightState? = nil,
                              rearExterior: AAActiveState? = nil,
                              interior: AAActiveState? = nil,
                              ambientColour: AAColour? = nil,
                              fogLights: [AAFogLight]? = nil,
                              readingLamps: [AAReadingLamp]? = nil,
                              interiorLamps: [AAInteriorLamp]? = nil) -> [UInt8] {
        // Make sure we have at least 1 value
        guard (frontExterior != nil) ||
            (rearExterior != nil) ||
            (interior != nil) ||
            (ambientColour != nil) ||
            (fogLights != nil) ||
            (readingLamps != nil) ||
            (interiorLamps != nil) else {
                return []
        }

        return commandPrefix(for: .controlLights) + [frontExterior?.propertyBytes(0x01),
                                                     rearExterior?.propertyBytes(0x02),
                                                     interior?.propertyBytes(0x03),
                                                     ambientColour?.propertyBytes(0x04),
                                                     fogLights?.reduceToByteArray { $0.propertyBytes(0x07) },
                                                     readingLamps?.reduceToByteArray { $0.propertyBytes(0x08) },
                                                     interiorLamps?.reduceToByteArray { $0.propertyBytes(0x09) }].propertiesValuesCombined
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
