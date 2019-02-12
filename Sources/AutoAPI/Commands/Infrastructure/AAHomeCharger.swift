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


public struct AAHomeCharger: AAFullStandardCommand {

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


    // MARK: AAFullStandardCommand

    public let properties: AAProperties


    init?(properties: AAProperties) {
        // Ordered by the ID
        chargingState = properties.property(for: \AAHomeCharger.chargingState)
        authenticationMechanism = properties.property(for: \AAHomeCharger.authenticationMechanism)
        plugType = properties.property(for: \AAHomeCharger.plugType)
        chargingPower = properties.property(for: \AAHomeCharger.chargingPower)
        solarChargingState = properties.property(for: \AAHomeCharger.solarChargingState)
        hotspotState = properties.property(for: \AAHomeCharger.hotspotState)
        wifiHotspotSSID = properties.property(for: \AAHomeCharger.wifiHotspotSSID)
        wifiHotspotSecurity = properties.property(for: \AAHomeCharger.wifiHotspotSecurity)
        wifiHotspotPassword = properties.property(for: \AAHomeCharger.wifiHotspotPassword)
        /* Level 8 */
        authenticationState = properties.property(for: \AAHomeCharger.authenticationState)
        chargeCurrentDC = properties.property(for: \AAHomeCharger.chargeCurrentDC)
        maximumChargeCurrent = properties.property(for: \AAHomeCharger.maximumChargeCurrent)
        minimumChargeCurrent = properties.property(for: \AAHomeCharger.minimumChargeCurrent)
        coordinates = properties.property(for: \AAHomeCharger.coordinates)
        priceTariffs = properties.properties(for: \AAHomeCharger.priceTariffs) 

        // Properties
        self.properties = properties
    }
}

extension AAHomeCharger: AAIdentifiable {

    public static var identifier: AACommandIdentifier = 0x0060
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

extension AAHomeCharger: AAPropertyIdentifierGettable {

    static func propertyID<Type>(for keyPath: KeyPath<AAHomeCharger, Type>) -> AAPropertyIdentifier? {
        switch keyPath {
        case \AAHomeCharger.chargingState:              return 0x01
        case \AAHomeCharger.authenticationMechanism:    return 0x02
        case \AAHomeCharger.plugType:                   return 0x03
        case \AAHomeCharger.chargingPower:              return 0x04
        case \AAHomeCharger.solarChargingState:         return 0x05
        case \AAHomeCharger.hotspotState:               return 0x08
        case \AAHomeCharger.wifiHotspotSSID:            return 0x09
        case \AAHomeCharger.wifiHotspotSecurity:        return 0x0A
        case \AAHomeCharger.wifiHotspotPassword:        return 0x0B
            /* Level 8 */
        case \AAHomeCharger.authenticationState:    return 0x0D
        case \AAHomeCharger.chargeCurrentDC:        return 0x0E
        case \AAHomeCharger.maximumChargeCurrent:   return 0x0F
        case \AAHomeCharger.minimumChargeCurrent:   return 0x10
        case \AAHomeCharger.coordinates:            return 0x11
        case \AAHomeCharger.priceTariffs:         return 0x12

        default:
            return nil
        }
    }
}

public extension AAHomeCharger {

    static var getChargerState: [UInt8] {
        return commandPrefix(for: .getChargerState)
    }


    static func activateSolarCharging(_ state: AAActiveState) -> [UInt8] {
        return commandPrefix(for: .activateSolarCharging) + state.propertyBytes(0x01)
    }

    static func enableWifiHotspot(_ enable: AAEnabledState) -> [UInt8] {
        return commandPrefix(for: .enableWifiHotspot) + enable.propertyBytes(0x01)
    }

    static func setAuthenticationState(_ state: AAAuthenticationState) -> [UInt8] {
        return commandPrefix(for: .authenticateExpire) + state.propertyBytes(0x01)
    }

    static func setChargingCurrent(_ current: Float) -> [UInt8] {
        return commandPrefix(for: .setChargingCurrent) + current.propertyBytes(0x01)
    }

    static func setPriceTariffs(_ tariffs: [AAPriceTariff]) -> [UInt8] {
        return commandPrefix(for: .setPriceTariffs) + tariffs.reduceToByteArray { $0.propertyBytes(0x0C) }
    }
}
