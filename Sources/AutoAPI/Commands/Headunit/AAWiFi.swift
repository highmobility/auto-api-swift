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
//  AAWiFi.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 30/01/2018.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct AAWiFi: AAFullStandardCommand {

    public let connectedState: AAProperty<AAConnectionState>?
    public let enabledState: AAProperty<AAEnabledState>?
    public let networkSecurity: AAProperty<AANetworkSecurity>?
    public let networkSSID: AAProperty<AANetworkSSID>?


    // MARK: AAFullStandardCommand

    public let properties: AAProperties


    init?(properties: AAProperties) {
        // Ordered by the ID
        enabledState = properties.property(forIdentifier: 0x01)
        connectedState = properties.property(forIdentifier: 0x02)
        networkSSID = properties.property(forIdentifier: 0x03)
        networkSecurity = properties.property(forIdentifier: 0x04)

        // Properties
        self.properties = properties
    }
}

extension AAWiFi: AAIdentifiable {

    public static var identifier: AACommandIdentifier = 0x0059
}

extension AAWiFi: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getState           = 0x00
        case state              = 0x01
        case connectToNetwork   = 0x02
        case forgetNetwork      = 0x03
        case enableDisable      = 0x04
    }
}

public extension AAWiFi {

    static var getWifiState: [UInt8] {
        return commandPrefix(for: .getState)
    }


    static func connectToNetwork(ssid: AANetworkSSID, security: AANetworkSecurity, password: String?) -> [UInt8] {
        return commandPrefix(for: .connectToNetwork)
            // TODO: + [ssid.propertyBytes(0x03), security.propertyBytes(0x04), password?.propertyBytes(0x05)].propertiesValuesCombined
    }

    static func enableDisalbe(_ state: AAEnabledState) -> [UInt8] {
        return commandPrefix(for: .enableDisable)
            // TODO: + state.propertyBytes(0x04)
    }

    static func forgetNetwork(ssid: AANetworkSSID) -> [UInt8] {
        return commandPrefix(for: .forgetNetwork)
            // TODO: + ssid.propertyBytes(0x03)
    }
}
