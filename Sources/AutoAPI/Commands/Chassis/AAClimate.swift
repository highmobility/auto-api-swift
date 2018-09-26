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
//  AAClimate.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 30/11/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct AAClimate: AAFullStandardCommand {

    public let defrostingTemperature: Float?
    public let defoggingState: AAActiveState?
    public let defrostingState: AAActiveState?
    public let driverTemperature: Float?
    public let hvacState: AAActiveState?
    public let insideTemperature: Float?
    public let ionisingState: AAActiveState?
    public let outsideTemperature: Float?
    public let passengerTemperature: Float?
    public let weekdaysStartingTimes: [AAClimateWeekdayTime]?


    // MARK: AAFullStandardCommand

    public let properties: AAProperties


    init?(properties: AAProperties) {
        // Ordered by the ID
        insideTemperature = properties.value(for: 0x01)
        outsideTemperature = properties.value(for: 0x02)
        driverTemperature = properties.value(for: 0x03)
        passengerTemperature = properties.value(for: 0x04)
        hvacState = properties.value(for: 0x05)
        defoggingState = properties.value(for: 0x06)
        defrostingState = properties.value(for: 0x07)
        ionisingState = properties.value(for: 0x08)
        defrostingTemperature = properties.value(for: 0x09)
        /* Level 8 */
        weekdaysStartingTimes = properties.flatMap(for: 0x0B) { AAClimateWeekdayTime($0.value) }

        // Properties
        self.properties = properties
    }
}

extension AAClimate: AAIdentifiable {

    public static var identifier: AACommandIdentifier = 0x0024
}

extension AAClimate: AALegacyGettable {

    public struct Legacy: AALegacyType {

        public let climateProfile: AAClimateProfile?


        // MARK: AALegacyType

        public enum MessageTypes: UInt8, CaseIterable {

            case getClimateState        = 0x00
            case climateState           = 0x01
            case setClimateProfile      = 0x02
            case startStopHVAC          = 0x03
            case startStopDefogging     = 0x04
            case startStopDefrosting    = 0x05
            case startStopIonising      = 0x06
        }


        public init(properties: AAProperties) {
            climateProfile = AAClimateProfile(bytes: properties.first(for: 0x0A)?.value)
        }
    }
}

extension AAClimate: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getClimateState        = 0x00
        case climateState           = 0x01
        case changeStartingTimes    = 0x12
        case startStopHVAC          = 0x13
        case startStopDefogging     = 0x14
        case startStopDefrosting    = 0x15
        case startStopIonising      = 0x16
        case changeTemperatures     = 0x17
    }
}


// MARK: Commands

public extension AAClimate {

    static var getClimateState: [UInt8] {
        return commandPrefix(for: .getClimateState)
    }


    static func changeStartingTimes(_ times: [AAClimateWeekdayTime]) -> [UInt8] {
        return commandPrefix(for: .changeStartingTimes) + times.reduceToByteArray { $0.propertyBytes(0x01) }
    }

    static func changeTemperatures(driver: Float?, passenger: Float?, rear: Float?) -> [UInt8] {
        return commandPrefix(for: .changeTemperatures) + [driver?.propertyBytes(0x01),
                                                          passenger?.propertyBytes(0x02),
                                                          rear?.propertyBytes(0x03)].propertiesValuesCombined
    }

    static func startStopDefogging(_ state: AAActiveState) -> [UInt8] {
        return commandPrefix(for: .startStopDefogging) + state.propertyBytes(0x01)
    }

    static func startStopDefrosting(_ state: AAActiveState) -> [UInt8] {
            return commandPrefix(for: .startStopDefrosting) + state.propertyBytes(0x01)
    }

    static func startStopHVAC(_ state: AAActiveState) -> [UInt8] {
        return commandPrefix(for: .startStopHVAC) + state.propertyBytes(0x01)
    }

    static func startStopIonising(_ state: AAActiveState) -> [UInt8] {
        return commandPrefix(for: .startStopIonising) + state.propertyBytes(0x01)
    }
}

public extension AAClimate.Legacy {

    public struct Settings {
        public let climateProfile: AAClimateProfile?
        public let driverTemp: Float?
        public let passengerTemp: Float?

        public init(climateProfile: AAClimateProfile?, driverTemp: Float?, passengerTemp: Float?) {
            self.climateProfile = climateProfile
            self.driverTemp = driverTemp
            self.passengerTemp = passengerTemp
        }
    }


    static var getClimateState: [UInt8] {
        return commandPrefix(for: AAClimate.self, messageType: .getClimateState)
    }

    static var setClimateProfile: (Settings) -> [UInt8] {
        return {
            let profileBytes: [UInt8] = $0.climateProfile?.propertyBytes(0x01) ?? []
            let driverBytes: [UInt8] = $0.driverTemp?.propertyBytes(0x02) ?? []
            let passengerBytes: [UInt8] = $0.passengerTemp?.propertyBytes(0x03) ?? []

            return commandPrefix(for: AAClimate.self, messageType: .setClimateProfile) + profileBytes + driverBytes + passengerBytes
        }
    }

    /// Use `false` to *stop*.
    static var startDefogging: (Bool) -> [UInt8] {
        return {
            return commandPrefix(for: AAClimate.self, messageType: .startStopDefogging, additionalBytes: $0.byte)
        }
    }

    /// Use `false` to *stop*.
    static var startDefrosting: (Bool) -> [UInt8] {
        return {
            return commandPrefix(for: AAClimate.self, messageType: .startStopDefrosting, additionalBytes: $0.byte)
        }
    }

    /// Use `false` to *stop*.
    static var startHVAC: (Bool) -> [UInt8] {
        return {
            return commandPrefix(for: AAClimate.self, messageType: .startStopHVAC, additionalBytes: $0.byte)
        }
    }

    /// Use `false` to *stop*.
    static var startIonising: (Bool) -> [UInt8] {
        return {
            return commandPrefix(for: AAClimate.self, messageType: .startStopIonising, additionalBytes: $0.byte)
        }
    }
}
