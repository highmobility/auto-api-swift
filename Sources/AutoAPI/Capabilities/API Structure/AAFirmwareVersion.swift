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
//  AAFirmwareVersion.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation
import HMUtilities


public class AAFirmwareVersion: AACapability {

    /// Property Identifiers for `AAFirmwareVersion` capability.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case hmKitVersion = 0x01
        case hmKitBuildName = 0x02
        case applicationVersion = 0x03
    }


    // MARK: Properties
    
    /// Application version
    ///
    /// - returns: `String` wrapped in `AAProperty<String>`
    public var applicationVersion: AAProperty<String>? {
        properties.property(forID: PropertyIdentifier.applicationVersion)
    }
    
    /// HMKit version build name
    ///
    /// - returns: `String` wrapped in `AAProperty<String>`
    public var hmKitBuildName: AAProperty<String>? {
        properties.property(forID: PropertyIdentifier.hmKitBuildName)
    }
    
    /// HMKit version
    ///
    /// - returns: `AAHMKitVersion` wrapped in `AAProperty<AAHMKitVersion>`
    public var hmKitVersion: AAProperty<AAHMKitVersion>? {
        properties.property(forID: PropertyIdentifier.hmKitVersion)
    }


    // MARK: AAIdentifiable
    
    /// Capability's Identifier
    ///
    /// - returns: `UInt16` combining the MSB and LSB
    public override class var identifier: UInt16 {
        0x0003
    }


    // MARK: Getters
    
    /// Bytes for getting the `AAFirmwareVersion` state.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *request* the state of `AAFirmwareVersion`.
    ///
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func getFirmwareVersion() -> Array<UInt8> {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.get.rawValue]
    }
    
    /// Bytes for getting the `AAFirmwareVersion` state's **specific** properties.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *request* **specific** state properties of `AAFirmwareVersion`.
    ///
    /// - parameters:
    ///   - propertyIDs: Array of requested property identifiers
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func getFirmwareVersionProperties(propertyIDs: PropertyIdentifier...) -> Array<UInt8> {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.get.rawValue] + propertyIDs.map { $0.rawValue }
    }


    // MARK: AADebugTreeCapable
    
    public override var propertyNodes: [HMDebugTree] {
        [
            .node(label: "Application version", property: applicationVersion),
            .node(label: "HMKit build name", property: hmKitBuildName),
            .node(label: "HMKit version", property: hmKitVersion)
        ]
    }
}