//
// AutoAPI
// Copyright (C) 2020 High-Mobility GmbH
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
//  AAWiFiTest.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import AutoAPI
import XCTest


class AAWiFiTest: XCTestCase {

    // MARK: State Properties

    func testNetworkSSID() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x59, 0x01, 0x03, 0x00, 0x07, 0x01, 0x00, 0x04, 0x48, 0x4f, 0x4d, 0x45]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAWiFi else {
            return XCTFail("Could not parse bytes as AAWiFi")
        }
    
        XCTAssertEqual(capability.networkSSID?.value, "HOME")
    }

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