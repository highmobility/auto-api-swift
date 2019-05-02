//
// AutoAPI
// Copyright (C) 2019 High-Mobility GmbH
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
//  Copyright © 2019 High Mobility GmbH. All rights reserved.
//

import Foundation


public class AALights: AACapabilityClass, AACapability {

    public let ambientColour: AAProperty<AAColour>?
    public let emergencyBrakeState: AAProperty<AAActiveState>?
    public let fogLights: [AAProperty<AAFogLight>]?
    public let frontExterior: AAProperty<AAFrontLightState>?
    public let interiorLamps: [AAProperty<AAInteriorLamp>]?
    public let readingLamps: [AAProperty<AAReadingLamp>]?
    public let rearExteriorState: AAProperty<AAActiveState>?
    public let reverseState: AAProperty<AAActiveState>?


    // MARK: AACapability

    public static var identifier: AACapabilityIdentifier = 0x0036


    required init(properties: AAProperties) {
        // Ordered by the ID
        frontExterior = properties.property(forIdentifier: 0x01)
        rearExteriorState = properties.property(forIdentifier: 0x02)
        ambientColour = properties.property(forIdentifier: 0x04)
        reverseState = properties.property(forIdentifier: 0x05)
        emergencyBrakeState = properties.property(forIdentifier: 0x06)
        /* Level 9 */
        fogLights = properties.allOrNil(forIdentifier: 0x07)
        readingLamps = properties.allOrNil(forIdentifier: 0x08)
        interiorLamps = properties.allOrNil(forIdentifier: 0x09)

        super.init(properties: properties)
    }
}

extension AALights: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getLightsState = 0x00
        case lightsState    = 0x01
        case controlLights  = 0x12
    }
}

public extension AALights {

    static var getLightsState: AACommand {
        return command(forMessageType: .getLightsState)
    }


    static func controlLights(frontExterior: AAFrontLightState? = nil,
                              rearExterior: AAActiveState? = nil,
                              ambientColour: AAColour? = nil,
                              fogLights: [AAFogLight]? = nil,
                              readingLamps: [AAReadingLamp]? = nil,
                              interiorLamps: [AAInteriorLamp]? = nil) -> AACommand? {
        // Make sure we have at least 1 value
        guard (frontExterior != nil) ||
            (rearExterior != nil) ||
            (ambientColour != nil) ||
            (fogLights != nil) ||
            (readingLamps != nil) ||
            (interiorLamps != nil) else {
                return nil
        }

        var properties = [frontExterior?.property(forIdentifier: 0x01),
                          rearExterior?.property(forIdentifier: 0x02),
                          ambientColour?.property(forIdentifier: 0x04)]

        properties += fogLights?.map { $0.property(forIdentifier: 0x07) } ?? []
        properties += readingLamps?.map { $0.property(forIdentifier: 0x08) } ?? []
        properties += interiorLamps?.map { $0.property(forIdentifier: 0x09) } ?? []

        return command(forMessageType: .controlLights, properties: properties)
    }
}
