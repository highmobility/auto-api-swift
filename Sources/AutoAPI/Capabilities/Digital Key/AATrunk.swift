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
//  AATrunk.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation
import HMUtilities


public class AATrunk: AACapability {

    /// Property Identifiers for `AATrunk` capability.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case lock = 0x01
        case position = 0x02
    }


    // MARK: Properties
    
    /// Lock
    ///
    /// - returns: `AALockState` wrapped in `AAProperty<AALockState>`
    public var lock: AAProperty<AALockState>? {
        properties.property(forID: PropertyIdentifier.lock)
    }
    
    /// Position
    ///
    /// - returns: `AAPosition` wrapped in `AAProperty<AAPosition>`
    public var position: AAProperty<AAPosition>? {
        properties.property(forID: PropertyIdentifier.position)
    }


    // MARK: AAIdentifiable
    
    /// Capability's Identifier
    ///
    /// - returns: `UInt16` combining the MSB and LSB
    public override class var identifier: UInt16 {
        0x0021
    }


    // MARK: Getters
    
    /// Bytes for getting the `AATrunk` state.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *request* the state of `AATrunk`.
    ///
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func getTrunkState() -> Array<UInt8> {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.get.rawValue]
    }
    
    /// Bytes for getting the `AATrunk` state's **specific** properties.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *request* **specific** state properties of `AATrunk`.
    ///
    /// - parameters:
    ///   - propertyIDs: Array of requested property identifiers
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func getTrunkProperties(propertyIDs: PropertyIdentifier...) -> Array<UInt8> {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.get.rawValue] + propertyIDs.map { $0.rawValue }
    }


    // MARK: Setters
    
    /// Bytes for *control trunk* command.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *control trunk* in `AATrunk`.
    /// 
    /// - parameters:
    ///   - lock: lock as `AALockState`
    ///   - position: position as `AAPosition`
    /// - returns: Command's bytes as `Array<UInt8>?`
    public static func controlTrunk(lock: AALockState? = nil, position: AAPosition? = nil) -> Array<UInt8>? {
        guard (lock != nil || position != nil) else {
            return nil
        }
    
        let props1 = AAProperty(identifier: PropertyIdentifier.lock, value: lock).bytes + AAProperty(identifier: PropertyIdentifier.position, value: position).bytes
    
        return AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.set.rawValue] + props1
    }


    // MARK: AADebugTreeCapable
    
    public override var propertyNodes: [HMDebugTree] {
        [
            .node(label: "Lock", property: lock),
            .node(label: "Position", property: position)
        ]
    }
}