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
//  HonkHornFlashLights.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 12/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct HonkHornFlashFlights: AAFullStandardCommand {

    public let flasherState: FlasherState?


    // MARK: AAFullStandardCommand

    public let properties: AAProperties


    init?(properties: AAProperties) {
        // Ordered by the ID
        flasherState = FlasherState(rawValue: properties.first(for: 0x01)?.monoValue)

        // Properties
        self.properties = properties
    }
}

extension HonkHornFlashFlights: AAIdentifiable {

    public static var identifier: AACommandIdentifier = AACommandIdentifier(0x0026)
}

extension HonkHornFlashFlights: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getFlasherState                    = 0x00
        case flasherState                       = 0x01
        case honkFlash                          = 0x02
        case activateDeactivateEmergencyFlasher = 0x03
    }
}

public extension HonkHornFlashFlights {

    struct Settings {
        public let honkHornSeconds: UInt8?
        public let flashLightsTimes: UInt8?

        public init(honkHornSeconds: UInt8?, flashLightsTimes: UInt8?){
            self.honkHornSeconds = honkHornSeconds
            self.flashLightsTimes = flashLightsTimes
        }
    }


    static var setEmergencyFlasherState: (AAActiveState) -> [UInt8] {
        return {
            return commandPrefix(for: .activateDeactivateEmergencyFlasher) + $0.propertyBytes(0x01)
        }
    }

    static var getFlasherState: [UInt8] {
        return commandPrefix(for: .getFlasherState)
    }

    static var honkHornFlashLights: (Settings) -> [UInt8] {
        return {
            let hornBytes: [UInt8] = $0.honkHornSeconds?.propertyBytes(0x01) ?? []
            let flashBytes: [UInt8] = $0.flashLightsTimes?.propertyBytes(0x02) ?? []

            return commandPrefix(for: .honkFlash) + hornBytes + flashBytes
        }
    }
}
