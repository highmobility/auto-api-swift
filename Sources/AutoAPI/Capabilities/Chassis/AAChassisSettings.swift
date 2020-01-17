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
//  AAChassisSettings.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation
import HMUtilities


public class AAChassisSettings: AACapability {

    /// Sport chrono
    public enum SportChrono: UInt8, AABytesConvertable {
        case inactive = 0x00
        case active = 0x01
        case reset = 0x02
    
        static let stop = Self.inactive
        static let start = Self.active
    }


    /// Property Identifiers for `AAChassisSettings` capability.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case drivingMode = 0x01
        case sportChrono = 0x02
        case currentSpringRates = 0x05
        case maximumSpringRates = 0x06
        case minimumSpringRates = 0x07
        case currentChassisPosition = 0x08
        case maximumChassisPosition = 0x09
        case minimumChassisPosition = 0x0a
    }


    // MARK: Properties
    
    /// The chassis position in mm calculated from the lowest point
    ///
    /// - returns: `Int8` wrapped in `AAProperty<Int8>`
    public var currentChassisPosition: AAProperty<Int8>? {
        properties.property(forID: PropertyIdentifier.currentChassisPosition)
    }
    
    /// The current values for the spring rates
    ///
    /// - returns: Array of `AASpringRate`-s wrapped in `[AAProperty<AASpringRate>]`
    public var currentSpringRates: [AAProperty<AASpringRate>]? {
        properties.properties(forID: PropertyIdentifier.currentSpringRates)
    }
    
    /// Driving mode
    ///
    /// - returns: `AADrivingMode` wrapped in `AAProperty<AADrivingMode>`
    public var drivingMode: AAProperty<AADrivingMode>? {
        properties.property(forID: PropertyIdentifier.drivingMode)
    }
    
    /// The maximum possible value for the chassis position
    ///
    /// - returns: `Int8` wrapped in `AAProperty<Int8>`
    public var maximumChassisPosition: AAProperty<Int8>? {
        properties.property(forID: PropertyIdentifier.maximumChassisPosition)
    }
    
    /// The maximum possible values for the spring rates
    ///
    /// - returns: Array of `AASpringRate`-s wrapped in `[AAProperty<AASpringRate>]`
    public var maximumSpringRates: [AAProperty<AASpringRate>]? {
        properties.properties(forID: PropertyIdentifier.maximumSpringRates)
    }
    
    /// The minimum possible value for the chassis position
    ///
    /// - returns: `Int8` wrapped in `AAProperty<Int8>`
    public var minimumChassisPosition: AAProperty<Int8>? {
        properties.property(forID: PropertyIdentifier.minimumChassisPosition)
    }
    
    /// The minimum possible values for the spring rates
    ///
    /// - returns: Array of `AASpringRate`-s wrapped in `[AAProperty<AASpringRate>]`
    public var minimumSpringRates: [AAProperty<AASpringRate>]? {
        properties.properties(forID: PropertyIdentifier.minimumSpringRates)
    }
    
    /// Sport chrono
    ///
    /// - returns: `SportChrono` wrapped in `AAProperty<SportChrono>`
    public var sportChrono: AAProperty<SportChrono>? {
        properties.property(forID: PropertyIdentifier.sportChrono)
    }


    // MARK: AAIdentifiable
    
    /// Capability's Identifier
    ///
    /// - returns: `UInt16` combining the MSB and LSB
    public override class var identifier: UInt16 {
        0x0053
    }


    // MARK: Getters
    
    /// Bytes for getting the `AAChassisSettings` state.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *request* the state of `AAChassisSettings`.
    ///
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func getChassisSettings() -> Array<UInt8> {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.get.rawValue]
    }
    
    /// Bytes for getting the `AAChassisSettings` state's **specific** properties.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *request* **specific** state properties of `AAChassisSettings`.
    ///
    /// - parameters:
    ///   - propertyIDs: Array of requested property identifiers
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func getChassisSettingsProperties(propertyIDs: PropertyIdentifier...) -> Array<UInt8> {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.get.rawValue] + propertyIDs.map { $0.rawValue }
    }


    // MARK: Setters
    
    /// Bytes for *set driving mode* command.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *set driving mode* in `AAChassisSettings`.
    /// 
    /// - parameters:
    ///   - drivingMode: driving mode as `AADrivingMode`
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func setDrivingMode(drivingMode: AADrivingMode) -> Array<UInt8> {
        return AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.set.rawValue] + AAProperty(identifier: PropertyIdentifier.drivingMode, value: drivingMode).bytes
    }
    
    /// Bytes for *start stop sports chrono* command.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *start stop sports chrono* in `AAChassisSettings`.
    /// 
    /// - parameters:
    ///   - sportChrono: sport chrono as `SportChrono`
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func startStopSportsChrono(sportChrono: SportChrono) -> Array<UInt8> {
        return AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.set.rawValue] + AAProperty(identifier: PropertyIdentifier.sportChrono, value: sportChrono).bytes
    }
    
    /// Bytes for *set spring rates* command.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *set spring rates* in `AAChassisSettings`.
    /// 
    /// - parameters:
    ///   - currentSpringRates: The current values for the spring rates as `[AASpringRate]`
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func setSpringRates(currentSpringRates: [AASpringRate]) -> Array<UInt8> {
        return AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.set.rawValue] + AAProperty.multiple(identifier: PropertyIdentifier.currentSpringRates, values: currentSpringRates).flatMap { $0.bytes }
    }
    
    /// Bytes for *set chassis position* command.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *set chassis position* in `AAChassisSettings`.
    /// 
    /// - parameters:
    ///   - currentChassisPosition: The chassis position in mm calculated from the lowest point as `Int8`
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func setChassisPosition(currentChassisPosition: Int8) -> Array<UInt8> {
        return AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.set.rawValue] + AAProperty(identifier: PropertyIdentifier.currentChassisPosition, value: currentChassisPosition).bytes
    }


    // MARK: AADebugTreeCapable
    
    public override var propertyNodes: [HMDebugTree] {
        [
            .node(label: "Current chassis position", property: currentChassisPosition),
            .node(label: "Current spring rates", properties: currentSpringRates),
            .node(label: "Driving mode", property: drivingMode),
            .node(label: "Maximum chassis position", property: maximumChassisPosition),
            .node(label: "Maximum spring rates", properties: maximumSpringRates),
            .node(label: "Minimum chassis position", property: minimumChassisPosition),
            .node(label: "Minimum spring rates", properties: minimumSpringRates),
            .node(label: "Sport chrono", property: sportChrono)
        ]
    }
}