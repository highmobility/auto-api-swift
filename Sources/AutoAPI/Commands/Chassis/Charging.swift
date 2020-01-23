//
//  The MIT License
//
//  Copyright (c) 2014- High-Mobility GmbH (https://high-mobility.com)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//
//
//  Charging.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 30/11/2017.
//

import Foundation


public struct Charging: FullStandardCommand {

    public let batteryCurrentAC: Float?
    public let batteryCurrentDC: Float?
    public let batteryLevel: PercentageInt?
    public let chargeLimit: PercentageInt?
    public let chargeMode: ChargeMode?
    public let chargePortState: ChargePortState?
    public let chargeTimer: ChargeTimer?
    public let chargerVoltageAC: Float?
    public let chargerVoltageDC: Float?
    public let chargingRate: Float?
    public let chargingState: ChargingState?
    public let estimatedRange: UInt16?
    public let timeToCompleteCharge: UInt16?


    // MARK: FullStandardCommand

    public let properties: Properties


    init?(properties: Properties) {
        // Ordered by the ID
        chargingState = ChargingState(rawValue: properties.first(for: 0x01)?.monoValue)
        estimatedRange = properties.value(for: 0x02)
        batteryLevel = properties.value(for: 0x03)
        batteryCurrentAC = properties.value(for: 0x04)
        batteryCurrentDC = properties.value(for: 0x05)
        chargerVoltageAC = properties.value(for: 0x06)
        chargerVoltageDC = properties.value(for: 0x07)
        chargeLimit = properties.value(for: 0x08)
        timeToCompleteCharge = properties.value(for: 0x09)
        chargingRate = properties.value(for: 0x0A)
        chargePortState = ChargePortState(rawValue: properties.first(for: 0x0B)?.monoValue)
        chargeMode = ChargeMode(rawValue: properties.first(for: 0x0C)?.monoValue)
        chargeTimer = ChargeTimer(properties.first(for: 0x0D)?.value ?? [])

        // Properties
        self.properties = properties
    }
}

extension Charging: Identifiable {

    public static var identifier: Identifier = Identifier(0x0023)
}

extension Charging: MessageTypesGettable {

    public enum MessageTypes: UInt8, MessageTypesKind {

        case getChargeState         = 0x00
        case chargeState            = 0x01
        case startStopCharging      = 0x02
        case setChargeLimit         = 0x03
        case openCloseChargePort    = 0x04
        case setChargeMode          = 0x05
        case setChargeTimer         = 0x06


        public static var all: [Charging.MessageTypes] {
            return [self.getChargeState,
                    self.chargeState,
                    self.startStopCharging,
                    self.setChargeLimit,
                    self.openCloseChargePort,
                    self.setChargeMode,
                    self.setChargeTimer]
        }
    }
}

public extension Charging {

    static var getChargeState: [UInt8] {
        return commandPrefix(for: .getChargeState)
    }

    static var openCloseChargePort: (ChargePortState) -> [UInt8] {
        return {
            return commandPrefix(for: .openCloseChargePort, additionalBytes: $0.rawValue)
        }
    }

    static var setChargeLimit: (PercentageInt) -> [UInt8] {
        return {
            return commandPrefix(for: .setChargeLimit, additionalBytes: $0)
        }
    }

    /// `.immediate` is not supported
    static var setChargeMode: (ChargeMode) -> [UInt8]? {
        return {
            guard $0 != .immediate else {
                return nil
            }

            return commandPrefix(for: .setChargeMode, additionalBytes: $0.rawValue)
        }
    }

    static var setChargeTimer: (ChargeTimer) -> [UInt8] {
        return {
            return commandPrefix(for: .setChargeTimer) + $0.propertyBytes(0x0D)
        }
    }

    /// Use `false` to *stop*.
    static var startCharging: (Bool) -> [UInt8] {
        return {
            return commandPrefix(for: .startStopCharging, additionalBytes: $0.byte)
        }
    }
}
