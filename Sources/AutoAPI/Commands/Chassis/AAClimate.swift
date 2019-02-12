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
        insideTemperature = properties.property(for: \AAClimate.insideTemperature)
        outsideTemperature = properties.property(for: \AAClimate.outsideTemperature)
        driverTemperature = properties.property(for: \AAClimate.driverTemperature)
        passengerTemperature = properties.property(for: \AAClimate.passengerTemperature)
        hvacState = properties.property(for: \AAClimate.hvacState)
        defoggingState = properties.property(for: \AAClimate.defoggingState)
        defrostingState = properties.property(for: \AAClimate.defrostingState)
        ionisingState = properties.property(for: \AAClimate.ionisingState)
        defrostingTemperature = properties.property(for: \AAClimate.defrostingTemperature)
        /* Level 8 */
        weekdaysStartingTimes = properties.properties(for: \AAClimate.weekdaysStartingTimes)
        rearTemperature = properties.property(for: \AAClimate.rearTemperature)

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

extension AAClimate: AAPropertyIdentifierGettable {

    static func propertyID<Type>(for keyPath: KeyPath<AAClimate, Type>) -> AAPropertyIdentifier? {
        switch keyPath {
        case \AAClimate.insideTemperature:      return 0x01
        case \AAClimate.outsideTemperature:     return 0x02
        case \AAClimate.driverTemperature:      return 0x03
        case \AAClimate.passengerTemperature:   return 0x04
        case \AAClimate.hvacState:              return 0x05
        case \AAClimate.defoggingState:         return 0x06
        case \AAClimate.defrostingState:        return 0x07
        case \AAClimate.ionisingState:          return 0x08
        case \AAClimate.defrostingTemperature:  return 0x09
            /* Level 8 */
        case \AAClimate.weekdaysStartingTimes:  return 0x0B
        case \AAClimate.rearTemperature:        return 0x0C

        default:
            return nil
        }
    }
}

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
