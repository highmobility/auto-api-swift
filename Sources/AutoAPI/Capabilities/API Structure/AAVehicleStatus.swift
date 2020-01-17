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
//  AAVehicleStatus.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/01/2020.
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