//
// AutoAPI
// Copyright (C) 2017 High-Mobility GmbH
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
//  WiFi.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 30/01/2018.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct WiFi: FullStandardCommand {

    public typealias NetworkSSID = String

    public let isConnected: Bool?
    public let isEnabled: Bool?
    public let networkSecurity: NetworkSecurity?
    public let networkSSID: NetworkSSID?


    // MARK: FullStandardCommand

    public var properties: Properties


    init?(properties: Properties) {
        // Ordered by the ID
        isEnabled = properties.value(for: 0x01)
        isConnected = properties.value(for: 0x02)
        networkSSID = properties.value(for: 0x03)
        networkSecurity = NetworkSecurity(rawValue: properties.first(for: 0x04)?.monoValue)

        // Properties
        self.properties = properties
    }
}

extension WiFi: Identifiable {

    public static var identifier: Identifier = Identifier(0x0059)
}

extension WiFi: MessageTypesGettable {

    public enum MessageTypes: UInt8, MessageTypesKind {

        case getWifiState       = 0x00
        case wifiState          = 0x01
        case connectToNetwork   = 0x02
        case forgetNetwork      = 0x03
        case enableDisableWifi  = 0x04


        public static var all: [WiFi.MessageTypes] {
            return [self.getWifiState,
                    self.wifiState,
                    self.connectToNetwork,
                    self.forgetNetwork,
                    self.enableDisableWifi]
        }
    }
}

public extension WiFi {

    struct Network {
        public let networkSecurity: NetworkSecurity
        public let networkSSID: NetworkSSID
        public let password: String

        public init(networkSecurity: NetworkSecurity, networkSSID: NetworkSSID, password: String) {
            self.networkSecurity = networkSecurity
            self.networkSSID = networkSSID
            self.password = password
        }
    }


    static var connectToNetwork: (Network) -> [UInt8] {
        return {
            let ssidBytes = $0.networkSSID.propertyBytes(0x03)
            let securityBytes = $0.networkSecurity.propertyBytes(0x04)
            let passwordBytes = $0.password.propertyBytes(0x05)

            return commandPrefix(for: .connectToNetwork) + ssidBytes + securityBytes + passwordBytes
        }
    }

    /// Use `false` to *disable*.
    static var enableWifi: (Bool) -> [UInt8] {
        return {
            return commandPrefix(for: .enableDisableWifi) + $0.propertyBytes(0x04)
        }
    }

    static var forgetNetwork: (NetworkSSID) -> [UInt8] {
        return {
            commandPrefix(for: .forgetNetwork) + $0.propertyBytes(0x03)
        }
    }

    static var getWifiState: [UInt8] {
        return commandPrefix(for: .getWifiState)
    }
}
