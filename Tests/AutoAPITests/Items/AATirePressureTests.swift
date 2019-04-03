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
//  AATirePressureTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 03/04/2019.
//  Copyright © 2019 High Mobility GmbH. All rights reserved.
//

@testable import AutoAPI
import XCTest


class AATirePressureTests: XCTestCase {

    static var allTests = [("testBytes", testBytes),
                           ("testInit", testInit)]


    // MARK: XCTestCase

    func testBytes() {
        let bytes: [UInt8] = [
            0x03,                   // Rear Left tire
            0x40, 0x13, 0xD7, 0x0A  // Pressure is 2.31 BAR
        ]

        XCTAssertEqual(AATirePressure(location: .rearLeft, pressure: 2.31).bytes, bytes)
    }

    func testInit() {
        // Successful
        let bytes1: [UInt8] = [
            0x03,                   // Rear Left tire
            0x40, 0x13, 0xD7, 0x0A  // Pressure is 2.31 BAR
        ]

        if let pressure = AATirePressure(bytes: bytes1) {
            XCTAssertEqual(pressure.location, .rearLeft)
            XCTAssertEqual(pressure.pressure, 2.31)
        }
        else {
            XCTFail("Failed to initialise AATirePressure")
        }

        // Fail#1
        let bytes2: [UInt8] = [
            0x01    // Invalid bytes count
        ]

        XCTAssertNil(AATirePressure(bytes: bytes2))

        // Fail#2
        let bytes3: [UInt8] = [
            0x0F,                   // INVALID
            0x40, 0x13, 0xD7, 0x0A  // Pressure is 2.31 BAR
        ]

        XCTAssertNil(AATirePressure(bytes: bytes3))
    }
}
