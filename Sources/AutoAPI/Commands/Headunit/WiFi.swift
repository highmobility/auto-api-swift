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
//  WiFi.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 30/01/2018.
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
