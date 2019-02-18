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


public class AADiagnostics: AACapabilityClass, AACapability {

    public let absState: AAProperty<AAActiveState>?
    public let adBlueLevel: AAProperty<Float>?
    public let batteryLevel: AAProperty<AAPercentage>?
    public let batteryVoltage: AAProperty<Float>?
    public let brakeFluidLevel: AAProperty<AAFluidLevel>?
    public let checkControlMessages: [AAProperty<AACheckControlMessage>]?
    public let distanceSinceReset: AAProperty<UInt16>?
    public let distanceSinceStart: AAProperty<UInt16>?
    public let engineCoolantTemperature: AAProperty<Int16>?
    public let engineLoad: AAProperty<AAPercentage>?
    public let engineOilTemperature: AAProperty<Int16>?
    public let engineTorque: AAProperty<AAPercentage>?
    public let engineTotalFuelConsumption: AAProperty<Float>?
    public let engineTotalOperatingHours: AAProperty<Float>?
    public let engineRPM: AAProperty<UInt16>?
    public let estimatedRange: AAProperty<UInt16>?
    public let fuelLevel: AAProperty<AAPercentage>?
    public let fuelVolume: AAProperty<Float>?
    public let mileage: AAProperty<UInt32>?
    public let mileageMeters: AAProperty<UInt32>?
    public let speed: AAProperty<Int16>?
    public let tirePressures: [AAProperty<AATirePressure>]?
    public let tireTemperatures: [AAProperty<AATireTemperature>]?
    public let troubleCodes: [AAProperty<AADiagnosticTroubleCode>]?
    public let washerFluidLevel: AAProperty<AAFluidLevel>?
    public let wheelBasedSpeed: AAProperty<Int16>?
    public let wheelRPMs: [AAProperty<AAWheelRPM>]?

    public var dieselExhaustFluid: AAProperty<Float>? {
        return adBlueLevel
    }


    // MARK: AACapability

    public static var identifier: AACommandIdentifier = 0x0033


    required init(properties: AAProperties) {
        // Ordered by the ID
        mileage = properties.property(forIdentifier: 0x01)
        engineOilTemperature = properties.property(forIdentifier: 0x02)
        speed = properties.property(forIdentifier: 0x03)
        engineRPM = properties.property(forIdentifier: 0x04)
        fuelLevel = properties.property(forIdentifier: 0x05)
        estimatedRange = properties.property(forIdentifier: 0x06)
        washerFluidLevel = properties.property(forIdentifier: 0x09)
        batteryVoltage = properties.property(forIdentifier: 0x0B)
        adBlueLevel = properties.property(forIdentifier: 0x0C)
        distanceSinceReset = properties.property(forIdentifier: 0x0D)
        distanceSinceStart = properties.property(forIdentifier: 0x0E)
        fuelVolume = properties.property(forIdentifier: 0x0F)
        absState = properties.property(forIdentifier: 0x10)
        engineCoolantTemperature = properties.property(forIdentifier: 0x11)
        engineTotalOperatingHours = properties.property(forIdentifier: 0x12)
        engineTotalFuelConsumption = properties.property(forIdentifier: 0x13)
        brakeFluidLevel = properties.property(forIdentifier: 0x14)
        engineTorque = properties.property(forIdentifier: 0x15)
        engineLoad = properties.property(forIdentifier: 0x16)
        wheelBasedSpeed = properties.property(forIdentifier: 0x17)
        /* Level 8 */
        batteryLevel = properties.property(forIdentifier: 0x18)
        checkControlMessages = properties.allOrNil(forIdentifier: 0x19)
        tirePressures = properties.allOrNil(forIdentifier: 0x1A)
        tireTemperatures = properties.allOrNil(forIdentifier: 0x1B)
        wheelRPMs = properties.allOrNil(forIdentifier: 0x1C)
        troubleCodes = properties.allOrNil(forIdentifier: 0x1D)
        /* Level 9 */
        mileageMeters = properties.property(forIdentifier: 0x1E)

        super.init(properties: properties)
    }
}

extension AADiagnostics: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getDiagnosticsState    = 0x00
        case diagnosticsState       = 0x01
    }
}

public extension AADiagnostics {

    static var getDiagnosticsState: AACommand {
        return command(forMessageType: .getDiagnosticsState)
    }
}
