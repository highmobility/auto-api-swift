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
    public let mileageMeters: UInt32?
    public let speed: Int16?
    public let tirePressures: [AATirePressure]?
    public let tireTemperatures: [AATireTemperature]?
    public let troubleCodes: [AADiagnosticTroubleCode]?
    public let washerFluidLevel: AAFluidLevel?
    public let wheelBasedSpeed: Int16?
    public let wheelRPMs: [AAWheelRPM]?

    public var dieselExhaustFluid: Float? {
        return adBlueLevel
    }


    // MARK: AAFullStandardCommand

    public let properties: AAProperties


    init?(properties: AAProperties) {
        // Ordered by the ID
        mileage = properties.value(for: \AADiagnostics.mileage)
        engineOilTemperature = properties.value(for: \AADiagnostics.engineOilTemperature)
        speed = properties.value(for: \AADiagnostics.speed)
        engineRPM = properties.value(for: \AADiagnostics.engineRPM)
        fuelLevel = properties.value(for: \AADiagnostics.fuelLevel)
        estimatedRange = properties.value(for: \AADiagnostics.estimatedRange)
        washerFluidLevel = properties.value(for: \AADiagnostics.washerFluidLevel)
        batteryVoltage = properties.value(for: \AADiagnostics.batteryVoltage)
        adBlueLevel = properties.value(for: \AADiagnostics.adBlueLevel)
        distanceSinceReset = properties.value(for: \AADiagnostics.distanceSinceReset)
        distanceSinceStart = properties.value(for: \AADiagnostics.distanceSinceStart)
        fuelVolume = properties.value(for: \AADiagnostics.fuelVolume)
        absState = properties.value(for: \AADiagnostics.absState)
        engineCoolantTemperature = properties.value(for: \AADiagnostics.engineCoolantTemperature)
        engineTotalOperatingHours = properties.value(for: \AADiagnostics.engineTotalOperatingHours)
        engineTotalFuelConsumption = properties.value(for: \AADiagnostics.engineTotalFuelConsumption)
        brakeFluidLevel = properties.value(for: \AADiagnostics.brakeFluidLevel)
        engineTorque = properties.value(for: \AADiagnostics.engineTorque)
        engineLoad = properties.value(for: \AADiagnostics.engineLoad)
        wheelBasedSpeed = properties.value(for: \AADiagnostics.wheelBasedSpeed)
        /* Level 8 */
        batteryLevel = properties.value(for: \AADiagnostics.batteryLevel)
        checkControlMessages = properties.flatMap(for: \AADiagnostics.checkControlMessages) { AACheckControlMessage($0.value) }
        tirePressures = properties.flatMap(for: \AADiagnostics.tirePressures) { AATirePressure($0.value) }
        tireTemperatures = properties.flatMap(for: \AADiagnostics.tireTemperatures) { AATireTemperature($0.value) }
        wheelRPMs = properties.flatMap(for: \AADiagnostics.wheelRPMs) { AAWheelRPM($0.value) }
        troubleCodes = properties.flatMap(for: \AADiagnostics.troubleCodes) { AADiagnosticTroubleCode($0.value) }
        mileageMeters = properties.value(for: \AADiagnostics.mileageMeters)

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

extension AADiagnostics: AAPropertyIdentifierGettable {

    static func propertyID<Type>(for keyPath: KeyPath<AADiagnostics, Type>) -> AAPropertyIdentifier {
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
            return 0x00
        }
    }
}


// MARK: Commands

public extension AADiagnostics {

    static var getDiagnosticsState: [UInt8] {
        return commandPrefix(for: .getDiagnosticsState)
    }
}
