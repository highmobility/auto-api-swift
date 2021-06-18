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
//  ParkingBrakeTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 07/12/2017.
//

import AutoAPI
import XCTest


class ParkingBrakeTests: XCTestCase {

    static var allTests = [("testActivateInactivate", testActivateInactivate),
                           ("testGetState", testGetState),
                           ("testState", testState)]


    // MARK: XCTestCase

    func testActivateInactivate() {
        let bytes: [UInt8] = [
            0x00, 0x58, // MSB, LSB Message Identifier for Parking Brake
            0x02,       // Message Type for Set Parking Brake
            0x00        // Inactivate
        ]

        XCTAssertEqual(ParkingBrake.activate(false), bytes)
    }

    func testGetState() {
        let bytes: [UInt8] = [
            0x00, 0x58, // MSB, LSB Message Identifier for Parking Brake
            0x00        // Message Type for Get Parking Brake State
        ]

        XCTAssertEqual(ParkingBrake.getParkingBrakeState, bytes)
    }

    func testState() {
        let bytes: [UInt8] = [
            0x00, 0x58, // MSB, LSB Message Identifier for Parking Brake
            0x01,       // Message Type for Parking Brake State

            0x01,       // Property Identifier for Parking Brake
            0x00, 0x01, // Property size 1 byte
            0x01        // Parking brake active
        ]

        guard let parkingBrake = AAAutoAPI.parseBinary(bytes) as? ParkingBrake else {
            return XCTFail("Parsed value is not ParkingBrake")
        }

        XCTAssertEqual(parkingBrake.isActive, true)
    }
}
