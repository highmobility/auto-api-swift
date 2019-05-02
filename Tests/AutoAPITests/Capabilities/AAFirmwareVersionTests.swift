//
// AutoAPITests
// Copyright (C) 2019 High-Mobility GmbH
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
//  AAFirmwareVersionTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 28/11/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import AutoAPI
import XCTest


class AAFirmwareVersionTests: XCTestCase {

    static var allTests = [("testGetFirmwareVersion", testGetFirmwareVersion),
                           ("testState", testState)]


    // MARK: XCTestCase

    func testGetFirmwareVersion() {
        let bytes: [UInt8] = [
            0x00, 0x03, // MSB, LSB Message Identifier for Firmware Version
            0x00        // Message Type for Get Firmware Version
        ]

        XCTAssertEqual(AAFirmwareVersion.getVersion.bytes, bytes)
    }

    func testState() {
        let bytes: [UInt8] = [
            0x00, 0x03, // MSB, LSB Message Identifier for Firmware Version
            0x01,       // Message Type for Firmware Version

            0x01,       // Property identifier for Hmkit version
            0x00, 0x06, // Property size is 6 bytes
            0x01,       // Data component identifier
            0x00, 0x03, // Data component size is 3 bytes
            0x01,       // Major 1
            0x0F,       // Minor 15
            0x21,       // Patch is 33, giving the complete version "1.15.33"

            0x02,       // Property identifier for Hmkit build name
            0x00, 0x0F, // Property size is 15 bytes
            0x01,       // Data component identifier
            0x00, 0x0C, // Data component size is 12 bytes
            0x62, 0x74, 0x73, 0x74, 0x61, 0x63,
            0x6B, 0x2D, 0x75, 0x61, 0x72, 0x74, // btstack-uart

            0x03,       // Property identifier for Application version
            0x00, 0x0C, // Property size is 12 bytes
            0x01,       // Data component identifier
            0x00, 0x09, // Data component size is 9 bytes
            0x76, 0x31, 0x2E, 0x35, 0x2D, 0x70, 0x72, 0x6F, 0x64    // v1.5-prod
        ]

        guard let firmwareVersion = AAAutoAPI.parseBinary(bytes) as? AAFirmwareVersion else {
            return XCTFail("Parsed value is not AAFirmwareVersion")
        }

        XCTAssertEqual(firmwareVersion.hmkitVersion?.value?.major, 1)
        XCTAssertEqual(firmwareVersion.hmkitVersion?.value?.minor, 15)
        XCTAssertEqual(firmwareVersion.hmkitVersion?.value?.patch, 33)
        XCTAssertEqual(firmwareVersion.hmkitVersion?.value?.string, "1.15.33")
        XCTAssertEqual(firmwareVersion.hmkitBuildName?.value, "btstack-uart")
        XCTAssertEqual(firmwareVersion.applicationVersion?.value, "v1.5-prod")
    }
}
