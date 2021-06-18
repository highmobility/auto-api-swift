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
//  FirmwareVersionTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 28/11/2017.
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

        guard let firmwareVersion = AAAutoAPI.parseBinary(bytes) as? FirmwareVersion else {
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
