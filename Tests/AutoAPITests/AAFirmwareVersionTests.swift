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
//  AAFirmwareVersionTest.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import AutoAPI
import XCTest


class AAFirmwareVersionTest: XCTestCase {

    // MARK: State Properties

    func testHmKitBuildName() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x03, 0x01, 0x02, 0x00, 0x0f, 0x01, 0x00, 0x0c, 0x62, 0x74, 0x73, 0x74, 0x61, 0x63, 0x6b, 0x2d, 0x75, 0x61, 0x72, 0x74]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAFirmwareVersion else {
            return XCTFail("Could not parse bytes as AAFirmwareVersion")
        }
    
        XCTAssertEqual(capability.hmKitBuildName?.value, "btstack-uart")
    }

    func testApplicationVersion() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x03, 0x01, 0x03, 0x00, 0x0c, 0x01, 0x00, 0x09, 0x76, 0x31, 0x2e, 0x35, 0x2d, 0x70, 0x72, 0x6f, 0x64]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAFirmwareVersion else {
            return XCTFail("Could not parse bytes as AAFirmwareVersion")
        }
    
        XCTAssertEqual(capability.applicationVersion?.value, "v1.5-prod")
    }

    func testHmKitVersion() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x03, 0x01, 0x01, 0x00, 0x06, 0x01, 0x00, 0x03, 0x01, 0x0f, 0x21]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAFirmwareVersion else {
            return XCTFail("Could not parse bytes as AAFirmwareVersion")
        }
    
        XCTAssertEqual(capability.hmKitVersion?.value, AAHMKitVersion(major: 1, minor: 15, patch: 33))
    }

    
    // MARK: Getters

    func testGetFirmwareVersion() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x03, 0x00]
    
        XCTAssertEqual(bytes, AAFirmwareVersion.getFirmwareVersion())
    }
    
    func testGetFirmwareVersionProperties() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x03, 0x00, 0x03]
        let getterBytes = AAFirmwareVersion.getFirmwareVersionProperties(propertyIDs: .applicationVersion)
    
        XCTAssertEqual(bytes, getterBytes)
    }
}