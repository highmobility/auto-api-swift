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
//  AATachographTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 30/04/2018.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import AutoAPI
import XCTest


class AATachographTests: XCTestCase {
    
    static var allTests = [("testGetState", testGetState),
                           ("testState", testState)]


    // MARK: XCTestCase

    func testGetState() {
        let bytes: [UInt8] = [
            0x00, 0x64, // MSB, LSB Message Identifier for Tachograph
            0x00        // Message Type for Get Tachograph State
        ]

        XCTAssertEqual(AATachograph.getState.bytes, bytes)
    }

    func testState() {
        let bytes: [UInt8] = [
            0x00, 0x64, // MSB, LSB Message Identifier for Tachograph
            0x01,       // Message Type for Tachograph State


            0x01,       // Property identifier for Driver working state
            0x00, 0x05, // Property size is 5 bytes
            0x01,       // Data component
            0x00, 0x02, // Data component size is 2 bytes
            0x01,       // Driver 1
            0x02,       // Driver is working

            0x01,       // Property identifier for Driver working state
            0x00, 0x05, // Property size is 5 bytes
            0x01,       // Data component
            0x00, 0x02, // Data component size is 2 bytes
            0x02,       // Driver 2
            0x00,       // Driver is resting


            0x02,       // Property identifier for Driver time state
            0x00, 0x05, // Property size is 5 bytes
            0x01,       // Data component
            0x00, 0x02, // Data component size is 2 bytes
            0x01,       // Driver 1
            0x01,       // 4½ hours of driving reached

            0x02,       // Property identifier for Driver time state
            0x00, 0x05, // Property size is 5 bytes
            0x01,       // Data component
            0x00, 0x02, // Data component size is 2 bytes
            0x02,       // Driver 2
            0x06,       // 16 hours of driving reached


            0x03,       // Property identifier for Driver card
            0x00, 0x05, // Property size is 5 bytes
            0x01,       // Data component
            0x00, 0x02, // Data component size is 2 bytes
            0x01,       // Driver 1
            0x01,       // Driver card present

            0x03,       // Property identifier for Driver card
            0x00, 0x05, // Property size is 5 bytes
            0x01,       // Data component
            0x00, 0x02, // Data component size is 2 bytes
            0x02,       // Driver 2
            0x01,       // Driver card present


            0x04,       // Property identifier for Vehicle motion
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component
            0x00, 0x01, // Data component size is 1 bytes
            0x01,       // Vehicle motion detected

            0x05,       // Property identifier for Vehicle overspeed
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component
            0x00, 0x01, // Data component size is 1 bytes
            0x00,       // No overspeed

            0x06,       // Property identifier for Vehicle direction
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component
            0x00, 0x01, // Data component size is 1 bytes
            0x00,       // Vehicle direction is forward

            0x07,       // Property identifier for Vehicle speed
            0x00, 0x05, // Property size is 5 bytes
            0x01,       // Data component
            0x00, 0x02, // Data component size is 2 bytes
            0x00, 0x50  // Vehicle speed is 80 km/h
        ]

        guard let tachograph = AAAutoAPI.parseBinary(bytes) as? AATachograph else {
            return XCTFail("Parsed value is not AATachograph")
        }

        XCTAssertEqual(tachograph.vehicleMotionState?.value, .moving)
        XCTAssertEqual(tachograph.vehicleOverspeedActive?.value, .inactive)
        XCTAssertEqual(tachograph.vehicleDirection?.value, .forward)
        XCTAssertEqual(tachograph.vehicleSpeed?.value, 80)

        // Drivers Working States
        XCTAssertEqual(tachograph.driversWorkingStates?.count, 2)

        if let driverWorkingState = tachograph.driversWorkingStates?.first(where: { $0.value?.driverNumber == 1 }) {
            XCTAssertEqual(driverWorkingState.value?.state, .working)
        }
        else {
            XCTFail("Drivers Working States doesn't contain Driver #1")
        }

        if let driverWorkingState = tachograph.driversWorkingStates?.first(where: { $0.value?.driverNumber == 2 }) {
            XCTAssertEqual(driverWorkingState.value?.state, .resting)
        }
        else {
            XCTFail("Drivers Working States doesn't contain Driver #2")
        }

        // Drivers Time States
        XCTAssertEqual(tachograph.driversTimeStates?.count, 2)

        if let driverTimeState = tachograph.driversTimeStates?.first(where: { $0.value?.driverNumber == 1 }) {
            XCTAssertEqual(driverTimeState.value?.state, .quarterBefore4½Hours)
        }
        else {
            XCTFail("Drivers Time States doesn't contain Driver #1")
        }

        if let driverTimeState = tachograph.driversTimeStates?.first(where: { $0.value?.driverNumber == 2 }) {
            XCTAssertEqual(driverTimeState.value?.state, .reached16Hours)
        }
        else {
            XCTFail("Drivers Time States doesn't contain Driver #2")
        }

        // Drivers Cards
        XCTAssertEqual(tachograph.driversCards?.count, 2)

        if let driverCard = tachograph.driversCards?.first(where: { $0.value?.driverNumber == 1 }) {
            XCTAssertEqual(driverCard.value?.present, .present)
        }
        else {
            XCTFail("Drivers Cards doesn't contain Driver #1")
        }

        if let driverCard = tachograph.driversCards?.first(where: { $0.value?.driverNumber == 2 }) {
            XCTAssertEqual(driverCard.value?.present, .present)
        }
        else {
            XCTFail("Drivers Cards doesn't contain Driver #2")
        }
    }
}
