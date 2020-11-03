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


public class AADoors: AACapability, __PropertyIdentifying {

    // MARK: AAPropertyIdentifying

    /// Property Identifiers for `AADoors` capability.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case insideLocks = 0x02
        case locks = 0x03
        case positions = 0x04
        case insideLocksState = 0x05
        case locksState = 0x06
    }


    // MARK: Properties

    public var insideLocks: [AAProperty<AALock>]? {
        properties(forID: .insideLocks)
    }

    public var insideLocksState: AAProperty<AALockState>? {
        property(forID: .insideLocksState)
    }

    public var locks: [AAProperty<AALock>]? {
        properties(forID: .locks)
    }

    public var locksState: AAProperty<AALockState>? {
        property(forID: .locksState)
    }

    public var positions: [AAProperty<AADoorPosition>]? {
        properties(forID: .positions)
    }


    // MARK: Identifier

    /// `AADoors` capability's identifier.
    ///
    /// - returns: `UInt16` combining the MSB and LSB
    public override class var identifier: UInt16 {
        0x0020
    }


    // MARK: Getters

    public static func getDoorsState() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes +
            Self.identifier.bytes +
            [AACommandType.get.rawValue]
    }

    public static func getDoorsProperties(propertyIDs: PropertyIdentifier...) -> [UInt8] {
        getDoorsState() + propertyIDs.map { $0.rawValue }
    }


    // MARK: Setters

    public static func lockUnlockDoors(locksState: AALockState) -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes +
            Self.identifier.bytes +
            [AACommandType.set.rawValue] +
            locksState.property(identifier: PropertyIdentifier.locksState).bytes
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
