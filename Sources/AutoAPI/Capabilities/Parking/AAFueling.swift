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
//  AAFueling.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation
import HMUtilities


public class AAFueling: AACapability {

    /// Property Identifiers for `AAFueling` capability.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case gasFlapLock = 0x02
        case gasFlapPosition = 0x03
    }


    // MARK: Properties
    
    /// Gas flap lock
    ///
    /// - returns: `AALockState` wrapped in `AAProperty<AALockState>`
    public var gasFlapLock: AAProperty<AALockState>? {
        properties.property(forID: PropertyIdentifier.gasFlapLock)
    }
    
    /// Gas flap position
    ///
    /// - returns: `AAPosition` wrapped in `AAProperty<AAPosition>`
    public var gasFlapPosition: AAProperty<AAPosition>? {
        properties.property(forID: PropertyIdentifier.gasFlapPosition)
    }


    // MARK: AAIdentifiable
    
    /// Capability's Identifier
    ///
    /// - returns: `UInt16` combining the MSB and LSB
    public override class var identifier: UInt16 {
        0x0040
    }


    // MARK: Getters
    
    /// Bytes for getting the `AAFueling` state.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *request* the state of `AAFueling`.
    ///
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func getGasFlapState() -> Array<UInt8> {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.get.rawValue]
    }
    
    /// Bytes for getting the `AAFueling` state's **specific** properties.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *request* **specific** state properties of `AAFueling`.
    ///
    /// - parameters:
    ///   - propertyIDs: Array of requested property identifiers
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func getGasFlapStateProperties(propertyIDs: PropertyIdentifier...) -> Array<UInt8> {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.get.rawValue] + propertyIDs.map { $0.rawValue }
    }


    // MARK: Setters
    
    /// Bytes for *control gas flap* command.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *control gas flap* in `AAFueling`.
    /// 
    /// - parameters:
    ///   - gasFlapLock: gas flap lock as `AALockState`
    ///   - gasFlapPosition: gas flap position as `AAPosition`
    /// - returns: Command's bytes as `Array<UInt8>?`
    public static func controlGasFlap(gasFlapLock: AALockState? = nil, gasFlapPosition: AAPosition? = nil) -> Array<UInt8>? {
        guard (gasFlapLock != nil || gasFlapPosition != nil) else {
            return nil
        }
    
        let props1 = AAProperty(identifier: PropertyIdentifier.gasFlapLock, value: gasFlapLock).bytes + AAProperty(identifier: PropertyIdentifier.gasFlapPosition, value: gasFlapPosition).bytes
    
        return AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.set.rawValue] + props1
    }


    // MARK: AADebugTreeCapable
    
    public override var propertyNodes: [HMDebugTree] {
        [
            .node(label: "Gas flap lock", property: gasFlapLock),
            .node(label: "Gas flap position", property: gasFlapPosition)
        ]
    }
}