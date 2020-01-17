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
//  AAWiFi.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation
import HMUtilities


public class AAWiFi: AACapability {

    /// Property Identifiers for `AAWiFi` capability.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case status = 0x01
        case networkConnected = 0x02
        case networkSSID = 0x03
        case networkSecurity = 0x04
        case password = 0x05
    }


    // MARK: Properties
    
    /// Network connected
    ///
    /// - returns: `AAConnectionState` wrapped in `AAProperty<AAConnectionState>`
    public var networkConnected: AAProperty<AAConnectionState>? {
        properties.property(forID: PropertyIdentifier.networkConnected)
    }
    
    /// The network SSID
    ///
    /// - returns: `String` wrapped in `AAProperty<String>`
    public var networkSSID: AAProperty<String>? {
        properties.property(forID: PropertyIdentifier.networkSSID)
    }
    
    /// Network security
    ///
    /// - returns: `AANetworkSecurity` wrapped in `AAProperty<AANetworkSecurity>`
    public var networkSecurity: AAProperty<AANetworkSecurity>? {
        properties.property(forID: PropertyIdentifier.networkSecurity)
    }
    
    /// Status
    ///
    /// - returns: `AAEnabledState` wrapped in `AAProperty<AAEnabledState>`
    public var status: AAProperty<AAEnabledState>? {
        properties.property(forID: PropertyIdentifier.status)
    }


    // MARK: AAIdentifiable
    
    /// Capability's Identifier
    ///
    /// - returns: `UInt16` combining the MSB and LSB
    public override class var identifier: UInt16 {
        0x0059
    }


    // MARK: Getters
    
    /// Bytes for getting the `AAWiFi` state.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *request* the state of `AAWiFi`.
    ///
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func getWiFiState() -> Array<UInt8> {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.get.rawValue]
    }
    
    /// Bytes for getting the `AAWiFi` state's **specific** properties.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *request* **specific** state properties of `AAWiFi`.
    ///
    /// - parameters:
    ///   - propertyIDs: Array of requested property identifiers
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func getWiFiProperties(propertyIDs: PropertyIdentifier...) -> Array<UInt8> {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.get.rawValue] + propertyIDs.map { $0.rawValue }
    }


    // MARK: Setters
    
    /// Bytes for *connect to network* command.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *connect to network* in `AAWiFi`.
    /// 
    /// - parameters:
    ///   - networkSSID: The network SSID as `String`
    ///   - networkSecurity: network security as `AANetworkSecurity`
    ///   - password: The network password as `String`
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func connectToNetwork(networkSSID: String, networkSecurity: AANetworkSecurity, password: String? = nil) -> Array<UInt8> {
        let props1 = AAProperty(identifier: PropertyIdentifier.networkSSID, value: networkSSID).bytes + AAProperty(identifier: PropertyIdentifier.networkSecurity, value: networkSecurity).bytes + AAProperty(identifier: PropertyIdentifier.password, value: password).bytes
    
        return AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.set.rawValue] + props1
    }
    
    /// Bytes for *forget network* command.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *forget network* in `AAWiFi`.
    /// 
    /// - parameters:
    ///   - networkSSID: The network SSID as `String`
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func forgetNetwork(networkSSID: String) -> Array<UInt8> {
        return AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.set.rawValue] + AAProperty(identifier: PropertyIdentifier.networkSSID, value: networkSSID).bytes
    }
    
    /// Bytes for *enable disable wi fi* command.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *enable disable wi fi* in `AAWiFi`.
    /// 
    /// - parameters:
    ///   - status: status as `AAEnabledState`
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func enableDisableWiFi(status: AAEnabledState) -> Array<UInt8> {
        return AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.set.rawValue] + AAProperty(identifier: PropertyIdentifier.status, value: status).bytes
    }


    // MARK: AADebugTreeCapable
    
    public override var propertyNodes: [HMDebugTree] {
        [
            .node(label: "Network connected", property: networkConnected),
            .node(label: "Network SSID", property: networkSSID),
            .node(label: "Network security", property: networkSecurity),
            .node(label: "Status", property: status)
        ]
    }
}