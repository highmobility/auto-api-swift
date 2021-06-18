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
//  TachographTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 30/04/2018.
//

import AutoAPI
import XCTest


class TachographTests: XCTestCase {
    
    static var allTests = [("testGetState", testGetState),
                           ("testState", testState)]


    // MARK: XCTestCase

    func testGetState() {
        let bytes: [UInt8] = [
            0x00, 0x64, // MSB, LSB Message Identifier for Tachograph
            0x00        // Message Type for Get Tachograph State
        ]

        XCTAssertEqual(Tachograph.getTachographState, bytes)
    }

    func testState() {
        let bytes: [UInt8] = [
            0x00, 0x64, // MSB, LSB Message Identifier for Tachograph
            0x01,       // Message Type for Tachograph State


            0x01,       // Property identifier for Driver working state
            0x00, 0x02, // Property size is 2 bytes
            0x01,       // Driver 1
            0x02,       // Driver is working

            0x01,       // Property identifier for Driver working state
            0x00, 0x02, // Property size is 2 bytes
            0x02,       // Driver 2
            0x00,       // Driver is resting


            0x02,       // Property identifier for Driver time state
            0x00, 0x02, // Property size is 2 bytes
            0x01,       // Driver 1
            0x01,       // 4½ hours of driving reached

            0x02,       // Property identifier for Driver time state
            0x00, 0x02, // Property size is 2 bytes
            0x02,       // Driver 2
            0x06,       // 16 hours of driving reached


            0x03,       // Property identifier for Driver card
            0x00, 0x02, // Property size is 2 bytes
            0x01,       // Driver 1
            0x01,       // Driver card present

            0x03,       // Property identifier for Driver card
            0x00, 0x02, // Property size is 2 bytes
            0x02,       // Driver 2
            0x01,       // Driver card present


            0x04,       // Property identifier for Vehicle motion
            0x00, 0x01, // Property size is 1 bytes
            0x01,       // Vehicle motion detected

            0x05,       // Property identifier for Vehicle overspeed
            0x00, 0x01, // Property size is 1 bytes
            0x00,       // No overspeed

            0x06,       // Property identifier for Vehicle direction
            0x00, 0x01, // Property size is 1 bytes
            0x00,       // Vehicle direction is forward

            0x07,       // Property identifier for Vehicle speed
            0x00, 0x02, // Property size is 2 bytes
            0x00, 0x50  // Vehicle speed is 80 km/h
        ]

        guard let tachograph = AAAutoAPI.parseBinary(bytes) as? Tachograph else {
            return XCTFail("Parsed value is not Tachograph")
        }

        XCTAssertEqual(tachograph.isVehicleMotionDetected, true)
        XCTAssertEqual(tachograph.isVehicleOverspeed, false)
        XCTAssertEqual(tachograph.vehicleDirection, .forward)
        XCTAssertEqual(tachograph.vehicleSpeed, 80)

        // Drivers Working States
        XCTAssertEqual(tachograph.driversWorkingStates?.count, 2)

        if let driverWorkingState = tachograph.driversWorkingStates?.first(where: { $0.driverNumber == 1 }) {
            XCTAssertEqual(driverWorkingState.state, .working)
        }
        else {
            XCTFail("Drivers Working States doesn't contain Driver #1")
        }

        if let driverWorkingState = tachograph.driversWorkingStates?.first(where: { $0.driverNumber == 2 }) {
            XCTAssertEqual(driverWorkingState.state, .resting)
        }
        else {
            XCTFail("Drivers Working States doesn't contain Driver #2")
        }

        // Drivers Time States
        XCTAssertEqual(tachograph.driversTimeStates?.count, 2)

        if let driverTimeState = tachograph.driversTimeStates?.first(where: { $0.driverNumber == 1 }) {
            XCTAssertEqual(driverTimeState.state, .quarterBefore4½Hours)
        }
        else {
            XCTFail("Drivers Time States doesn't contain Driver #1")
        }

        if let driverTimeState = tachograph.driversTimeStates?.first(where: { $0.driverNumber == 2 }) {
            XCTAssertEqual(driverTimeState.state, .reached16Hours)
        }
        else {
            XCTFail("Drivers Time States doesn't contain Driver #2")
        }

        // Drivers Cards
        XCTAssertEqual(tachograph.driversCards?.count, 2)

        if let driverCard = tachograph.driversCards?.first(where: { $0.driverNumber == 1 }) {
            XCTAssertEqual(driverCard.isPresent, true)
        }
        else {
            XCTFail("Drivers Cards doesn't contain Driver #1")
        }

        if let driverCard = tachograph.driversCards?.first(where: { $0.driverNumber == 2 }) {
            XCTAssertEqual(driverCard.isPresent, true)
        }
        else {
            XCTFail("Drivers Cards doesn't contain Driver #2")
        }
    }
}











