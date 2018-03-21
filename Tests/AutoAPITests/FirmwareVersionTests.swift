//
// AutoAPITests
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
//  FirmwareVersionTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 28/11/2017.
//  Copyright © 2017 High Mobility. All rights reserved.
//

import AutoAPI
import XCTest


class FirmwareVersionTests: XCTestCase {

    static var allTests = [("testGetFirmwareVersion", testGetFirmwareVersion),
                           ("testState", testState)]


    // MARK: XCTestCase

    func testGetFirmwareVersion() {
        let bytes: [UInt8] = [
            0x00, 0x03, // MSB, LSB Message Identifier for Firmware Version
            0x00        // Message Type for Get Firmware Version
        ]

        XCTAssertEqual(FirmwareVersion.getFirmwareVersion, bytes)
    }

    func testState() {
        let bytes: [UInt8] = [
            0x00, 0x03, // MSB, LSB Message Identifier for Firmware Version
            0x01,       // Message Type for Firmware Version

            0x01,       // Property Identifier for Car SDK version
            0x00, 0x03, // Property size 3 bytes
            0x01,       // Major 1
            0x0f,       // Minor 15
            0x21,       // Patch is 33, giving the complete version "1.15.33"

            0x02,                                                                   // Property Identifier for Car SDK build
            0x00, 0x0C,                                                             // Property size 12 bytes
            0x62, 0x74, 0x73, 0x74, 0x61, 0x63, 0x6b, 0x2d, 0x75, 0x61, 0x72, 0x74, // "btstack-uart"

            0x03,                                                       // Property Identifier for Application version
            0x00, 0x09,                                                 // Property size 9 bytes
            0x76, 0x31, 0x2e, 0x35, 0x2d, 0x70, 0x72, 0x6f, 0x64        // "v1.5-prod"
        ]

        guard let firmwareVersion = AutoAPI.parseBinary(bytes) as? FirmwareVersion else {
            return XCTFail("Parsed value is not FirmwareVersion")
        }

        XCTAssertEqual(firmwareVersion.carSDKVersion?.major, 1)
        XCTAssertEqual(firmwareVersion.carSDKVersion?.minor, 15)
        XCTAssertEqual(firmwareVersion.carSDKVersion?.patch, 33)
        XCTAssertEqual(firmwareVersion.carSDKVersion?.string, "1.15.33")

        XCTAssertEqual(firmwareVersion.carSDKBuildName, "btstack-uart")
        XCTAssertEqual(firmwareVersion.applicationVersion, "v1.5-prod")
    }
}
