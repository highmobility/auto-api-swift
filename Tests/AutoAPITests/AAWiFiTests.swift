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
//  AAWiFiTest.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import AutoAPI
import XCTest


class AAWiFiTest: XCTestCase {

    // MARK: State Properties

    func testNetworkConnected() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x59, 0x01, 0x02, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAWiFi else {
            return XCTFail("Could not parse bytes as AAWiFi")
        }
    
        XCTAssertEqual(capability.networkConnected?.value, .connected)
    }

    func testNetworkSecurity() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x59, 0x01, 0x04, 0x00, 0x04, 0x01, 0x00, 0x01, 0x03]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAWiFi else {
            return XCTFail("Could not parse bytes as AAWiFi")
        }
    
        XCTAssertEqual(capability.networkSecurity?.value, .wpa2Personal)
    }

    func testStatus() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x59, 0x01, 0x01, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAWiFi else {
            return XCTFail("Could not parse bytes as AAWiFi")
        }
    
        XCTAssertEqual(capability.status?.value, .enabled)
    }

    func testNetworkSSID() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x59, 0x01, 0x03, 0x00, 0x07, 0x01, 0x00, 0x04, 0x48, 0x4f, 0x4d, 0x45]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAWiFi else {
            return XCTFail("Could not parse bytes as AAWiFi")
        }
    
        XCTAssertEqual(capability.networkSSID?.value, "HOME")
    }

    
    // MARK: Getters

    func testGetWiFiState() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x59, 0x00]
    
        XCTAssertEqual(bytes, AAWiFi.getWiFiState())
    }
    
    func testGetWiFiProperties() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x59, 0x00, 0x04]
        let getterBytes = AAWiFi.getWiFiProperties(propertyIDs: .networkSecurity)
    
        XCTAssertEqual(bytes, getterBytes)
    }

    
    // MARK: Non-state Properties

    func testPassword() {
        let bytes: Array<UInt8> = [0x05, 0x00, 0x11, 0x01, 0x00, 0x0e, 0x67, 0x72, 0x65, 0x61, 0x74, 0x5f, 0x73, 0x65, 0x63, 0x72, 0x65, 0x74, 0x31, 0x32]
    
        guard let property: AAProperty<String> = AAOpaqueProperty(bytes: bytes)?.property() else {
            return XCTFail("Could not create a property for .password")
        }
    
        XCTAssertEqual(property.value, "great_secret12")
    }

    
    // MARK: Setters

    func testConnectToNetwork() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x59, 0x01] + [0x03, 0x00, 0x07, 0x01, 0x00, 0x04, 0x48, 0x4f, 0x4d, 0x45, 0x04, 0x00, 0x04, 0x01, 0x00, 0x01, 0x03, 0x05, 0x00, 0x11, 0x01, 0x00, 0x0e, 0x67, 0x72, 0x65, 0x61, 0x74, 0x5f, 0x73, 0x65, 0x63, 0x72, 0x65, 0x74, 0x31, 0x32]
        let setterBytes = AAWiFi.connectToNetwork(networkSSID: "HOME", networkSecurity: .wpa2Personal, password: "great_secret12")
    
        XCTAssertEqual(bytes, setterBytes)
    }

    func testForgetNetwork() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x59, 0x01] + [0x03, 0x00, 0x07, 0x01, 0x00, 0x04, 0x48, 0x4f, 0x4d, 0x45]
        let setterBytes = AAWiFi.forgetNetwork(networkSSID: "HOME")
    
        XCTAssertEqual(bytes, setterBytes)
    }

    func testEnableDisableWiFi() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x59, 0x01] + [0x01, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
        let setterBytes = AAWiFi.enableDisableWiFi(status: .enabled)
    
        XCTAssertEqual(bytes, setterBytes)
    }
}