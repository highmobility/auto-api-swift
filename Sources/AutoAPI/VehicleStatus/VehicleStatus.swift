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
//  VehicleStatus.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 27/11/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct VehicleStatus: AAInboundCommand {

    public let colourName: String?
    public let displayUnit: DisplayUnit?
    public let engineVolume: Float?
    public let engineMaxTorque: UInt16?
    public let gearbox: Gearbox?
    public let licensePlate: String?
    public let modelName: String?
    public let modelYear: UInt16?
    public let name: String?
    public let numberOfDoors: UInt8?
    public let numberOfSeats: UInt8?
    public let powerKW: UInt16?
    public let powerTrain: PowerTrain?
    public let salesDesignation: String?
    public let states: [AAVehicleState]?
    public let vin: String?


    // MARK: AAInboundCommand

    public let properties: AAProperties


    init?(_ messageType: UInt8, properties: AAProperties) {
        guard messageType == 0x01 else {
            return nil
        }

        let binaryTypes = AutoAPI.commands.compactMap { $0 as? AABinaryInitable.Type }

        // Ordered by the ID
        vin = String(bytes: properties.first(for: 0x01)?.value, encoding: .ascii)
        powerTrain = PowerTrain(rawValue: properties.first(for: 0x02)?.monoValue)
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
        gearbox = Gearbox(rawValue: properties.first(for: 0x0E)?.monoValue)
        displayUnit = DisplayUnit(rawValue: properties.first(for: 0x0F)?.monoValue)

        states = properties.flatMap(for: 0x99) { property in
            binaryTypes.flatMapFirst { $0.init(property.value) as? AAVehicleState }
        }

        // Properties
        self.properties = properties
    }
}

extension VehicleStatus: AAIdentifiable {

    public static var identifier: AACommandIdentifier = AACommandIdentifier(0x0011)
}

extension VehicleStatus: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getVehicleStatus   = 0x00
        case vehicleStatus      = 0x01
    }
}

public extension VehicleStatus {

    static var getVehicleStatus: [UInt8] {
        return commandPrefix(for: .getVehicleStatus)
    }
}
