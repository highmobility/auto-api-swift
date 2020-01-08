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
//  AACruiseControl.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation
import HMUtilities


public class AACruiseControl: AACapability {

    /// Limiter
    public enum Limiter: UInt8, AABytesConvertable {
        case notSet = 0x00
        case higherSpeedRequested = 0x01
        case lowerSpeedRequested = 0x02
        case speedFixed = 0x03
    }


    /// Property Identifiers for `AACruiseControl` capability.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case cruiseControl = 0x01
        case limiter = 0x02
        case targetSpeed = 0x03
        case adaptiveCruiseControl = 0x04
        case accTargetSpeed = 0x05
    }


    // MARK: Properties
    
    /// The target speed in km/h of the Adaptive Cruise Control
    ///
    /// - returns: `Int16` wrapped in `AAProperty<Int16>`
    public var accTargetSpeed: AAProperty<Int16>? {
        properties.property(forID: PropertyIdentifier.accTargetSpeed)
    }
    
    /// Adaptive cruise control
    ///
    /// - returns: `AAActiveState` wrapped in `AAProperty<AAActiveState>`
    public var adaptiveCruiseControl: AAProperty<AAActiveState>? {
        properties.property(forID: PropertyIdentifier.adaptiveCruiseControl)
    }
    
    /// Cruise control
    ///
    /// - returns: `AAActiveState` wrapped in `AAProperty<AAActiveState>`
    public var cruiseControl: AAProperty<AAActiveState>? {
        properties.property(forID: PropertyIdentifier.cruiseControl)
    }
    
    /// Limiter
    ///
    /// - returns: `Limiter` wrapped in `AAProperty<Limiter>`
    public var limiter: AAProperty<Limiter>? {
        properties.property(forID: PropertyIdentifier.limiter)
    }
    
    /// The target speed in km/h
    ///
    /// - returns: `Int16` wrapped in `AAProperty<Int16>`
    public var targetSpeed: AAProperty<Int16>? {
        properties.property(forID: PropertyIdentifier.targetSpeed)
    }


    // MARK: AAIdentifiable
    
    /// Capability's Identifier
    ///
    /// - returns: `UInt16` combining the MSB and LSB
    public override class var identifier: UInt16 {
        0x0062
    }


    // MARK: Getters
    
    /// Bytes for getting the `AACruiseControl` state.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *request* the state of `AACruiseControl`.
    ///
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func getCruiseControlState() -> Array<UInt8> {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.get.rawValue]
    }
    
    /// Bytes for getting the `AACruiseControl` state's **specific** properties.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *request* **specific** state properties of `AACruiseControl`.
    ///
    /// - parameters:
    ///   - propertyIDs: Array of requested property identifiers
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func getCruiseControlProperties(propertyIDs: PropertyIdentifier...) -> Array<UInt8> {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.get.rawValue] + propertyIDs.map { $0.rawValue }
    }


    // MARK: Setters
    
    /// Bytes for *activate deactivate cruise control* command.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *activate deactivate cruise control* in `AACruiseControl`.
    /// 
    /// - parameters:
    ///   - cruiseControl: cruise control as `AAActiveState`
    ///   - targetSpeed: The target speed in km/h as `Int16`
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func activateDeactivateCruiseControl(cruiseControl: AAActiveState, targetSpeed: Int16?) -> Array<UInt8> {
        let props1 = AAProperty(identifier: PropertyIdentifier.cruiseControl, value: cruiseControl).bytes + AAProperty(identifier: PropertyIdentifier.targetSpeed, value: targetSpeed).bytes
    
        return AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.set.rawValue] + props1
    }


    // MARK: AADebugTreeCapable
    
    public override var propertyNodes: [HMDebugTree] {
        [
            .node(label: "Adaptive Cruise Control (ACC) target speed", property: accTargetSpeed),
            .node(label: "Adaptive Cruise Control", property: adaptiveCruiseControl),
            .node(label: "Cruise control", property: cruiseControl),
            .node(label: "Limiter", property: limiter),
            .node(label: "Target speed", property: targetSpeed)
        ]
    }
}