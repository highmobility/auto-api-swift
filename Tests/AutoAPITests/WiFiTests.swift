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
//  WiFiTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 30/01/2018.
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

        let network = WiFi.Network(networkSecurity: .WPA2Personal, networkSSID: "HOME", password: "ZW3vARNUBe")

        XCTAssertEqual(WiFi.connectToNetwork(network), bytes)
    }

    func testForgetNetwork() {
        let bytes: [UInt8] = [
            0x00, 0x59, // MSB, LSB Message Identifier for Wi-Fi
            0x03,       // Message Type for Forget Network

            0x03,       // Property Identifier for Network SSID
            0x00, 0x04, // Property size 4 bytes
            0x48, 0x4f, 0x4d, 0x45  // Network name "HOME"
        ]

        XCTAssertEqual(WiFi.forgetNetwork("HOME"), bytes)
    }

    func testGetState() {
        let bytes: [UInt8] = [
            0x00, 0x59, // MSB, LSB Message Identifier for Wi-Fi
            0x00        // Message Type for Get Wi Fi State
        ]

        XCTAssertEqual(WiFi.getWifiState, bytes)
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

        guard let wifi = AAAutoAPI.parseBinary(bytes) as? WiFi else {
            return XCTFail("Parsed value is not WiFi")
        }

        XCTAssertEqual(wifi.isEnabled, true)
        XCTAssertEqual(wifi.isConnected, true)
        XCTAssertEqual(wifi.networkSSID, "HOME")
        XCTAssertEqual(wifi.networkSecurity, .WPA2Personal)
    }
}
