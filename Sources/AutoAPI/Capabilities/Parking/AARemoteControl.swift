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
//  AARemoteControl.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/01/2020.
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
    
        static let start = Self.started
        static let abort = Self.aborted
        static let stop = Self.ended
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
    public static func controlCommand(angle: Int16? = nil, speed: Int8? = nil) -> Array<UInt8>? {
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