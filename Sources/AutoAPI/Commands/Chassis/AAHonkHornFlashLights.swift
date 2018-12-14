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
//  AAHonkHornFlashLights.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 12/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct AAHonkHornFlashLights: AAFullStandardCommand {

    public let flasherState: AAFlasherState?


    // MARK: AAFullStandardCommand

    public let properties: AAProperties


    init?(properties: AAProperties) {
        // Ordered by the ID
        flasherState = AAFlasherState(properties: properties, keyPath: \AAHonkHornFlashLights.flasherState)

        // Properties
        self.properties = properties
    }
}

extension AAHonkHornFlashLights: AAIdentifiable {

    public static var identifier: AACommandIdentifier = 0x0026
}

extension AAHonkHornFlashLights: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getFlasherState    = 0x00
        case flasherState       = 0x01
        case honkFlash          = 0x12
        case emergencyFlasher   = 0x13
    }
}

extension AAHonkHornFlashLights: AAPropertyIdentifierGettable {

    static func propertyID<Type>(for keyPath: KeyPath<AAHonkHornFlashLights, Type>) -> AAPropertyIdentifier {
        switch keyPath {
        case \AAHonkHornFlashLights.flasherState:   return 0x01

        default:
            return 0x00
        }
    }
}

public extension AAHonkHornFlashLights {

    static var getFlasherState: [UInt8] {
        return commandPrefix(for: .getFlasherState)
    }


    static func activateEmergencyFlasher(_ state: AAActiveState) -> [UInt8] {
        return commandPrefix(for: .emergencyFlasher) + state.propertyBytes(0x01)
    }

    /// At least *one* value needs to be entered, instead of both being `nil`.
    static func honkHorn(seconds: UInt8?, flashLightsXTimes: UInt8?) -> [UInt8]? {
        guard (seconds != nil) || (flashLightsXTimes != nil) else {
            return nil
        }

        return commandPrefix(for: .honkFlash) + [seconds?.propertyBytes(0x01),
                                                 flashLightsXTimes?.propertyBytes(0x02)].propertiesValuesCombined
    }
}
