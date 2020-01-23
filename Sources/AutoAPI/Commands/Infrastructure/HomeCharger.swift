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
//  HomeCharger.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 30/01/2018.
//

import Foundation


public struct HomeCharger: FullStandardCommand {

    public let authenticationMechanism: AuthenticationMechanism?
    public let chargeCurrent: ChargeCurrent?
    /// In kilowatts
    public let chargingPower: Float?
    public let chargingState: ChargingState?
    public let isHotspotEnabled: Bool?
    public let isSolarChargingActive: Bool?
    public let location: Coordinate?
    public let plugType: PlugType?
    public let pricingTariffs: [PricingTariff]?
    public let wifiHotspotPassword: String?
    public let wifiHotspotSecurity: NetworkSecurity?
    public let wifiHotspotSSID: String?


    // MARK: FullStandardCommand

    public var properties: Properties


    init?(properties: Properties) {
        // Ordered by the ID
        chargingState = ChargingState(rawValue: properties.first(for: 0x01)?.monoValue)
        authenticationMechanism = AuthenticationMechanism(rawValue: properties.first(for: 0x02)?.monoValue)
        plugType = PlugType(rawValue: properties.first(for: 0x03)?.monoValue)
        chargingPower = properties.value(for: 0x04)
        isSolarChargingActive = properties.value(for: 0x05)
        location = Coordinate(properties.first(for: 0x06)?.value ?? [])
        chargeCurrent = ChargeCurrent(properties.first(for: 0x07)?.value ?? [])
        isHotspotEnabled = properties.value(for: 0x08)
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

    public enum MessageTypes: UInt8, MessageTypesKind {

        case getHomeChargerState                = 0x00
        case homeChargerState                   = 0x01
        case setChargeCurrent                   = 0x02
        case setPriceTariffs                    = 0x03
        case activateDeactivateSolarCharging    = 0x04
        case enableDisableWifiHotspot           = 0x05


        public static var all: [HomeCharger.MessageTypes] {
            return [self.getHomeChargerState,
                    self.homeChargerState,
                    self.setChargeCurrent,
                    self.setPriceTariffs,
                    self.activateDeactivateSolarCharging,
                    self.enableDisableWifiHotspot]
        }
    }
}

public extension HomeCharger {

    typealias PriceTariff = PricingTariff


    /// Use `false` to *deactivate*.
    static var activateSolarCharging: (Bool) -> [UInt8] {
        return {
            return commandPrefix(for: .activateDeactivateSolarCharging) + $0.propertyValue
        }
    }

    /// Use `false` to *disable*.
    static var enableWifiHotspot: (Bool) -> [UInt8] {
        return {
            return commandPrefix(for: .enableDisableWifiHotspot) + $0.propertyValue
        }
    }

    static var getHomeChargerState: [UInt8] {
        return commandPrefix(for: .getHomeChargerState)
    }

    static var setChargeCurrent: (Float) -> [UInt8] {
        return {
            return commandPrefix(for: .setChargeCurrent) + $0.propertyValue
        }
    }

    static var setPriceTariffs: ([PriceTariff]) -> [UInt8] {
        return {
            return commandPrefix(for: .setPriceTariffs) + $0.map { $0.propertyBytes(0x0C) }.flatMap { $0 }
        }
    }
}
