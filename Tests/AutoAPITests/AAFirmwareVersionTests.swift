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
//  AAFirmwareVersionTest.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import AutoAPI
import XCTest


class AAFirmwareVersionTest: XCTestCase {

    // MARK: State Properties

    func testHmKitVersion() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x03, 0x01, 0x01, 0x00, 0x06, 0x01, 0x00, 0x03, 0x01, 0x0f, 0x21]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAFirmwareVersion else {
            return XCTFail("Could not parse bytes as AAFirmwareVersion")
        }
    
        XCTAssertEqual(capability.hmKitVersion?.value, AAHMKitVersion(major: 1, minor: 15, patch: 33))
    }

    func testApplicationVersion() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x03, 0x01, 0x03, 0x00, 0x0c, 0x01, 0x00, 0x09, 0x76, 0x31, 0x2e, 0x35, 0x2d, 0x70, 0x72, 0x6f, 0x64]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAFirmwareVersion else {
            return XCTFail("Could not parse bytes as AAFirmwareVersion")
        }
    
        XCTAssertEqual(capability.applicationVersion?.value, "v1.5-prod")
    }

    func testHmKitBuildName() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x03, 0x01, 0x02, 0x00, 0x0f, 0x01, 0x00, 0x0c, 0x62, 0x74, 0x73, 0x74, 0x61, 0x63, 0x6b, 0x2d, 0x75, 0x61, 0x72, 0x74]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAFirmwareVersion else {
            return XCTFail("Could not parse bytes as AAFirmwareVersion")
        }
    
        XCTAssertEqual(capability.hmKitBuildName?.value, "btstack-uart")
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