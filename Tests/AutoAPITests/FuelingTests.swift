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
//  FuelingTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 12/12/2017.
//

import AutoAPI
import XCTest


class FuelingTests: XCTestCase {

    static var allTests = [("testOpenGasFlap", testOpenGasFlap)]


    // MARK: XCTestCase

    func testGetState() {
        let bytes: [UInt8] = [
            0x00, 0x40, // MSB, LSB Message Identifier for Fueling
            0x00 // Message Type for Get Gas Flap State
        ]

        XCTAssertEqual(Fueling.getGasFlapState, bytes)
    }

    func testState() {
        let bytes: [UInt8] = [
            0x00, 0x40, // MSB, LSB Message Identifier for Fueling
            0x01, // Message Type for Gas Flap State

            0x01,       // Property Identifier for Gas Flap
            0x00, 0x01, // Property size 1 byte
            0x01        // Gas flap open
        ]

        guard let fueling = AAAutoAPI.parseBinary(bytes) as? Fueling else {
            return XCTFail("Parsed value is not Fueling")
        }

        XCTAssertEqual(fueling.gasFlapState, .open)
    }

    func testOpenGasFlap() {
        let bytes: [UInt8] = [
            0x00, 0x40, // MSB, LSB Message Identifier for Fueling
            0x02        // Message Type for Open Gas Flap
        ]

        XCTAssertEqual(Fueling.openGasFlap, bytes)
    }
}
