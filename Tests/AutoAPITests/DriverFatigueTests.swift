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
//  DriverFatigueTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 12/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import AutoAPI
import XCTest


class DriverFatigueTests: XCTestCase {

    static var allTests = [("testDetected", testDetected)]


    // MARK: XCTestCase

    func testDetected() {
        let bytes: [UInt8] = [
            0x00, 0x41, // MSB, LSB Message Identifier for Driver Fatigue
            0x01,       // Message Type for Driver Fatigue Detected

            0x01,       // Property Identifier for Fatigue Level
            0x00, 0x01, // Propert size is 1 byte
            0x00        // Light fatigue of the driver
        ]

        guard let driverFatigue = AutoAPI.parseBinary(bytes) as? AADriverFatigue else {
            return XCTFail("Parsed value is not DriverFatigue")
        }

        XCTAssertEqual(driverFatigue.fatigueLevel, .light)
    }
}
