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
//  AAWindows.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation
import HMUtilities


public class AAWindows: AACapability {

    /// Property Identifiers for `AAWindows` capability.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case openPercentages = 0x02
        case positions = 0x03
    }


    // MARK: Properties
    
    /// Open percentages
    ///
    /// - returns: Array of `AAWindowOpenPercentage`-s wrapped in `[AAProperty<AAWindowOpenPercentage>]`
    public var openPercentages: [AAProperty<AAWindowOpenPercentage>]? {
        properties.properties(forID: PropertyIdentifier.openPercentages)
    }
    
    /// Positions
    ///
    /// - returns: Array of `AAWindowPosition`-s wrapped in `[AAProperty<AAWindowPosition>]`
    public var positions: [AAProperty<AAWindowPosition>]? {
        properties.properties(forID: PropertyIdentifier.positions)
    }


    // MARK: AAIdentifiable
    
    /// Capability's Identifier
    ///
    /// - returns: `UInt16` combining the MSB and LSB
    public override class var identifier: UInt16 {
        0x0045
    }


    // MARK: Getters
    
    /// Bytes for getting the `AAWindows` state.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *request* the state of `AAWindows`.
    ///
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func getWindows() -> Array<UInt8> {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.get.rawValue]
    }
    
    /// Bytes for getting the `AAWindows` state's **specific** properties.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *request* **specific** state properties of `AAWindows`.
    ///
    /// - parameters:
    ///   - propertyIDs: Array of requested property identifiers
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func getWindowsProperties(propertyIDs: PropertyIdentifier...) -> Array<UInt8> {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.get.rawValue] + propertyIDs.map { $0.rawValue }
    }


    // MARK: Setters
    
    /// Bytes for *control windows* command.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *control windows* in `AAWindows`.
    /// 
    /// - parameters:
    ///   - openPercentages: open percentages as `[AAWindowOpenPercentage]`
    ///   - positions: positions as `[AAWindowPosition]`
    /// - returns: Command's bytes as `Array<UInt8>?`
    public static func controlWindows(openPercentages: [AAWindowOpenPercentage]?, positions: [AAWindowPosition]?) -> Array<UInt8>? {
        guard (openPercentages != nil || positions != nil) else {
            return nil
        }
    
        let props1 = AAProperty.multiple(identifier: PropertyIdentifier.openPercentages, values: openPercentages).flatMap { $0.bytes } + AAProperty.multiple(identifier: PropertyIdentifier.positions, values: positions).flatMap { $0.bytes }
    
        return AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.set.rawValue] + props1
    }


    // MARK: AADebugTreeCapable
    
    public override var propertyNodes: [HMDebugTree] {
        [
            .node(label: "Open percentages", properties: openPercentages),
            .node(label: "Positions", properties: positions)
        ]
    }
}