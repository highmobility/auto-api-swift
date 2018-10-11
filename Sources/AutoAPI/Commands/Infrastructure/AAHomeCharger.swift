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

    public let authenticationMechanism: AAAuthenticationMechanism?
    public let authenticationState: AAAuthenticationState?
    public let chargeCurrentDC: Float?
    public let chargingPower: Float?
    public let chargingState: AAChargingState?
    public let hotspotState: AAActiveState?
    public let location: AACoordinates?
    public let maximumChargeCurrent: Float?
    public let minimumChargeCurrent: Float?
    public let plugType: AAPlugType?
    public let pricingTariffs: [AAPricingTariff]?
    public let solarChargingState: AAActiveState?
    public let wifiHotspotPassword: String?
    public let wifiHotspotSecurity: AANetworkSecurity?
    public let wifiHotspotSSID: String?


    // MARK: AAFullStandardCommand

    public let properties: AAProperties


    init?(properties: AAProperties) {
        // Ordered by the ID
        chargingState = AAChargingState(properties: properties, keyPath: \AAHomeCharger.chargingState)
        authenticationMechanism = AAAuthenticationMechanism(properties: properties, keyPath: \AAHomeCharger.authenticationMechanism)
        plugType = AAPlugType(properties: properties, keyPath: \AAHomeCharger.plugType)
        chargingPower = properties.value(for: \AAHomeCharger.chargingPower)
        solarChargingState = AAActiveState(properties: properties, keyPath: \AAHomeCharger.solarChargingState)
        hotspotState = AAActiveState(properties: properties, keyPath: \AAHomeCharger.hotspotState)
        wifiHotspotSSID = properties.value(for: \AAHomeCharger.wifiHotspotSSID)
        wifiHotspotSecurity = AANetworkSecurity(properties: properties, keyPath: \AAHomeCharger.wifiHotspotSecurity)
        wifiHotspotPassword = properties.value(for: \AAHomeCharger.wifiHotspotPassword)
        pricingTariffs = properties.flatMap(for: \AAHomeCharger.pricingTariffs) { AAPricingTariff($0.value) }
        /* Level 8 */
        authenticationState = AAAuthenticationState(properties: properties, keyPath: \AAHomeCharger.authenticationState)
        chargeCurrentDC = properties.value(for: \AAHomeCharger.chargeCurrentDC)
        maximumChargeCurrent = properties.value(for: \AAHomeCharger.maximumChargeCurrent)
        minimumChargeCurrent = properties.value(for: \AAHomeCharger.minimumChargeCurrent)
        location = AACoordinates(properties.first(for: \AAHomeCharger.location)?.value ?? [])

        // Properties
        self.properties = properties
    }
}

extension AAHomeCharger: AAIdentifiable {

    public static var identifier: AACommandIdentifier = 0x0060
}

extension AAHomeCharger: AALegacyGettable {

    public struct Legacy: AALegacyType {

        public typealias Coordinate = (latitude: Float, longitude: Float)

        public let chargeCurrent: AAChargeCurrent?
        public let location: Coordinate?


        // MARK: AALegacyType

        public enum MessageTypes: UInt8, CaseIterable {

            case getChargerState        = 0x00
            case chargerState           = 0x01
            case setChargeCurrent       = 0x02
            case setPriceTariffs        = 0x03
            case setSolarChargingState  = 0x04
            case setWifiHotspotState    = 0x05
        }


        public init(properties: AAProperties) {
            location = properties.first(for: 0x06).flatMap { property -> Coordinate? in
                guard property.value.count == 8 else {
                    return nil
                }

                return (latitude: Float(property.value.prefix(upTo: 4)),
                        longitude: Float(property.value.dropFirst(4)))
            }

            chargeCurrent = AAChargeCurrent(properties.first(for: 0x07)?.value ?? [])
        }
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

extension AAHomeCharger: AAPropertyIdentifierGettable {

    static func propertyID<Type>(for keyPath: KeyPath<AAHomeCharger, Type>) -> AAPropertyIdentifier {
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
        case \AAHomeCharger.pricingTariffs:             return 0x0C
            /* Level 8 */
        case \AAHomeCharger.authenticationState:    return 0x0D
        case \AAHomeCharger.chargeCurrentDC:        return 0x0E
        case \AAHomeCharger.maximumChargeCurrent:   return 0x0F
        case \AAHomeCharger.minimumChargeCurrent:   return 0x10
        case \AAHomeCharger.location:               return 0x11

        default:
            return 0x00
        }
    }
}


// MARK: Commands

public extension AAHomeCharger {

    static var getChargerState: [UInt8] {
        return commandPrefix(for: .getChargerState)
    }


    static func activateSolarCharging(_ state: AAActiveState) -> [UInt8] {
        return commandPrefix(for: .activateSolarCharging) + state.propertyBytes(0x01)
    }

    static func authenticateExpire(_ state: AAAuthenticationState) -> [UInt8] {
        return commandPrefix(for: .authenticateExpire) + state.propertyBytes(0x01)
    }

    static func enableWifiHotspot(_ enable: AAEnabledState) -> [UInt8] {
        return commandPrefix(for: .enableWifiHotspot) + enable.propertyBytes(0x01)
    }

    static func setChargingCurrent(_ current: Float) -> [UInt8] {
        return commandPrefix(for: .setChargingCurrent) + current.propertyBytes(0x01)
    }

    static func setPriceTariffs(_ tariffs: [AAPricingTariff]) -> [UInt8] {
        return commandPrefix(for: .setPriceTariffs) + tariffs.reduceToByteArray { $0.propertyBytes(0x0C) }
    }
}

public extension AAHomeCharger.Legacy {

    typealias PriceTariff = AAPricingTariff


    static var setSolarChargingState: (AAActiveState) -> [UInt8] {
        return {
            return commandPrefix(for: AAHomeCharger.self, messageType: .setSolarChargingState) + $0.propertyBytes(0x01)
        }
    }

    static var setWifiHotspotState: (AAActiveState) -> [UInt8] {
        return {
            return commandPrefix(for: AAHomeCharger.self, messageType: .setWifiHotspotState) + $0.propertyBytes(0x01)
        }
    }

    static var getChargerState: [UInt8] {
        return commandPrefix(for: AAHomeCharger.self, messageType: .getChargerState)
    }

    static var setChargeCurrent: (Float) -> [UInt8] {
        return {
            return commandPrefix(for: AAHomeCharger.self, messageType: .setChargeCurrent) + $0.propertyBytes(0x01)
        }
    }

    static var setPriceTariffs: ([PriceTariff]) -> [UInt8] {
        return {
            return commandPrefix(for: AAHomeCharger.self, messageType: .setPriceTariffs) + $0.map { $0.propertyBytes(0x0C) }.flatMap { $0 }
        }
    }
}
