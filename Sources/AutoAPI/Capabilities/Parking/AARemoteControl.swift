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
//  AARemoteControl.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation
import HMUtilities


public class AARemoteControl: AACapability {

    /// Control mode
    public enum ControlMode: UInt8, AABytesConvertable {
        case unavailable = 0x00
        case available = 0x01
        case started = 0x02
        case failedToStart = 0x03
        case aborted = 0x04
        case ended = 0x05
    }


    /// Property Identifiers for `AARemoteControl` capability.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case controlMode = 0x01
        case angle = 0x02
        case speed = 0x03
    }


    // MARK: Properties
    
    /// Wheel base angle in degrees
    ///
    /// - returns: `Int16` wrapped in `AAProperty<Int16>`
    public var angle: AAProperty<Int16>? {
        properties.property(forID: PropertyIdentifier.angle)
    }
    
    /// Control mode
    ///
    /// - returns: `ControlMode` wrapped in `AAProperty<ControlMode>`
    public var controlMode: AAProperty<ControlMode>? {
        properties.property(forID: PropertyIdentifier.controlMode)
    }


    // MARK: AAIdentifiable
    
    /// Capability's Identifier
    ///
    /// - returns: `UInt16` combining the MSB and LSB
    public override class var identifier: UInt16 {
        0x0027
    }


    // MARK: Getters
    
    /// Bytes for getting the `AARemoteControl` state.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *request* the state of `AARemoteControl`.
    ///
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func getControlState() -> Array<UInt8> {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.get.rawValue]
    }


    // MARK: Setters
    
    /// Bytes for *control command* command.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *control command* in `AARemoteControl`.
    /// 
    /// - parameters:
    ///   - angle: Wheel base angle in degrees as `Int16`
    ///   - speed: Speed in km/h as `Int8`
    /// - returns: Command's bytes as `Array<UInt8>?`
    public static func controlCommand(angle: Int16?, speed: Int8?) -> Array<UInt8>? {
        guard (angle != nil || speed != nil) else {
            return nil
        }
    
        let props1 = AAProperty(identifier: PropertyIdentifier.angle, value: angle).bytes + AAProperty(identifier: PropertyIdentifier.speed, value: speed).bytes
    
        return AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.set.rawValue] + props1
    }
    
    /// Bytes for *start control* command.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *start control* in `AARemoteControl`.
    /// 
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func startControl() -> Array<UInt8> {
        return AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.set.rawValue] + AAProperty(identifier: PropertyIdentifier.controlMode, value: ControlMode(bytes: [0x02])).bytes
    }
    
    /// Bytes for *stop control* command.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *stop control* in `AARemoteControl`.
    /// 
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func stopControl() -> Array<UInt8> {
        return AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.set.rawValue] + AAProperty(identifier: PropertyIdentifier.controlMode, value: ControlMode(bytes: [0x05])).bytes
    }


    // MARK: AADebugTreeCapable
    
    public override var propertyNodes: [HMDebugTree] {
        [
            .node(label: "Angle", property: angle),
            .node(label: "Control mode", property: controlMode)
        ]
    }
}