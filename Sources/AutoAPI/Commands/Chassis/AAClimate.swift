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

    public let defrostingTemperature: AAProperty<Float>?
    public let defoggingState: AAProperty<AAActiveState>?
    public let defrostingState: AAProperty<AAActiveState>?
    public let driverTemperature: AAProperty<Float>?
    public let hvacState: AAProperty<AAActiveState>?
    public let insideTemperature: AAProperty<Float>?
    public let ionisingState: AAProperty<AAActiveState>?
    public let outsideTemperature: AAProperty<Float>?
    public let passengerTemperature: AAProperty<Float>?
    public let rearTemperature: AAProperty<Float>?
    public let weekdaysStartingTimes: [AAProperty<AAClimateWeekdayTime>]?


    // MARK: AAFullStandardCommand

    public let properties: AAProperties


    init?(properties: AAProperties) {
        // Ordered by the ID
        insideTemperature = properties.property(forIdentifier: 0x01)
        outsideTemperature = properties.property(forIdentifier: 0x02)
        driverTemperature = properties.property(forIdentifier: 0x03)
        passengerTemperature = properties.property(forIdentifier: 0x04)
        hvacState = properties.property(forIdentifier: 0x05)
        defoggingState = properties.property(forIdentifier: 0x06)
        defrostingState = properties.property(forIdentifier: 0x07)
        ionisingState = properties.property(forIdentifier: 0x08)
        defrostingTemperature = properties.property(forIdentifier: 0x09)
        /* Level 8 */
        weekdaysStartingTimes = properties.allOrNil(forIdentifier: 0x0B)
        rearTemperature = properties.property(forIdentifier: 0x0C)

        // Properties
        self.properties = properties
    }
}

extension AAClimate: AAIdentifiable {

    public static var identifier: AACommandIdentifier = 0x0024
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

public extension AAClimate {

    static var getClimateState: [UInt8] {
        return commandPrefix(for: .getClimateState)
    }


    static func changeStartingTimes(_ times: [AAClimateWeekdayTime]) -> [UInt8] {
        return commandPrefix(for: .changeStartingTimes)
            // TODO: + times.reduceToByteArray { $0.propertyBytes(0x01) }
    }

    static func changeTemperatures(driver: Float?, passenger: Float?, rear: Float?) -> [UInt8] {
        return commandPrefix(for: .changeTemperatures)
            // TODO: + [driver?.propertyBytes(0x01), passenger?.propertyBytes(0x02), rear?.propertyBytes(0x03)].propertiesValuesCombined
    }

    static func startStopDefogging(_ state: AAActiveState) -> [UInt8] {
        return commandPrefix(for: .startStopDefogging)
            // TODO: + state.propertyBytes(0x01)
    }

    static func startStopDefrosting(_ state: AAActiveState) -> [UInt8] {
            return commandPrefix(for: .startStopDefrosting)
                // TODO: + state.propertyBytes(0x01)
    }

    static func startStopHVAC(_ state: AAActiveState) -> [UInt8] {
        return commandPrefix(for: .startStopHVAC)
            // TODO: + state.propertyBytes(0x01)
    }

    static func startStopIonising(_ state: AAActiveState) -> [UInt8] {
        return commandPrefix(for: .startStopIonising)
            // TODO: + state.propertyBytes(0x01)
    }
}
