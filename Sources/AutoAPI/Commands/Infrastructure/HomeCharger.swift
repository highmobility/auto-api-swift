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
//  HomeCharger.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 30/01/2018.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct HomeCharger: FullStandardCommand {

    public let authenticationMechanism: AuthenticationMechanism?
    public let chargeCurrent: ChargeCurrent?

    /// In kilowatts
    public let chargingPower: Float?
    public let chargingState: ChargingState?
    public let hotspotState: ActiveState?
    public let location: Coordinate?
    public let plugType: PlugType?
    public let pricingTariffs: [PricingTariff]?
    public let solarChargingState: ActiveState?
    public let wifiHotspotPassword: String?
    public let wifiHotspotSecurity: NetworkSecurity?
    public let wifiHotspotSSID: String?


    // MARK: FullStandardCommand

    public let properties: Properties


    init?(properties: Properties) {
        // Ordered by the ID
        chargingState = ChargingState(rawValue: properties.first(for: 0x01)?.monoValue)
        authenticationMechanism = AuthenticationMechanism(rawValue: properties.first(for: 0x02)?.monoValue)
        plugType = PlugType(rawValue: properties.first(for: 0x03)?.monoValue)
        chargingPower = properties.value(for: 0x04)
        solarChargingState = ActiveState(rawValue: properties.first(for: 0x05)?.monoValue)
        location = Coordinate(properties.first(for: 0x06)?.value ?? [])
        chargeCurrent = ChargeCurrent(properties.first(for: 0x07)?.value ?? [])
        hotspotState = ActiveState(rawValue: properties.first(for: 0x08)?.monoValue)
        wifiHotspotSSID = properties.value(for: 0x09)
        wifiHotspotSecurity = NetworkSecurity(rawValue: properties.first(for: 0x0A)?.monoValue)
        wifiHotspotPassword = properties.value(for: 0x0B)
        pricingTariffs = properties.flatMap(for: 0x0C) { PricingTariff($0.value) }

        // Properties
        self.properties = properties
    }
}

extension HomeCharger: Identifiable {

    public static var identifier: Identifier = Identifier(0x0060)
}

extension HomeCharger: MessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getChargerState        = 0x00
        case chargerState           = 0x01
        case setChargeCurrent       = 0x02
        case setPriceTariffs        = 0x03
        case setSolarChargingState  = 0x04
        case setWifiHotspotState    = 0x05
    }
}

public extension HomeCharger {

    typealias PriceTariff = PricingTariff


    static var setSolarChargingState: (ActiveState) -> [UInt8] {
        return {
            return commandPrefix(for: .setSolarChargingState) + $0.propertyBytes(0x01)
        }
    }

    static var setWifiHotspotState: (ActiveState) -> [UInt8] {
        return {
            return commandPrefix(for: .setWifiHotspotState) + $0.propertyBytes(0x01)
        }
    }

    static var getChargerState: [UInt8] {
        return commandPrefix(for: .getChargerState)
    }

    static var setChargeCurrent: (Float) -> [UInt8] {
        return {
            return commandPrefix(for: .setChargeCurrent) + $0.propertyBytes(0x01)
        }
    }

    static var setPriceTariffs: ([PriceTariff]) -> [UInt8] {
        return {
            return commandPrefix(for: .setPriceTariffs) + $0.map { $0.propertyBytes(0x0C) }.flatMap { $0 }
        }
    }
}
