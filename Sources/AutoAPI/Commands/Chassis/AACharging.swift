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
    public let chargeTimer: AAChargeTimer?
    public let chargerVoltageAC: Float?
    public let chargerVoltageDC: Float?
    public let chargingMethod: AAChargingMethod?
    public let chargingRate: Float?
    public let chargingState: AAChargingState?
    public let chargingWindowChosen: AAChosenState?
    public let climatisationActive: AAActiveState?
    public let departureTimes: [AADepartureTime]?
    public let estimatedRange: UInt16?
    public let maxChargingCurrentAC: Float?
    public let reductionOfChargingCurrentTimes: [AADayTime]?
    public let timeToCompleteCharge: UInt16?


    // MARK: AAFullStandardCommand

    public let properties: AAProperties


    init?(properties: AAProperties) {
        // Ordered by the ID
        chargingState = AAChargingState(rawValue: properties.first(for: 0x01)?.monoValue)
        estimatedRange = properties.value(for: 0x02)
        batteryLevel = properties.value(for: 0x03)
        batteryCurrentAC = properties.value(for: 0x04)
        batteryCurrentDC = properties.value(for: 0x05)
        chargerVoltageAC = properties.value(for: 0x06)
        chargerVoltageDC = properties.value(for: 0x07)
        chargeLimit = properties.value(for: 0x08)
        timeToCompleteCharge = properties.value(for: 0x09)
        chargingRate = properties.value(for: 0x0A)
        chargePortState = AAChargePortState(rawValue: properties.first(for: 0x0B)?.monoValue)
        chargeMode = AAChargeMode(rawValue: properties.first(for: 0x0C)?.monoValue)
        chargeTimer = AAChargeTimer(bytes: properties.first(for: 0x0D)?.value)
        /* Level 7 */
        maxChargingCurrentAC = properties.value(for: 0x0E)
        chargingMethod = AAChargingMethod(rawValue: properties.first(for: 0x0F)?.monoValue)
        chargingWindowChosen = AAChosenState(rawValue: properties.first(for: 0x10)?.monoValue)
        departureTimes = properties.flatMap(for: 0x11) { AADepartureTime($0.value) }
        climatisationActive = properties.value(for: 0x12)
        reductionOfChargingCurrentTimes = properties.flatMap(for: 0x13) { AADayTime($0.value) }
        batteryTemperature = properties.value(for: 0x14)
        /* Level 8 */

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
        case startStopCharging      = 0x02
        case setChargeLimit         = 0x03
        case openCloseChargePort    = 0x04
        case setChargeMode          = 0x05
        case setChargeTimer         = 0x06


        // MARK: Deprecated

        @available(*, deprecated, renamed: "getChargingState")
        static let getChargeState = MessageTypes.getChargingState

        @available(*, deprecated, renamed: "chargingState")
        static let chargeState = MessageTypes.chargingState
    }
}

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

    static func setChargeTimer(_ timer: AAChargeTimer) -> [UInt8] {
        return commandPrefix(for: .setChargeTimer) + timer.propertyBytes(0x0D)
    }

    static func startStopCharging(_ state: AAActiveState) -> [UInt8] {
        return commandPrefix(for: .startStopCharging) + state.propertyBytes(0x01)
    }


    // MARK: Deprecated

    @available(*, deprecated, renamed: "getChargingState")
    static var getChargeState: [UInt8] {
        return getChargingState
    }

    @available(*, deprecated, renamed: "startStopCharging")
    static var setChargingState: (AAActiveState) -> [UInt8] {
        return startStopCharging
    }
}
