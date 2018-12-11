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
//  AAVehicleStatus.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 27/11/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct AAVehicleStatus: AAInboundCommand {

    public let brand: String?
    public let colourName: String?
    public let displayUnit: AADisplayUnit?
    public let driverSeatPosition: AADriverSeatLocation?
    public let engineVolume: Float?
    public let engineMaxTorque: UInt16?
    public let equipment: [String]?
    public let gearbox: AAGearbox?
    public let licensePlate: String?
    public let modelName: String?
    public let modelYear: UInt16?
    public let name: String?
    public let numberOfDoors: UInt8?
    public let numberOfSeats: UInt8?
    public let powerKW: UInt16?
    public let powerTrain: AAPowerTrain?
    public let salesDesignation: String?
    public let states: [AAVehicleState]?
    public let vin: String?


    // MARK: AAInboundCommand

    public let properties: AAProperties


    init?(_ messageType: UInt8, properties: AAProperties) {
        guard messageType == 0x01 else {
            return nil
        }

        let binaryTypes = AAAutoAPI.commands.compactMap { $0 as? AABinaryInitable.Type }

        // Ordered by the ID
        vin = String(bytes: properties.first(for: 0x01)?.value, encoding: .ascii)
        powerTrain = AAPowerTrain(rawValue: properties.first(for: 0x02)?.monoValue)
        modelName = properties.value(for: 0x03)
        name = properties.value(for: 0x04)
        licensePlate = properties.value(for: 0x05)
        salesDesignation = properties.value(for: 0x06)
        modelYear = properties.value(for: 0x07)
        colourName = properties.value(for: 0x08)
        powerKW = properties.value(for: 0x09)
        numberOfDoors = properties.value(for: 0x0A)
        numberOfSeats = properties.value(for: 0x0B)
        engineVolume = properties.value(for: 0x0C)
        engineMaxTorque = properties.value(for: 0x0D)
        gearbox = AAGearbox(rawValue: properties.first(for: 0x0E)?.monoValue)
        /* Level 8 */
        displayUnit = AADisplayUnit(rawValue: properties.first(for: 0x0F)?.monoValue)
        driverSeatPosition = AADriverSeatLocation(rawValue: properties.first(for: 0x10)?.monoValue)
        equipment = properties.flatMap(for: 0x11) { String(bytes: $0.value, encoding: .utf8)  }
        brand = properties.value(for: \AAVehicleStatus.brand)

        /* Special */
        states = properties.flatMap(for: 0x99) { property in
            binaryTypes.flatMapFirst { $0.init(property.value) as? AAVehicleState }
        }

        // Properties
        self.properties = properties
    }
}

extension AAVehicleStatus: AAIdentifiable {

    public static var identifier: AACommandIdentifier = 0x0011
}

extension AAVehicleStatus: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getVehicleStatus   = 0x00
        case vehicleStatus      = 0x01
    }
}

extension AAVehicleStatus: AAPropertyIdentifierGettable {

    static func propertyID<Type>(for keyPath: KeyPath<AAVehicleStatus, Type>) -> AAPropertyIdentifier {
        switch keyPath {
        case \AAVehicleStatus.vin:              return 0x01
        case \AAVehicleStatus.powerTrain:       return 0x02
        case \AAVehicleStatus.modelName:        return 0x03
        case \AAVehicleStatus.name:             return 0x04
        case \AAVehicleStatus.licensePlate:     return 0x05
        case \AAVehicleStatus.salesDesignation: return 0x06
        case \AAVehicleStatus.modelYear:        return 0x07
        case \AAVehicleStatus.colourName:       return 0x08
        case \AAVehicleStatus.powerKW:          return 0x09
        case \AAVehicleStatus.numberOfDoors:    return 0x0A
        case \AAVehicleStatus.numberOfSeats:    return 0x0B
        case \AAVehicleStatus.engineVolume:     return 0x0C
        case \AAVehicleStatus.engineMaxTorque:  return 0x0D
        case \AAVehicleStatus.gearbox:          return 0x0E
            /* Level 8 */
        case \AAVehicleStatus.displayUnit:          return 0x0F
        case \AAVehicleStatus.driverSeatPosition:   return 0x10
        case \AAVehicleStatus.equipment:            return 0x11
        case \AAVehicleStatus.brand:                return 0x12

            /* Special */
        case \AAVehicleStatus.states: return 0x99

        default:
            return 0x00
        }
    }
}


// MARK: Commands

public extension AAVehicleStatus {

    static var getVehicleStatus: [UInt8] {
        return commandPrefix(for: .getVehicleStatus)
    }
}
