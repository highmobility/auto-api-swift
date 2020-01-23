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
//  Climate.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 30/11/2017.
//

import Foundation


public struct Climate: FullStandardCommand {

    public let climateProfile: ClimateProfile?
    public let defrostingTemperature: Float?
    public let driverTemperature: Float?
    public let insideTemperature: Float?
    public let isDefoggingActive: Bool?
    public let isDefrostingActive: Bool?
    public let isHVACActive: Bool?
    public let isIonisingActive: Bool?
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
        isHVACActive = properties.value(for: 0x05)
        isDefoggingActive = properties.value(for: 0x06)
        isDefrostingActive = properties.value(for: 0x07)
        isIonisingActive = properties.value(for: 0x08)
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

    struct Settings {
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

    /// Use `false` to *stop*.
    static var startDefogging: (Bool) -> [UInt8] {
        return {
            return commandPrefix(for: .startStopDefogging, additionalBytes: $0.byte)
        }
    }

    /// Use `false` to *stop*.
    static var startDefrosting: (Bool) -> [UInt8] {
        return {
            return commandPrefix(for: .startStopDefrosting, additionalBytes: $0.byte)
        }
    }

    /// Use `false` to *stop*.
    static var startHVAC: (Bool) -> [UInt8] {
        return {
            return commandPrefix(for: .startStopHVAC, additionalBytes: $0.byte)
        }
    }

    /// Use `false` to *stop*.
    static var startIonising: (Bool) -> [UInt8] {
        return {
            return commandPrefix(for: .startStopIonising, additionalBytes: $0.byte)
        }
    }
}
