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
//  Diagnostics.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 28/11/2017.
//

import Foundation


public struct Diagnostics: FullStandardCommand {

    public let adBlueLevel: Float?
    public let averageFuelConsumption: Float?
    public let batteryVoltage: Float?
    public let brakeFluidLevel: FluidLevel?
    public let currentFuelConsumption: Float?
    public let dieselExhaustFluid: Float?
    public let distanceSinceReset: UInt16?
    public let distanceSinceStart: UInt16?
    public let engineCoolantTemperature: Int16?
    public let engineLoad: PercentageInt?
    public let engineOilTemperature: Int16?
    public let engineTorque: PercentageInt?
    public let engineTotalFuelConsumption: Float?
    public let engineTotalOperatingHours: Float?
    public let engineRPM: UInt16?
    public let estimatedRange: UInt16?
    public let fuelLevel: PercentageInt?
    public let fuelVolume: Float?
    public let isABSActive: Bool?
    public let mileage: UInt32?
    public let mileageMeters: UInt32?
    public let speed: Int16?
    public let tires: [Tire]?
    public let washerFluidLevel: FluidLevel?
    public let wheelBasedSpeed: Int16?


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
        washerFluidLevel = properties.value(for: 0x09)
        tires = properties.flatMap(for: 0x0A) { Tire($0.value) }
        batteryVoltage = properties.value(for: 0x0B)
        adBlueLevel = properties.value(for: 0x0C)
        dieselExhaustFluid = adBlueLevel
        distanceSinceReset = properties.value(for: 0x0D)
        distanceSinceStart = properties.value(for: 0x0E)
        fuelVolume = properties.value(for: 0x0F)
        isABSActive = properties.value(for: 0x10)
        engineCoolantTemperature = properties.value(for: 0x11)
        engineTotalOperatingHours = properties.value(for: 0x12)
        engineTotalFuelConsumption = properties.value(for: 0x13)
        brakeFluidLevel = properties.value(for: 0x14)
        engineTorque = properties.value(for: 0x15)
        engineLoad = properties.value(for: 0x16)
        wheelBasedSpeed = properties.value(for: 0x17)
        mileageMeters = properties.value(for: 0x1E)

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
