//
// AutoAPI
// Copyright (C) 2020 High-Mobility GmbH
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
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation
import HMUtilities


public class AAVehicleStatus: AACapability {

    /// Display unit
    public enum DisplayUnit: UInt8, AABytesConvertable {
        case km = 0x00
        case miles = 0x01
    }
    
    /// Driver seat location
    public enum DriverSeatLocation: UInt8, AABytesConvertable {
        case left = 0x00
        case right = 0x01
        case center = 0x02
    }
    
    /// Gearbox
    public enum Gearbox: UInt8, AABytesConvertable {
        case manual = 0x00
        case automatic = 0x01
        case semiAutomatic = 0x02
    }
    
    /// Powertrain
    public enum Powertrain: UInt8, AABytesConvertable {
        case unknown = 0x00
        case allElectric = 0x01
        case combustionEngine = 0x02
        case phev = 0x03
        case hydrogen = 0x04
        case hydrogenHybrid = 0x05
    }


    /// Property Identifiers for `AAVehicleStatus` capability.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case vin = 0x01
        case powertrain = 0x02
        case modelName = 0x03
        case name = 0x04
        case licensePlate = 0x05
        case salesDesignation = 0x06
        case modelYear = 0x07
        case colourName = 0x08
        case powerInKW = 0x09
        case numberOfDoors = 0x0a
        case numberOfSeats = 0x0b
        case engineVolume = 0x0c
        case engineMaxTorque = 0x0d
        case gearbox = 0x0e
        case displayUnit = 0x0f
        case driverSeatLocation = 0x10
        case equipments = 0x11
        case brand = 0x12
        case states = 0x99
    }


    // MARK: Properties
    
    /// The car brand
    ///
    /// - returns: `String` wrapped in `AAProperty<String>`
    public var brand: AAProperty<String>? {
        properties.property(forID: PropertyIdentifier.brand)
    }
    
    /// The colour name
    ///
    /// - returns: `String` wrapped in `AAProperty<String>`
    public var colourName: AAProperty<String>? {
        properties.property(forID: PropertyIdentifier.colourName)
    }
    
    /// Display unit
    ///
    /// - returns: `DisplayUnit` wrapped in `AAProperty<DisplayUnit>`
    public var displayUnit: AAProperty<DisplayUnit>? {
        properties.property(forID: PropertyIdentifier.displayUnit)
    }
    
    /// Driver seat location
    ///
    /// - returns: `DriverSeatLocation` wrapped in `AAProperty<DriverSeatLocation>`
    public var driverSeatLocation: AAProperty<DriverSeatLocation>? {
        properties.property(forID: PropertyIdentifier.driverSeatLocation)
    }
    
    /// The maximum engine torque in Nm
    ///
    /// - returns: `UInt16` wrapped in `AAProperty<UInt16>`
    public var engineMaxTorque: AAProperty<UInt16>? {
        properties.property(forID: PropertyIdentifier.engineMaxTorque)
    }
    
    /// The engine volume displacement in liters
    ///
    /// - returns: `Float` wrapped in `AAProperty<Float>`
    public var engineVolume: AAProperty<Float>? {
        properties.property(forID: PropertyIdentifier.engineVolume)
    }
    
    /// Names of equipment the vehicle is equipped with
    ///
    /// - returns: Array of `String`-s wrapped in `[AAProperty<String>]`
    public var equipments: [AAProperty<String>]? {
        properties.properties(forID: PropertyIdentifier.equipments)
    }
    
    /// Gearbox
    ///
    /// - returns: `Gearbox` wrapped in `AAProperty<Gearbox>`
    public var gearbox: AAProperty<Gearbox>? {
        properties.property(forID: PropertyIdentifier.gearbox)
    }
    
    /// The license plate number
    ///
    /// - returns: `String` wrapped in `AAProperty<String>`
    public var licensePlate: AAProperty<String>? {
        properties.property(forID: PropertyIdentifier.licensePlate)
    }
    
    /// The car model name
    ///
    /// - returns: `String` wrapped in `AAProperty<String>`
    public var modelName: AAProperty<String>? {
        properties.property(forID: PropertyIdentifier.modelName)
    }
    
    /// The car model manufacturing year number
    ///
    /// - returns: `UInt16` wrapped in `AAProperty<UInt16>`
    public var modelYear: AAProperty<UInt16>? {
        properties.property(forID: PropertyIdentifier.modelYear)
    }
    
    /// The car name (nickname)
    ///
    /// - returns: `String` wrapped in `AAProperty<String>`
    public var name: AAProperty<String>? {
        properties.property(forID: PropertyIdentifier.name)
    }
    
    /// The number of doors
    ///
    /// - returns: `UInt8` wrapped in `AAProperty<UInt8>`
    public var numberOfDoors: AAProperty<UInt8>? {
        properties.property(forID: PropertyIdentifier.numberOfDoors)
    }
    
    /// The number of seats
    ///
    /// - returns: `UInt8` wrapped in `AAProperty<UInt8>`
    public var numberOfSeats: AAProperty<UInt8>? {
        properties.property(forID: PropertyIdentifier.numberOfSeats)
    }
    
    /// The power of the car measured in kW
    ///
    /// - returns: `UInt16` wrapped in `AAProperty<UInt16>`
    public var powerInKW: AAProperty<UInt16>? {
        properties.property(forID: PropertyIdentifier.powerInKW)
    }
    
    /// Powertrain
    ///
    /// - returns: `Powertrain` wrapped in `AAProperty<Powertrain>`
    public var powertrain: AAProperty<Powertrain>? {
        properties.property(forID: PropertyIdentifier.powertrain)
    }
    
    /// The sales designation of the model
    ///
    /// - returns: `String` wrapped in `AAProperty<String>`
    public var salesDesignation: AAProperty<String>? {
        properties.property(forID: PropertyIdentifier.salesDesignation)
    }
    
    /// The bytes of a Capability state
    ///
    /// - returns: Array of `AACapabilityState`-s wrapped in `[AAProperty<AACapabilityState>]`
    public var states: [AAProperty<AACapability>]? {
        let bytesProps: [AAProperty<AACapabilityState>]? = properties.properties(forID: PropertyIdentifier.states)
    
        return bytesProps?.compactMap {
            $0.transformValue {
                AAAutoAPI.parseBinary($0 ?? [])
            }
        }
    }
    
    /// The unique Vehicle Identification Number
    ///
    /// - returns: `String` wrapped in `AAProperty<String>`
    public var vin: AAProperty<String>? {
        properties.property(forID: PropertyIdentifier.vin)
    }


    // MARK: AAIdentifiable
    
    /// Capability's Identifier
    ///
    /// - returns: `UInt16` combining the MSB and LSB
    public override class var identifier: UInt16 {
        0x0011
    }


    // MARK: Getters
    
    /// Bytes for getting the `AAVehicleStatus` state.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *request* the state of `AAVehicleStatus`.
    ///
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func getVehicleStatus() -> Array<UInt8> {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.get.rawValue]
    }
    
    /// Bytes for getting the `AAVehicleStatus` state's **specific** properties.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *request* **specific** state properties of `AAVehicleStatus`.
    ///
    /// - parameters:
    ///   - propertyIDs: Array of requested property identifiers
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func getVehicleStatusProperties(propertyIDs: PropertyIdentifier...) -> Array<UInt8> {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.get.rawValue] + propertyIDs.map { $0.rawValue }
    }


    // MARK: AADebugTreeCapable
    
    public override var propertyNodes: [HMDebugTree] {
        [
            .node(label: "Brand", property: brand),
            .node(label: "Colour name", property: colourName),
            .node(label: "Display unit", property: displayUnit),
            .node(label: "Driver seat location", property: driverSeatLocation),
            .node(label: "Engine max torque", property: engineMaxTorque),
            .node(label: "Engine volume", property: engineVolume),
            .node(label: "Equipments", properties: equipments),
            .node(label: "Gearbox", property: gearbox),
            .node(label: "Licence plate", property: licensePlate),
            .node(label: "Model name", property: modelName),
            .node(label: "Model year", property: modelYear),
            .node(label: "Name", property: name),
            .node(label: "Number of doors", property: numberOfDoors),
            .node(label: "Number of seats", property: numberOfSeats),
            .node(label: "Power in kW", property: powerInKW),
            .node(label: "Powertrain", property: powertrain),
            .node(label: "Sales designation", property: salesDesignation),
            .node(label: "States", properties: states),
            .node(label: "VIN", property: vin)
        ]
    }
}