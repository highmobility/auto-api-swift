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
//  Climate.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 30/11/2017.
//  Copyright © 2017 High Mobility. All rights reserved.
//

import Foundation


public struct Climate: FullStandardCommand {

    public let climateProfile: ClimateProfile?
    public let defoggingState: ActiveState?
    public let defrostingState: ActiveState?
    public let defrostingTemperature: Float?
    public let driverTemperature: Float?
    public let hvacState: ActiveState?
    public let insideTemperature: Float?
    public let ionisingState: ActiveState?
    public let outsideTemperature: Float?
    public let passengerTemperature: Float?


    // MARK: FullStandardCommand

    public let properties: Properties


    init?(properties: Properties) {
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
        climateProfile = ClimateProfile(bytes: properties.first(for: 0x0A)?.value)

        // Properties
        self.properties = properties
    }
}

extension Climate: Identifiable {

    public static var identifier: Identifier = Identifier(0x0024)
}

extension Climate: MessageTypesGettable {

    public enum MessageTypes: UInt8, MessageTypesKind {

        case getClimateState        = 0x00
        case climateState           = 0x01
        case setClimateProfile      = 0x02
        case startStopHVAC          = 0x03
        case startStopDefogging     = 0x04
        case startStopDefrosting    = 0x05
        case startStopIonising      = 0x06


        public static var all: [Climate.MessageTypes] {
            return [self.getClimateState,
                    self.climateState,
                    self.setClimateProfile,
                    self.startStopHVAC,
                    self.startStopDefogging,
                    self.startStopDefrosting,
                    self.startStopIonising]
        }
    }
}

public extension Climate {

    public struct Settings {
        public let climateProfile: ClimateProfile?
        public let driverTemp: Float?
        public let passengerTemp: Float?

        public init(climateProfile: ClimateProfile?, driverTemp: Float?, passengerTemp: Float?) {
            self.climateProfile = climateProfile
            self.driverTemp = driverTemp
            self.passengerTemp = passengerTemp
        }
    }


    static var getClimateState: [UInt8] {
        return commandPrefix(for: .getClimateState)
    }

    static var setClimateProfile: (Settings) -> [UInt8] {
        return {
            let profileBytes: [UInt8] = $0.climateProfile?.propertyBytes(0x01) ?? []
            let driverBytes: [UInt8] = $0.driverTemp?.propertyBytes(0x02) ?? []
            let passengerBytes: [UInt8] = $0.passengerTemp?.propertyBytes(0x03) ?? []

            return commandPrefix(for: .setClimateProfile) + profileBytes + driverBytes + passengerBytes
        }
    }

    static var startStopDefogging: (ActiveState) -> [UInt8] {
        return {
            return commandPrefix(for: .startStopDefogging, additionalBytes: $0.rawValue)
        }
    }

    static var startStopDefrosting: (ActiveState) -> [UInt8] {
        return {
            return commandPrefix(for: .startStopDefrosting, additionalBytes: $0.rawValue)
        }
    }

    static var startStopHVAC: (ActiveState) -> [UInt8] {
        return {
            return commandPrefix(for: .startStopHVAC, additionalBytes: $0.rawValue)
        }
    }

    static var startStopIonising: (ActiveState) -> [UInt8] {
        return {
            return commandPrefix(for: .startStopIonising, additionalBytes: $0.rawValue)
        }
    }
}
