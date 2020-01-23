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
//  ValetModeTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 12/12/2017.
//

import AutoAPI
import XCTest


class ValetModeTests: XCTestCase {

    static var allTests = [("testActivateValetMode", testActivateValetMode),
                           ("testGetState", testGetState),
                           ("testState", testState)]


    // MARK: XCTestCase

    func testActivateValetMode() {
        let bytes: [UInt8] = [
            0x00, 0x28, // MSB, LSB Message Identifier for Valet Mode
            0x02,       // Message Type for Activate/Deactivate Valet Mode
            0x01        // Activate
        ]

        XCTAssertEqual(ValetMode.activateValetMode(true), bytes)
    }

    func testGetState() {
        let bytes: [UInt8] = [
            0x00, 0x28, // MSB, LSB Message Identifier for Valet Mode
            0x00        // Message Type for Get Valet Mode
        ]

        XCTAssertEqual(ValetMode.getValetMode, bytes)
    }

    func testState() {
        let bytes: [UInt8] = [
            0x00, 0x28, // MSB, LSB Message Identifier for Valet Mode
            0x01,       // Message Type for Valet Mode

            0x01,       // Property Identifier for Valet Mode
            0x00, 0x01, // Property size is 1 byte
            0x01        // Activated
        ]

        guard let valetMode = AutoAPI.parseBinary(bytes) as? ValetMode else {
            return XCTFail("Parsed value is not ValetMode")
        }

        XCTAssertEqual(valetMode.isActive, true)
    }
}
