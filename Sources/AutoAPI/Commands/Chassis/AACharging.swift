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
//  AACharging.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 30/11/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct AACharging: AAFullStandardCommand {

    public let batteryCurrentAC: AAProperty<Float>?
    public let batteryCurrentDC: AAProperty<Float>?
    public let batteryLevel: AAProperty<AAPercentageInt>?
    public let batteryTemperature: AAProperty<Float>?
    public let chargeLimit: AAProperty<AAPercentageInt>?
    public let chargeMode: AAProperty<AAChargeMode>?
    public let chargePortState: AAProperty<AAOpenClose>?
    public let chargerVoltageAC: AAProperty<Float>?
    public let chargerVoltageDC: AAProperty<Float>?
    public let chargingRate: AAProperty<Float>?
    public let chargingWindowChosen: AAProperty<AAChosenState>?
    public let departureTimes: [AAProperty<AADepartureTime>]?
    public let estimatedRange: AAProperty<UInt16>?
    public let maxChargingCurrentAC: AAProperty<Float>?
    public let pluggedIn: AAProperty<AAPluggedInState>?
    public let plugType: AAProperty<AAPlugType>?
    public let reductionOfChargingCurrentTimes: [AAProperty<AAReductionTime>]?
    public let state: AAProperty<AAChargingState>?
    public let timers: [AAProperty<AAChargingTimer>]?
    public let timeToCompleteCharge: AAProperty<UInt16>?


    // MARK: AAFullStandardCommand

    public let properties: AAProperties


    init?(properties: AAProperties) {
        // Ordered by the ID
        estimatedRange = properties.property(for: \AACharging.estimatedRange)
        batteryLevel = properties.property(for: \AACharging.batteryLevel)
        batteryCurrentAC = properties.property(for: \AACharging.batteryCurrentAC)
        batteryCurrentDC = properties.property(for: \AACharging.batteryCurrentDC)
        chargerVoltageAC = properties.property(for: \AACharging.chargerVoltageAC)
        chargerVoltageDC = properties.property(for: \AACharging.chargerVoltageDC)
        chargeLimit = properties.property(for: \AACharging.chargeLimit)
        timeToCompleteCharge = properties.property(for: \AACharging.timeToCompleteCharge)
        chargingRate = properties.property(for: \AACharging.chargingRate)
        chargePortState = properties.property(for: \AACharging.chargePortState)
        chargeMode = properties.property(for: \AACharging.chargeMode)
        /* Level 8 */
        maxChargingCurrentAC = properties.property(for: \AACharging.maxChargingCurrentAC)
        plugType = properties.property(for: \AACharging.plugType)
        chargingWindowChosen = properties.property(for: \AACharging.chargingWindowChosen)
        departureTimes = properties.properties(for: \AACharging.departureTimes)
        reductionOfChargingCurrentTimes = properties.properties(for: \AACharging.reductionOfChargingCurrentTimes)
        batteryTemperature = properties.property(for: \AACharging.batteryTemperature)
        timers = properties.properties(for: \AACharging.timers)
        pluggedIn = properties.property(for: \AACharging.pluggedIn)
        state = properties.property(for: \AACharging.state)

        // Properties
        self.properties = properties
    }
}

extension AACharging: AAIdentifiable {

    public static var identifier: AACommandIdentifier = 0x0023
}

extension AACharging: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getChargingState       = 0x00
        case chargingState          = 0x01
        case startStopCharging      = 0x12
        case setChargeLimit         = 0x13
        case openCloseChargePort    = 0x14
        case setChargeMode          = 0x15
        case setChargingTimers      = 0x16
        case setReductionTimes      = 0x17
    }
}

extension AACharging: AAPropertyIdentifierGettable {

    static func propertyID<Type>(for keyPath: KeyPath<AACharging, Type>) -> AAPropertyIdentifier? {
        switch keyPath {
        case \AACharging.estimatedRange:        return 0x02
        case \AACharging.batteryLevel:          return 0x03
        case \AACharging.batteryCurrentAC:      return 0x04
        case \AACharging.batteryCurrentDC:      return 0x05
        case \AACharging.chargerVoltageAC:      return 0x06
        case \AACharging.chargerVoltageDC:      return 0x07
        case \AACharging.chargeLimit:           return 0x08
        case \AACharging.timeToCompleteCharge:  return 0x09
        case \AACharging.chargingRate:          return 0x0A
        case \AACharging.chargePortState:       return 0x0B
        case \AACharging.chargeMode:            return 0x0C
            /* Level 8 */
        case \AACharging.maxChargingCurrentAC:              return 0x0E
        case \AACharging.plugType:                          return 0x0F
        case \AACharging.chargingWindowChosen:              return 0x10
        case \AACharging.departureTimes:                    return 0x11
        case \AACharging.reductionOfChargingCurrentTimes:   return 0x13
        case \AACharging.batteryTemperature:                return 0x14
        case \AACharging.timers:                            return 0x15
        case \AACharging.pluggedIn:                         return 0x16
        case \AACharging.state:                             return 0x17

        default:
            return nil
        }
    }
}

public extension AACharging {

    static var getChargingState: [UInt8] {
        return commandPrefix(for: .getChargingState)
    }


    static func openCloseChargePort(_ state: AAOpenClose) -> [UInt8] {
        return commandPrefix(for: .openCloseChargePort) + state.propertyBytes(0x01)
    }

    static func setChargeLimit(_ limit: AAPercentageInt) -> [UInt8] {
        return commandPrefix(for: .setChargeLimit) + limit.propertyBytes(0x01)
    }

    /// - warning: `.immediate` is not supported
    static func setChargeMode(_ mode: AAChargeMode) -> [UInt8]? {
        guard mode != .immediate else {
            return nil
        }

        return commandPrefix(for: .setChargeMode) + mode.propertyBytes(0x01)
    }

    static func setChargingTimers(_ timers: [AAChargingTimer]) -> [UInt8] {
        return commandPrefix(for: .setChargingTimers) + timers.reduceToByteArray { $0.propertyBytes(0x0D) }
    }

    static func setReductionOfChargingCurrentTimes(_ times: [AAReductionTime]) -> [UInt8] {
        return commandPrefix(for: .setReductionTimes) + times.reduceToByteArray { $0.propertyBytes(0x01) }
    }

    static func startStopCharging(_ state: AAActiveState) -> [UInt8] {
        return commandPrefix(for: .startStopCharging) + state.propertyBytes(0x01)
    }
}
