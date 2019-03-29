//
// AutoAPI
// Copyright (C) 2019 High-Mobility GmbH
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
//  Copyright © 2019 High Mobility GmbH. All rights reserved.
//

import Foundation


public class AAVehicleStatus: AACapabilityClass, AACapability {

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
    public let states: [AACapability]?
    public let vin: AAProperty<String>?


    // MARK: AACapability

    public static var identifier: AACommandIdentifier = 0x0011


    required init(properties: AAProperties) {
        // Ordered by the ID
        vin = properties.property(forIdentifier: 0x01)
        powerTrain = properties.property(forIdentifier: 0x02)
        modelName = properties.property(forIdentifier: 0x03)
        name = properties.property(forIdentifier: 0x04)
        licensePlate = properties.property(forIdentifier: 0x05)
        salesDesignation = properties.property(forIdentifier: 0x06)
        modelYear = properties.property(forIdentifier: 0x07)
        colourName = properties.property(forIdentifier: 0x08)
        powerKW = properties.property(forIdentifier: 0x09)
        numberOfDoors = properties.property(forIdentifier: 0x0A)
        numberOfSeats = properties.property(forIdentifier: 0x0B)
        engineVolume = properties.property(forIdentifier: 0x0C)
        engineMaxTorque = properties.property(forIdentifier: 0x0D)
        gearbox = properties.property(forIdentifier: 0x0E)
        /* Level 8 */
        displayUnit = properties.property(forIdentifier: 0x0F)
        driverSeatPosition = properties.property(forIdentifier: 0x10)
        equipment = properties.allOrNil(forIdentifier: 0x11)
        /* Level 9 */
        brand = properties.property(forIdentifier: 0x12)

        /* Special */
        states = properties.filter {
            $0.identifier == 0x99
        }.compactMap {
            $0.valueBytes
        }.compactMap {
            AAAutoAPI.parseBinary($0)
        }

        super.init(properties: properties)
    }
}

extension AAVehicleStatus: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getVehicleStatus   = 0x00
        case vehicleStatus      = 0x01
    }
}

public extension AAVehicleStatus {

    static var getVehicleStatus: AACommand {
        return command(forMessageType: .getVehicleStatus)
    }
}
