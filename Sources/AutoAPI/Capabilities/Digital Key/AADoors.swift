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
//  AADoors.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation
import HMUtilities


public class AADoors: AACapability {

    /// Property Identifiers for `AADoors` capability.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case insideLocks = 0x02
        case locks = 0x03
        case positions = 0x04
        case insideLocksState = 0x05
        case locksState = 0x06
    }


    // MARK: Properties
    
    /// Inside lock states for the given doors
    ///
    /// - returns: Array of `AALock`-s wrapped in `[AAProperty<AALock>]`
    public var insideLocks: [AAProperty<AALock>]? {
        properties.properties(forID: PropertyIdentifier.insideLocks)
    }
    
    /// Inside locks state for the whole car (combines all specific lock states if available)
    ///
    /// - returns: `AALockState` wrapped in `AAProperty<AALockState>`
    public var insideLocksState: AAProperty<AALockState>? {
        properties.property(forID: PropertyIdentifier.insideLocksState)
    }
    
    /// Lock states for the given doors
    ///
    /// - returns: Array of `AALock`-s wrapped in `[AAProperty<AALock>]`
    public var locks: [AAProperty<AALock>]? {
        properties.properties(forID: PropertyIdentifier.locks)
    }
    
    /// Locks state for the whole car (combines all specific lock states if available)
    ///
    /// - returns: `AALockState` wrapped in `AAProperty<AALockState>`
    public var locksState: AAProperty<AALockState>? {
        properties.property(forID: PropertyIdentifier.locksState)
    }
    
    /// Door positions for the given doors
    ///
    /// - returns: Array of `AADoorPosition`-s wrapped in `[AAProperty<AADoorPosition>]`
    public var positions: [AAProperty<AADoorPosition>]? {
        properties.properties(forID: PropertyIdentifier.positions)
    }


    // MARK: AAIdentifiable
    
    /// Capability's Identifier
    ///
    /// - returns: `UInt16` combining the MSB and LSB
    public override class var identifier: UInt16 {
        0x0020
    }


    // MARK: Getters
    
    /// Bytes for getting the `AADoors` state.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *request* the state of `AADoors`.
    ///
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func getDoorsState() -> Array<UInt8> {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.get.rawValue]
    }
    
    /// Bytes for getting the `AADoors` state's **specific** properties.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *request* **specific** state properties of `AADoors`.
    ///
    /// - parameters:
    ///   - propertyIDs: Array of requested property identifiers
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func getDoorsProperties(propertyIDs: PropertyIdentifier...) -> Array<UInt8> {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.get.rawValue] + propertyIDs.map { $0.rawValue }
    }


    // MARK: Setters
    
    /// Bytes for *lock unlock doors* command.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *lock unlock doors* in `AADoors`.
    /// 
    /// - parameters:
    ///   - locksState: Locks state for the whole car (combines all specific lock states if available) as `AALockState`
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func lockUnlockDoors(locksState: AALockState) -> Array<UInt8> {
        return AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.set.rawValue] + AAProperty(identifier: PropertyIdentifier.locksState, value: locksState).bytes
    }


    // MARK: AADebugTreeCapable
    
    public override var propertyNodes: [HMDebugTree] {
        [
            .node(label: "Inside locks", properties: insideLocks),
            .node(label: "Inside locks state", property: insideLocksState),
            .node(label: "Locks", properties: locks),
            .node(label: "Locks state", property: locksState),
            .node(label: "Positions", properties: positions)
        ]
    }
}