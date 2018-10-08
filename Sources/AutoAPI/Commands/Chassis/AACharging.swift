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

    public let batteryCurrentAC: Float?
    public let batteryCurrentDC: Float?
    public let batteryLevel: AAPercentageInt?
    public let batteryTemperature: Float?
    public let chargeLimit: AAPercentageInt?
    public let chargeMode: AAChargeMode?
    public let chargePortState: AAChargePortState?
    public let chargerVoltageAC: Float?
    public let chargerVoltageDC: Float?
    public let chargingRate: Float?
    public let chargingWindowChosen: AAChosenState?
    public let departureTimes: [AADepartureTime]?
    public let estimatedRange: UInt16?
    public let maxChargingCurrentAC: Float?
    public let pluggedIn: AAPluggedInState?
    public let plugType: AAPlugType?
    public let reductionOfChargingCurrentTimes: [AATime]?
    public let state: AAChargingState?
    public let timers: [AAChargingTimer]?
    public let timeToCompleteCharge: UInt16?


    // MARK: AAFullStandardCommand

    public let properties: AAProperties


    init?(properties: AAProperties) {
        // Ordered by the ID
        estimatedRange = properties.value(for: \AACharging.estimatedRange)
        batteryLevel = properties.value(for: \AACharging.batteryLevel)
        batteryCurrentAC = properties.value(for: \AACharging.batteryCurrentAC)
        batteryCurrentDC = properties.value(for: \AACharging.batteryCurrentDC)
        chargerVoltageAC = properties.value(for: \AACharging.chargerVoltageAC)
        chargerVoltageDC = properties.value(for: \AACharging.chargerVoltageDC)
        chargeLimit = properties.value(for: \AACharging.chargeLimit)
        timeToCompleteCharge = properties.value(for: \AACharging.timeToCompleteCharge)
        chargingRate = properties.value(for: \AACharging.chargingRate)
        chargePortState = AAChargePortState(properties: properties, keyPath: \AACharging.chargePortState)
        chargeMode = AAChargeMode(properties: properties, keyPath: \AACharging.chargeMode)
        /* Level 8 */
        maxChargingCurrentAC = properties.value(for: \AACharging.maxChargingCurrentAC)
        plugType = AAPlugType(properties: properties, keyPath: \AACharging.plugType)
        chargingWindowChosen = AAChosenState(properties: properties, keyPath: \AACharging.chargingWindowChosen)
        departureTimes = properties.flatMap(for: \AACharging.departureTimes) { AADepartureTime($0.value) }
        reductionOfChargingCurrentTimes = properties.flatMap(for: \AACharging.reductionOfChargingCurrentTimes) { AATime($0.value) }
        batteryTemperature = properties.value(for: \AACharging.batteryTemperature)
        timers = properties.flatMap(for: \AACharging.timers) { AAChargingTimer($0.value) }
        pluggedIn = AAPluggedInState(properties: properties, keyPath: \AACharging.pluggedIn)
        state = AAChargingState(properties: properties, keyPath: \AACharging.state)

        // Properties
        self.properties = properties
    }
}

extension AACharging: AAIdentifiable {

    public static var identifier: AACommandIdentifier = 0x0023
}

extension AACharging: AALegacyGettable {

    public struct Legacy: AALegacyType {

        public let chargingState: AAChargingStateLegacy?
        public let chargeTimer: AAChargingTimer?


        // MARK: AALegacyType

        public enum MessageTypes: UInt8, CaseIterable {

            case getChargeState         = 0x00
            case chargeState            = 0x01
            case startStopCharging      = 0x02
            case setChargeLimit         = 0x03
            case openCloseChargePort    = 0x04
            case setChargeMode          = 0x05
            case setChargeTimer         = 0x06
        }


        public init(properties: AAProperties) {
            chargingState = AAChargingStateLegacy(rawValue: properties.first(for: 0x01)?.monoValue)
            chargeTimer = AAChargingTimer(properties.first(for: 0x0D)?.value ?? [])
        }
    }
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
    }
}

extension AACharging: AAPropertyIdentifierGettable {

    static func propertyID<Type>(for keyPath: KeyPath<AACharging, Type>) -> AAPropertyIdentifier {
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
            return 0x00
        }
    }
}


// MARK: Commands

public extension AACharging {

    static var getChargingState: [UInt8] {
        return commandPrefix(for: .getChargingState)
    }


    static func openCloseChargePort(_ state: AAChargePortState) -> [UInt8] {
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

    static func startStopCharging(_ state: AAActiveState) -> [UInt8] {
        return commandPrefix(for: .startStopCharging) + state.propertyBytes(0x01)
    }
}

public extension AACharging.Legacy {

    static var getChargeState: [UInt8] {
        return commandPrefix(for: AACharging.self, messageType: .getChargeState)
    }

    static var openCloseChargePort: (AAChargePortState) -> [UInt8] {
        return {
            return commandPrefix(for: AACharging.self, messageType: .openCloseChargePort, additionalBytes: $0.rawValue)
        }
    }

    static var setChargeLimit: (AAPercentageInt) -> [UInt8] {
        return {
            return commandPrefix(for: AACharging.self, messageType: .setChargeLimit, additionalBytes: $0)
        }
    }

    /// `.immediate` is not supported
    static var setChargeMode: (AAChargeMode) -> [UInt8]? {
        return {
            guard $0 != .immediate else {
                return nil
            }

            return commandPrefix(for: AACharging.self, messageType: .setChargeMode, additionalBytes: $0.rawValue)
        }
    }

    static var setChargeTimer: (AAChargingTimer) -> [UInt8] {
        return {
            return commandPrefix(for: AACharging.self, messageType: .setChargeTimer) + $0.propertyBytes(0x0D)
        }
    }

    /// Use `false` to *stop*.
    static var startCharging: (Bool) -> [UInt8] {
        return {
            return commandPrefix(for: AACharging.self, messageType: .startStopCharging, additionalBytes: $0.byte)
        }
    }
}
