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
//  AAHomeCharger.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation
import HMUtilities


public class AAHomeCharger: AACapability {

    /// Authentication mechanism
    public enum AuthenticationMechanism: UInt8, AABytesConvertable {
        case pin = 0x00
        case app = 0x01
    }
    
    /// Authentication state
    public enum AuthenticationState: UInt8, AABytesConvertable {
        case unauthenticated = 0x00
        case authenticated = 0x01
    
        static let expireAuthentication = Self.unauthenticated
        static let authenticate = Self.authenticated
    }
    
    /// Charging status
    public enum ChargingStatus: UInt8, AABytesConvertable {
        case disconnected = 0x00
        case pluggedIn = 0x01
        case charging = 0x02
    }
    
    /// Plug type
    public enum PlugType: UInt8, AABytesConvertable {
        case type1 = 0x00
        case type2 = 0x01
        case ccs = 0x02
        case chademo = 0x03
    }


    /// Property Identifiers for `AAHomeCharger` capability.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case chargingStatus = 0x01
        case authenticationMechanism = 0x02
        case plugType = 0x03
        case chargingPowerKW = 0x04
        case solarCharging = 0x05
        case wifiHotspotEnabled = 0x08
        case wifiHotspotSSID = 0x09
        case wiFiHotspotSecurity = 0x0a
        case wiFiHotspotPassword = 0x0b
        case authenticationState = 0x0d
        case chargeCurrentDC = 0x0e
        case maximumChargeCurrent = 0x0f
        case minimumChargeCurrent = 0x10
        case coordinates = 0x11
        case priceTariffs = 0x12
    }


    // MARK: Properties
    
    /// Authentication mechanism
    ///
    /// - returns: `AuthenticationMechanism` wrapped in `AAProperty<AuthenticationMechanism>`
    public var authenticationMechanism: AAProperty<AuthenticationMechanism>? {
        properties.property(forID: PropertyIdentifier.authenticationMechanism)
    }
    
    /// Authentication state
    ///
    /// - returns: `AuthenticationState` wrapped in `AAProperty<AuthenticationState>`
    public var authenticationState: AAProperty<AuthenticationState>? {
        properties.property(forID: PropertyIdentifier.authenticationState)
    }
    
    /// The charge direct current
    ///
    /// - returns: `Float` wrapped in `AAProperty<Float>`
    public var chargeCurrentDC: AAProperty<Float>? {
        properties.property(forID: PropertyIdentifier.chargeCurrentDC)
    }
    
    /// Charging power in kW
    ///
    /// - returns: `Float` wrapped in `AAProperty<Float>`
    public var chargingPowerKW: AAProperty<Float>? {
        properties.property(forID: PropertyIdentifier.chargingPowerKW)
    }
    
    /// Charging status
    ///
    /// - returns: `ChargingStatus` wrapped in `AAProperty<ChargingStatus>`
    public var chargingStatus: AAProperty<ChargingStatus>? {
        properties.property(forID: PropertyIdentifier.chargingStatus)
    }
    
    /// Coordinates
    ///
    /// - returns: `AACoordinates` wrapped in `AAProperty<AACoordinates>`
    public var coordinates: AAProperty<AACoordinates>? {
        properties.property(forID: PropertyIdentifier.coordinates)
    }
    
    /// The maximum possible charge current
    ///
    /// - returns: `Float` wrapped in `AAProperty<Float>`
    public var maximumChargeCurrent: AAProperty<Float>? {
        properties.property(forID: PropertyIdentifier.maximumChargeCurrent)
    }
    
    /// The minimal possible charge current
    ///
    /// - returns: `Float` wrapped in `AAProperty<Float>`
    public var minimumChargeCurrent: AAProperty<Float>? {
        properties.property(forID: PropertyIdentifier.minimumChargeCurrent)
    }
    
    /// Plug type
    ///
    /// - returns: `PlugType` wrapped in `AAProperty<PlugType>`
    public var plugType: AAProperty<PlugType>? {
        properties.property(forID: PropertyIdentifier.plugType)
    }
    
    /// Price tariffs
    ///
    /// - returns: Array of `AAPriceTariff`-s wrapped in `[AAProperty<AAPriceTariff>]`
    public var priceTariffs: [AAProperty<AAPriceTariff>]? {
        properties.properties(forID: PropertyIdentifier.priceTariffs)
    }
    
    /// Solar charging
    ///
    /// - returns: `AAActiveState` wrapped in `AAProperty<AAActiveState>`
    public var solarCharging: AAProperty<AAActiveState>? {
        properties.property(forID: PropertyIdentifier.solarCharging)
    }
    
    /// The Wi-Fi Hotspot password
    ///
    /// - returns: `String` wrapped in `AAProperty<String>`
    public var wiFiHotspotPassword: AAProperty<String>? {
        properties.property(forID: PropertyIdentifier.wiFiHotspotPassword)
    }
    
    /// Wi fi hotspot security
    ///
    /// - returns: `AANetworkSecurity` wrapped in `AAProperty<AANetworkSecurity>`
    public var wiFiHotspotSecurity: AAProperty<AANetworkSecurity>? {
        properties.property(forID: PropertyIdentifier.wiFiHotspotSecurity)
    }
    
    /// Wi fi hotspot enabled
    ///
    /// - returns: `AAEnabledState` wrapped in `AAProperty<AAEnabledState>`
    public var wifiHotspotEnabled: AAProperty<AAEnabledState>? {
        properties.property(forID: PropertyIdentifier.wifiHotspotEnabled)
    }
    
    /// The Wi-Fi Hotspot SSID
    ///
    /// - returns: `String` wrapped in `AAProperty<String>`
    public var wifiHotspotSSID: AAProperty<String>? {
        properties.property(forID: PropertyIdentifier.wifiHotspotSSID)
    }


    // MARK: AAIdentifiable
    
    /// Capability's Identifier
    ///
    /// - returns: `UInt16` combining the MSB and LSB
    public override class var identifier: UInt16 {
        0x0060
    }


    // MARK: Getters
    
    /// Bytes for getting the `AAHomeCharger` state.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *request* the state of `AAHomeCharger`.
    ///
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func getHomeChargerState() -> Array<UInt8> {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.get.rawValue]
    }
    
    /// Bytes for getting the `AAHomeCharger` state's **specific** properties.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *request* **specific** state properties of `AAHomeCharger`.
    ///
    /// - parameters:
    ///   - propertyIDs: Array of requested property identifiers
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func getHomeChargerProperties(propertyIDs: PropertyIdentifier...) -> Array<UInt8> {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.get.rawValue] + propertyIDs.map { $0.rawValue }
    }


    // MARK: Setters
    
    /// Bytes for *set charge current* command.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *set charge current* in `AAHomeCharger`.
    /// 
    /// - parameters:
    ///   - chargeCurrentDC: The charge direct current as `Float`
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func setChargeCurrent(chargeCurrentDC: Float) -> Array<UInt8> {
        return AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.set.rawValue] + AAProperty(identifier: PropertyIdentifier.chargeCurrentDC, value: chargeCurrentDC).bytes
    }
    
    /// Bytes for *set price tariffs* command.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *set price tariffs* in `AAHomeCharger`.
    /// 
    /// - parameters:
    ///   - priceTariffs: price tariffs as `[AAPriceTariff]`
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func setPriceTariffs(priceTariffs: [AAPriceTariff]) -> Array<UInt8> {
        return AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.set.rawValue] + AAProperty.multiple(identifier: PropertyIdentifier.priceTariffs, values: priceTariffs).flatMap { $0.bytes }
    }
    
    /// Bytes for *activate deactivate solar charging* command.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *activate deactivate solar charging* in `AAHomeCharger`.
    /// 
    /// - parameters:
    ///   - solarCharging: solar charging as `AAActiveState`
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func activateDeactivateSolarCharging(solarCharging: AAActiveState) -> Array<UInt8> {
        return AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.set.rawValue] + AAProperty(identifier: PropertyIdentifier.solarCharging, value: solarCharging).bytes
    }
    
    /// Bytes for *enable disable wi fi hotspot* command.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *enable disable wi fi hotspot* in `AAHomeCharger`.
    /// 
    /// - parameters:
    ///   - wifiHotspotEnabled: wi fi hotspot enabled as `AAEnabledState`
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func enableDisableWiFiHotspot(wifiHotspotEnabled: AAEnabledState) -> Array<UInt8> {
        return AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.set.rawValue] + AAProperty(identifier: PropertyIdentifier.wifiHotspotEnabled, value: wifiHotspotEnabled).bytes
    }
    
    /// Bytes for *authenticate expire* command.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *authenticate expire* in `AAHomeCharger`.
    /// 
    /// - parameters:
    ///   - authenticationState: authentication state as `AuthenticationState`
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func authenticateExpire(authenticationState: AuthenticationState) -> Array<UInt8> {
        return AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.set.rawValue] + AAProperty(identifier: PropertyIdentifier.authenticationState, value: authenticationState).bytes
    }


    // MARK: AADebugTreeCapable
    
    public override var propertyNodes: [HMDebugTree] {
        [
            .node(label: "Authentication mechanism", property: authenticationMechanism),
            .node(label: "Authentication state", property: authenticationState),
            .node(label: "Charge current (DC)", property: chargeCurrentDC),
            .node(label: "Charging Power (kW)", property: chargingPowerKW),
            .node(label: "Charging status", property: chargingStatus),
            .node(label: "Coordinates", property: coordinates),
            .node(label: "Maximum charge current", property: maximumChargeCurrent),
            .node(label: "Minimum charge current", property: minimumChargeCurrent),
            .node(label: "Plug type", property: plugType),
            .node(label: "Price tariffs", properties: priceTariffs),
            .node(label: "Solar charging", property: solarCharging),
            .node(label: "Wi-Fi hotspot password", property: wiFiHotspotPassword),
            .node(label: "Wi-Fi hotspot security", property: wiFiHotspotSecurity),
            .node(label: "Wi-Fi hotspot enabled", property: wifiHotspotEnabled),
            .node(label: "Wi-Fi hotspot SSID", property: wifiHotspotSSID)
        ]
    }
}