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
//  AAChassisSettings.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
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