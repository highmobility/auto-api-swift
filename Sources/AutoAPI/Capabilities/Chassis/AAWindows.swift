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
//  AAWindows.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/01/2020.
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
    public static func controlWindows(openPercentages: [AAWindowOpenPercentage]? = nil, positions: [AAWindowPosition]? = nil) -> Array<UInt8>? {
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