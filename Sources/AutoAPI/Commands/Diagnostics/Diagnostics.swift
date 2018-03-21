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
//  Diagnostics.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 28/11/2017.
//  Copyright © 2017 High Mobility. All rights reserved.
//

import Foundation


public struct Diagnostics: FullStandardCommand {

    public let adBlueLevel: Float?
    public let averageFuelConsumption: Float?
    public let batteryVoltage: Float?
    public let currentFuelConsumption: Float?
    public let dieselExhaustFluid: Float?
    public let distanceSinceReset: UInt16?
    public let distanceSinceStart: UInt16?
    public let engineOilTemperature: Int16?
    public let engineRPM: UInt16?
    public let estimatedRange: UInt16?
    public let fuelLevel: UInt8?
    public let fuelVolume: Float?
    public let mileage: UInt32?
    public let speed: Int16?
    public let tires: [Tire]?
    public let washerFluidLevel: WasherFluidLevel?


    // MARK: FullStandardCommand

    public let properties: Properties


    init?(properties: Properties) {
        // Ordered by the ID
        mileage = properties.value(for: 0x01)
        engineOilTemperature = properties.value(for: 0x02)
        speed = properties.value(for: 0x03)
        engineRPM = properties.value(for: 0x04)
        fuelLevel = properties.value(for: 0x05)
        estimatedRange = properties.value(for: 0x06)
        currentFuelConsumption = properties.value(for: 0x07)
        averageFuelConsumption = properties.value(for: 0x08)
        washerFluidLevel = WasherFluidLevel(rawValue: properties.first(for: 0x09)?.monoValue)
        tires = properties.flatMap(for: 0x0A) { Tire($0.value) }
        batteryVoltage = properties.value(for: 0x0B)
        adBlueLevel = properties.value(for: 0x0C)
        dieselExhaustFluid = adBlueLevel
        distanceSinceReset = properties.value(for: 0x0D)
        distanceSinceStart = properties.value(for: 0x0E)
        fuelVolume = properties.value(for: 0x0F)

        // Properties
        self.properties = properties
    }
}

extension Diagnostics: Identifiable {

    public static var identifier: Identifier = Identifier(0x0033)
}

extension Diagnostics: MessageTypesGettable {

    public enum MessageTypes: UInt8, MessageTypesKind {

        case getDiagnosticsState    = 0x00
        case diagnosticsState       = 0x01


        public static var all: [Diagnostics.MessageTypes] {
            return [self.getDiagnosticsState,
                    self.diagnosticsState]
        }
    }
}

public extension Diagnostics {

    static var getDiagnosticsState: [UInt8] {
        return commandPrefix(for: .getDiagnosticsState)
    }
}
