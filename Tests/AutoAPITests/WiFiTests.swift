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
//  WiFiTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 30/01/2018.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import AutoAPI
import XCTest


class WiFiTests: XCTestCase {

    static var allTests = [("testConnectToNetwork", testConnectToNetwork),
                           ("testForgetNetwork", testForgetNetwork),
                           ("testGetState", testGetState),
                           ("testState", testState)]

    
    // MARK: XCTestCase

    func testConnectToNetwork() {
        let bytes: [UInt8] = [
            0x00, 0x59, // MSB, LSB Message Identifier for Wi-Fi
            0x02,       // Message Type for Connect to Network

            0x03,       // Property Identifier for Network SSID
            0x00, 0x04, // Property size 4 bytes
            0x48, 0x4f, 0x4d, 0x45, // Network name "HOME"

            0x04,       // Property Identifier for Network security
            0x00, 0x01, // Property size 1 byte
            0x03,       // WPA2 Personal

            0x05,       // Property Identifier for Network password
            0x00, 0x0A, // Property size 10 bytes
            0x5a, 0x57, 0x33, 0x76, 0x41,   //
            0x52, 0x4e, 0x55, 0x42, 0x65    // Netork password "ZW3vARNUBe"
        ]

        let network = AAWiFi.Network(networkSecurity: .WPA2Personal, networkSSID: "HOME", password: "ZW3vARNUBe")

        XCTAssertEqual(AAWiFi.connectToNetwork(network), bytes)
    }

    func testForgetNetwork() {
        let bytes: [UInt8] = [
            0x00, 0x59, // MSB, LSB Message Identifier for Wi-Fi
            0x03,       // Message Type for Forget Network

            0x03,       // Property Identifier for Network SSID
            0x00, 0x04, // Property size 4 bytes
            0x48, 0x4f, 0x4d, 0x45  // Network name "HOME"
        ]

        XCTAssertEqual(AAWiFi.forgetNetwork("HOME"), bytes)
    }

    func testGetState() {
        let bytes: [UInt8] = [
            0x00, 0x59, // MSB, LSB Message Identifier for Wi-Fi
            0x00        // Message Type for Get Wi Fi State
        ]

        XCTAssertEqual(AAWiFi.getWifiState, bytes)
    }

    func testState() {
        let bytes: [UInt8] = [
            0x00, 0x59, // MSB, LSB Message Identifier for Wi-Fi
            0x01,       // Message Type for Wi Fi State

            0x01,       // Property identifier for Wi fi enabled
            0x00, 0x01, // Property size is 1 bytes
            0x01,       // Wi-Fi enabled

            0x02,       // Property identifier for Network connected
            0x00, 0x01, // Property size is 1 bytes
            0x01,       // Network connected

            0x03,                   // Property identifier for Network ssid
            0x00, 0x04,             // Property size is 4 bytes
            0x48, 0x4f, 0x4d, 0x45, // Network name "HOME"

            0x04,       // Property identifier for Network security
            0x00, 0x01, // Property size is 1 bytes
            0x03        // WPA2 Personal
        ]

        guard let wifi = AAAutoAPI.parseBinary(bytes) as? AAWiFi else {
            return XCTFail("Parsed value is not WiFi")
        }

        XCTAssertEqual(wifi.isEnabled, true)
        XCTAssertEqual(wifi.isConnected, true)
        XCTAssertEqual(wifi.networkSSID, "HOME")
        XCTAssertEqual(wifi.networkSecurity, .WPA2Personal)
    }
}
