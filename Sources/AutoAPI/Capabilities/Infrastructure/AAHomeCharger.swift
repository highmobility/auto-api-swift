//
// AutoAPI
// Copyright (C) 2018 High-Mobility GmbH
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
//  AAHomeCharger.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 30/01/2018.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public class AAHomeCharger: AACapabilityClass, AACapability {

    public let authenticationMechanism: AAProperty<AAAuthenticationMechanism>?
    public let authenticationState: AAProperty<AAAuthenticationState>?
    public let chargeCurrentDC: AAProperty<Float>?
    public let chargingPower: AAProperty<Float>?
    public let chargingState: AAProperty<AAChargingState>?
    public let hotspotState: AAProperty<AAActiveState>?
    public let coordinates: AAProperty<AACoordinates>?
    public let maximumChargeCurrent: AAProperty<Float>?
    public let minimumChargeCurrent: AAProperty<Float>?
    public let plugType: AAProperty<AAPlugType>?
    public let priceTariffs: [AAProperty<AAPriceTariff>]?
    public let solarChargingState: AAProperty<AAActiveState>?
    public let wifiHotspotPassword: AAProperty<String>?
    public let wifiHotspotSecurity: AAProperty<AANetworkSecurity>?
    public let wifiHotspotSSID: AAProperty<String>?


    // MARK: AACapability

    public static var identifier: AACommandIdentifier = 0x0060


    required init(properties: AAProperties) {
        // Ordered by the ID
        chargingState = properties.property(forIdentifier: 0x01)
        authenticationMechanism = properties.property(forIdentifier: 0x02)
        plugType = properties.property(forIdentifier: 0x03)
        chargingPower = properties.property(forIdentifier: 0x04)
        solarChargingState = properties.property(forIdentifier: 0x05)
        hotspotState = properties.property(forIdentifier: 0x08)
        wifiHotspotSSID = properties.property(forIdentifier: 0x09)
        wifiHotspotSecurity = properties.property(forIdentifier: 0x0A)
        wifiHotspotPassword = properties.property(forIdentifier: 0x0B)
        /* Level 8 */
        authenticationState = properties.property(forIdentifier: 0x0D)
        chargeCurrentDC = properties.property(forIdentifier: 0x0E)
        maximumChargeCurrent = properties.property(forIdentifier: 0x0F)
        minimumChargeCurrent = properties.property(forIdentifier: 0x10)
        coordinates = properties.property(forIdentifier: 0x11)
        priceTariffs = properties.allOrNil(forIdentifier: 0x12)

        super.init(properties: properties)
    }
}

extension AAHomeCharger: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getChargerState        = 0x00
        case chargerState           = 0x01
        case setChargingCurrent     = 0x12
        case setPriceTariffs        = 0x13
        case activateSolarCharging  = 0x14
        case enableWifiHotspot      = 0x15
        case authenticateExpire     = 0x16
    }
}

public extension AAHomeCharger {

    static var getChargerState: AACommand {
        return command(forMessageType: .getChargerState)
    }


    static func activateSolarCharging(_ state: AAActiveState) -> AACommand {
        let properties = [state.property(forIdentifier: 0x01)]

        return command(forMessageType: .activateSolarCharging, properties: properties)
    }

    static func enableWifiHotspot(_ enable: AAEnabledState) -> AACommand {
        let properties = [enable.property(forIdentifier: 0x01)]

        return command(forMessageType: .enableWifiHotspot, properties: properties)
    }

    static func setAuthenticationState(_ state: AAAuthenticationState) -> AACommand {
        let properties = [state.property(forIdentifier: 0x01)]

        return command(forMessageType: .authenticateExpire, properties: properties)
    }

    static func setChargingCurrent(_ current: Float) -> AACommand {
        let properties = [current.property(forIdentifier: 0x01)]

        return command(forMessageType: .setChargingCurrent, properties: properties)
    }

    static func setPriceTariffs(_ tariffs: [AAPriceTariff]) -> AACommand {
        let properties = tariffs.map { $0.property(forIdentifier: 0x0C) }

        return command(forMessageType: .setPriceTariffs, properties: properties)
    }
}
