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
//  VehicleStatus.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 27/11/2017.
//

import Foundation


public struct VehicleStatus: InboundCommand {

    public let colourName: String?
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
    public let states: [VehicleState]?
    public let vin: String?


    // MARK: InboundCommand

    public let properties: Properties


    init?(_ messageType: UInt8, properties: Properties) {
        guard messageType == VehicleStatus.MessageTypes.vehicleStatus.rawValue else {
            return nil
        }

        let stateTypes = AAAutoAPI.commands.compactMap { $0 as? VehicleStateType.Type }

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

        states = properties.flatMap(for: 0x99) { property in
            stateTypes.flatMapFirst { $0.init(property.value) }
        }

        // Properties
        self.properties = properties
    }
}

extension VehicleStatus: Identifiable {

    public static var identifier: Identifier = Identifier(0x0011)
}

extension VehicleStatus: MessageTypesGettable {

    public enum MessageTypes: UInt8, MessageTypesKind {

        case getVehicleStatus   = 0x00
        case vehicleStatus      = 0x01


        public static var all: [VehicleStatus.MessageTypes] {
            return [self.getVehicleStatus,
                    self.vehicleStatus]
        }
    }
}

public extension VehicleStatus {

    static var getVehicleStatus: [UInt8] {
        return commandPrefix(for: .getVehicleStatus)
    }
}
