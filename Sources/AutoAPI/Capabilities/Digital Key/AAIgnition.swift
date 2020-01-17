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
//  AAIgnition.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation
import HMUtilities


public class AAIgnition: AACapability {

    /// Property Identifiers for `AAIgnition` capability.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case status = 0x01
        case accessoriesStatus = 0x02
    }


    // MARK: Properties
    
    /// Accessories status
    ///
    /// - returns: `AAOnOffState` wrapped in `AAProperty<AAOnOffState>`
    public var accessoriesStatus: AAProperty<AAOnOffState>? {
        properties.property(forID: PropertyIdentifier.accessoriesStatus)
    }
    
    /// Status
    ///
    /// - returns: `AAOnOffState` wrapped in `AAProperty<AAOnOffState>`
    public var status: AAProperty<AAOnOffState>? {
        properties.property(forID: PropertyIdentifier.status)
    }


    // MARK: AAIdentifiable
    
    /// Capability's Identifier
    ///
    /// - returns: `UInt16` combining the MSB and LSB
    public override class var identifier: UInt16 {
        0x0035
    }


    // MARK: Getters
    
    /// Bytes for getting the `AAIgnition` state.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *request* the state of `AAIgnition`.
    ///
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func getIgnitionState() -> Array<UInt8> {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.get.rawValue]
    }
    
    /// Bytes for getting the `AAIgnition` state's **specific** properties.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *request* **specific** state properties of `AAIgnition`.
    ///
    /// - parameters:
    ///   - propertyIDs: Array of requested property identifiers
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func getIgnitionProperties(propertyIDs: PropertyIdentifier...) -> Array<UInt8> {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.get.rawValue] + propertyIDs.map { $0.rawValue }
    }


    // MARK: Setters
    
    /// Bytes for *turn ignition on off* command.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *turn ignition on off* in `AAIgnition`.
    /// 
    /// - parameters:
    ///   - status: status as `AAOnOffState`
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func turnIgnitionOnOff(status: AAOnOffState) -> Array<UInt8> {
        return AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.set.rawValue] + AAProperty(identifier: PropertyIdentifier.status, value: status).bytes
    }


    // MARK: AADebugTreeCapable
    
    public override var propertyNodes: [HMDebugTree] {
        [
            .node(label: "Accessories status", property: accessoriesStatus),
            .node(label: "Status", property: status)
        ]
    }
}