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

    public let brand: AAProperty<String>?
    public let colourName: AAProperty<String>?
    public let displayUnit: AAProperty<AADisplayUnit>?
    public let driverSeatPosition: AAProperty<AADriverSeatLocation>?
    public let engineVolume: AAProperty<Float>?
    public let engineMaxTorque: AAProperty<UInt16>?
    public let equipment: [AAProperty<String>]?
    public let gearbox: AAProperty<AAGearbox>?
    public let licensePlate: AAProperty<String>?
    public let modelName: AAProperty<String>?
    public let modelYear: AAProperty<UInt16>?
    public let name: AAProperty<String>?
    public let numberOfDoors: AAProperty<UInt8>?
    public let numberOfSeats: AAProperty<UInt8>?
    public let powerKW: AAProperty<UInt16>?
    public let powerTrain: AAProperty<AAPowerTrain>?
    public let salesDesignation: AAProperty<String>?
    public let states: [AAProperty<AAVehicleState>]?
    public let vin: AAProperty<String>?


    // MARK: AAInboundCommand

    public let properties: AAProperties


    init?(_ messageType: UInt8, properties: AAProperties) {
        guard messageType == 0x01 else {
            return nil
        }

        let binaryTypes = AAAutoAPI.commands.compactMap { $0 as? AABinaryInitable.Type }

        // Ordered by the ID
        vin = properties.properties(for: \AAVehicleStatus.vin) { String(bytes: $0, encoding: .ascii) }?.first
        powerTrain = properties.property(for: \AAVehicleStatus.powerTrain)
        modelName = properties.property(for: \AAVehicleStatus.modelName)
        name = properties.property(for: \AAVehicleStatus.name)
        licensePlate = properties.property(for: \AAVehicleStatus.licensePlate)
        salesDesignation = properties.property(for: \AAVehicleStatus.salesDesignation)
        modelYear = properties.property(for: \AAVehicleStatus.modelYear)
        colourName = properties.property(for: \AAVehicleStatus.colourName)
        powerKW = properties.property(for: \AAVehicleStatus.powerKW)
        numberOfDoors = properties.property(for: \AAVehicleStatus.numberOfDoors)
        numberOfSeats = properties.property(for: \AAVehicleStatus.numberOfSeats)
        engineVolume = properties.property(for: \AAVehicleStatus.engineVolume)
        engineMaxTorque = properties.property(for: \AAVehicleStatus.engineMaxTorque)
        gearbox = properties.property(for: \AAVehicleStatus.gearbox)
        /* Level 8 */
        displayUnit = properties.property(for: \AAVehicleStatus.displayUnit)
        driverSeatPosition = properties.property(for: \AAVehicleStatus.driverSeatPosition)
        equipment = properties.properties(for: \AAVehicleStatus.equipment)
        /* Level 9 */
        brand = properties.property(for: \AAVehicleStatus.brand)

        /* Special */
        states = properties.properties(for: \AAVehicleStatus.states) { bytes in
            binaryTypes.flatMapFirst { $0.init(bytes) as? AAVehicleState }
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

    static func propertyID<Type>(for keyPath: KeyPath<AAVehicleStatus, Type>) -> AAPropertyIdentifier? {
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

            /* Level 9 */
        case \AAVehicleStatus.brand: return 0x12

            /* Special */
        case \AAVehicleStatus.states: return 0x99

        default:
            return nil
        }
    }
}
 

public extension AAVehicleStatus {

    static var getVehicleStatus: [UInt8] {
        return commandPrefix(for: .getVehicleStatus)
    }
}
