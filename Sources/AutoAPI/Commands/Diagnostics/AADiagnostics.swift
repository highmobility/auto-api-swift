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
//  AADiagnostics.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 28/11/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct AADiagnostics: AAFullStandardCommand {

    public let absState: AAActiveState?
    public let adBlueLevel: Float?
    public let batteryLevel: AAPercentageInt?
    public let batteryVoltage: Float?
    public let brakeFluidLevel: AAFluidLevel?
    public let checkControlMessages: [AACheckControlMessage]?
    public let dieselExhaustFluid: Float?
    public let distanceSinceReset: UInt16?
    public let distanceSinceStart: UInt16?
    public let engineCoolantTemperature: Int16?
    public let engineLoad: AAPercentageInt?
    public let engineOilTemperature: Int16?
    public let engineTorque: AAPercentageInt?
    public let engineTotalFuelConsumption: Float?
    public let engineTotalOperatingHours: Float?
    public let engineRPM: UInt16?
    public let estimatedRange: UInt16?
    public let fuelLevel: AAPercentageInt?
    public let fuelVolume: Float?
    public let mileage: UInt32?
    public let speed: Int16?
    public let tirePressures: [AATirePressure]?
    public let tireTemperatures: [AATireTemperature]?
    public let washerFluidLevel: AAFluidLevel?
    public let wheelBasedSpeed: Int16?
    public let wheelRPMs: [AAWheelRPM]?


    // MARK: AAFullStandardCommand

    public let properties: AAProperties


    init?(properties: AAProperties) {
        // Ordered by the ID
        mileage = properties.value(for: 0x01)
        engineOilTemperature = properties.value(for: 0x02)
        speed = properties.value(for: 0x03)
        engineRPM = properties.value(for: 0x04)
        fuelLevel = properties.value(for: 0x05)
        estimatedRange = properties.value(for: 0x06)
        washerFluidLevel = properties.value(for: 0x09)
        batteryVoltage = properties.value(for: 0x0B)
        adBlueLevel = properties.value(for: 0x0C)
        dieselExhaustFluid = adBlueLevel
        distanceSinceReset = properties.value(for: 0x0D)
        distanceSinceStart = properties.value(for: 0x0E)
        fuelVolume = properties.value(for: 0x0F)
        absState = properties.value(for: 0x10)
        engineCoolantTemperature = properties.value(for: 0x11)
        engineTotalOperatingHours = properties.value(for: 0x12)
        engineTotalFuelConsumption = properties.value(for: 0x13)
        brakeFluidLevel = properties.value(for: 0x14)
        engineTorque = properties.value(for: 0x15)
        engineLoad = properties.value(for: 0x16)
        wheelBasedSpeed = properties.value(for: 0x17)
        /* Level 8 */
        batteryLevel = properties.value(for: 0x18)
        checkControlMessages = properties.flatMap(for: 0x19) { AACheckControlMessage($0.value) }
        tirePressures = properties.flatMap(for: 0x1A) { AATirePressure($0.value) }
        tireTemperatures = properties.flatMap(for: 0x1B) { AATireTemperature($0.value) }
        wheelRPMs = properties.flatMap(for: 0x1C) { AAWheelRPM($0.value) }

        // Properties
        self.properties = properties
    }
}

extension AADiagnostics: AAIdentifiable {

    public static var identifier: AACommandIdentifier = 0x0033
}

extension AADiagnostics: AALegacyGettable {

    public struct Legacy: AALegacyType {

        public let currentFuelConsumption: Float?
        public let averageFuelConsumption: Float?
        public let tires: [AATire]?


        // MARK: AALegacyType

        public typealias MessageTypes = AADiagnostics.MessageTypes


        public init(properties: AAProperties) {
            currentFuelConsumption = properties.value(for: 0x07)
            averageFuelConsumption = properties.value(for: 0x08)
            tires = properties.flatMap(for: 0x0A) { AATire($0.value) }
        }
    }
}

extension AADiagnostics: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getDiagnosticsState    = 0x00
        case diagnosticsState       = 0x01
    }
}


// MARK: Commands

public extension AADiagnostics {

    static var getDiagnosticsState: [UInt8] {
        return commandPrefix(for: .getDiagnosticsState)
    }
}
