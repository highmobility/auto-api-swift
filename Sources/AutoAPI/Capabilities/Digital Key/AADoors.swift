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
//  AADoors.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
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