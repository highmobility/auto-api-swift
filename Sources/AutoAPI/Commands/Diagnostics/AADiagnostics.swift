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

    public let absState: AAProperty<AAActiveState>?
    public let adBlueLevel: AAProperty<Float>?
    public let batteryLevel: AAProperty<AAPercentageInt>?
    public let batteryVoltage: AAProperty<Float>?
    public let brakeFluidLevel: AAProperty<AAFluidLevel>?
    public let checkControlMessages: [AAProperty<AACheckControlMessage>]?
    public let distanceSinceReset: AAProperty<UInt16>?
    public let distanceSinceStart: AAProperty<UInt16>?
    public let engineCoolantTemperature: AAProperty<Int16>?
    public let engineLoad: AAProperty<AAPercentageInt>?
    public let engineOilTemperature: AAProperty<Int16>?
    public let engineTorque: AAProperty<AAPercentageInt>?
    public let engineTotalFuelConsumption: AAProperty<Float>?
    public let engineTotalOperatingHours: AAProperty<Float>?
    public let engineRPM: AAProperty<UInt16>?
    public let estimatedRange: AAProperty<UInt16>?
    public let fuelLevel: AAProperty<AAPercentageInt>?
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


    // MARK: AAFullStandardCommand

    public let properties: AAProperties


    init?(properties: AAProperties) {
        // Ordered by the ID
        mileage = properties.property(for: \AADiagnostics.mileage)
        engineOilTemperature = properties.property(for: \AADiagnostics.engineOilTemperature)
        speed = properties.property(for: \AADiagnostics.speed)
        engineRPM = properties.property(for: \AADiagnostics.engineRPM)
        fuelLevel = properties.property(for: \AADiagnostics.fuelLevel)
        estimatedRange = properties.property(for: \AADiagnostics.estimatedRange)
        washerFluidLevel = properties.property(for: \AADiagnostics.washerFluidLevel)
        batteryVoltage = properties.property(for: \AADiagnostics.batteryVoltage)
        adBlueLevel = properties.property(for: \AADiagnostics.adBlueLevel)
        distanceSinceReset = properties.property(for: \AADiagnostics.distanceSinceReset)
        distanceSinceStart = properties.property(for: \AADiagnostics.distanceSinceStart)
        fuelVolume = properties.property(for: \AADiagnostics.fuelVolume)
        absState = properties.property(for: \AADiagnostics.absState)
        engineCoolantTemperature = properties.property(for: \AADiagnostics.engineCoolantTemperature)
        engineTotalOperatingHours = properties.property(for: \AADiagnostics.engineTotalOperatingHours)
        engineTotalFuelConsumption = properties.property(for: \AADiagnostics.engineTotalFuelConsumption)
        brakeFluidLevel = properties.property(for: \AADiagnostics.brakeFluidLevel)
        engineTorque = properties.property(for: \AADiagnostics.engineTorque)
        engineLoad = properties.property(for: \AADiagnostics.engineLoad)
        wheelBasedSpeed = properties.property(for: \AADiagnostics.wheelBasedSpeed)
        /* Level 8 */
        batteryLevel = properties.property(for: \AADiagnostics.batteryLevel)
        checkControlMessages = properties.properties(for: \AADiagnostics.checkControlMessages)
        tirePressures = properties.properties(for: \AADiagnostics.tirePressures)
        tireTemperatures = properties.properties(for: \AADiagnostics.tireTemperatures)
        wheelRPMs = properties.properties(for: \AADiagnostics.wheelRPMs)
        troubleCodes = properties.properties(for: \AADiagnostics.troubleCodes)
        /* Level 9 */
        mileageMeters = properties.property(for: \AADiagnostics.mileageMeters)

        // Properties
        self.properties = properties
    }
}

extension AADiagnostics: AAIdentifiable {

    public static var identifier: AACommandIdentifier = 0x0033
}

extension AADiagnostics: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getDiagnosticsState    = 0x00
        case diagnosticsState       = 0x01
    }
}

extension AADiagnostics: AAPropertyIdentifierGettable {

    static func propertyID<Type>(for keyPath: KeyPath<AADiagnostics, Type>) -> AAPropertyIdentifier? {
        switch keyPath {
        case \AADiagnostics.mileage:                    return 0x01
        case \AADiagnostics.engineOilTemperature:       return 0x02
        case \AADiagnostics.speed:                      return 0x03
        case \AADiagnostics.engineRPM:                  return 0x04
        case \AADiagnostics.fuelLevel:                  return 0x05
        case \AADiagnostics.estimatedRange:             return 0x06
        case \AADiagnostics.washerFluidLevel:           return 0x09
        case \AADiagnostics.batteryVoltage:             return 0x0B
        case \AADiagnostics.adBlueLevel:                return 0x0C
        case \AADiagnostics.distanceSinceReset:         return 0x0D
        case \AADiagnostics.distanceSinceStart:         return 0x0E
        case \AADiagnostics.fuelVolume:                 return 0x0F
        case \AADiagnostics.absState:                   return 0x10
        case \AADiagnostics.engineCoolantTemperature:   return 0x11
        case \AADiagnostics.engineTotalOperatingHours:  return 0x12
        case \AADiagnostics.engineTotalFuelConsumption: return 0x13
        case \AADiagnostics.brakeFluidLevel:            return 0x14
        case \AADiagnostics.engineTorque:               return 0x15
        case \AADiagnostics.engineLoad:                 return 0x16
        case \AADiagnostics.wheelBasedSpeed:            return 0x17
            /* Level 8 */
        case \AADiagnostics.batteryLevel:           return 0x18
        case \AADiagnostics.checkControlMessages:   return 0x19
        case \AADiagnostics.tirePressures:          return 0x1A
        case \AADiagnostics.tireTemperatures:       return 0x1B
        case \AADiagnostics.wheelRPMs:              return 0x1C
        case \AADiagnostics.troubleCodes:           return 0x1D
        case \AADiagnostics.mileageMeters:          return 0x1E

        default:
            return nil
        }
    }
}

public extension AADiagnostics {

    static var getDiagnosticsState: [UInt8] {
        return commandPrefix(for: .getDiagnosticsState)
    }
}
