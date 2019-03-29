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
//  AAAccelerationTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 26/03/2019.
//  Copyright © 2019 High Mobility GmbH. All rights reserved.
//

@testable import AutoAPI
import XCTest


class AAAccelerationTests: XCTestCase {

    static var allTests = [("testBytes", testBytes),
                           ("testInit", testInit)]


    // MARK: XCTestCase

    func testBytes() {
        let bytes: [UInt8] = [
            0x00,                   // Longitudinal
            0x3F, 0x9D, 0x70, 0xA4  // 1.23g
        ]

        XCTAssertEqual(AAAcceleration(type: .longitudinal, value: 1.23).bytes, bytes)
    }

    func testInit() {
        // Successful
        let bytes1: [UInt8] = [
            0x01,                   // Lateral Acceleration
            0x3F, 0x11, 0x26, 0xE9  // 0.567g
        ]

        if let acceleration = AAAcceleration(bytes: bytes1) {
            XCTAssertEqual(acceleration.type, .lateral)
            XCTAssertEqual(acceleration.value, 0.567)
        }
        else {
            XCTFail("Failed to initialise AAAcceleration")
        }

        // Fail#1
        let bytes2: [UInt8] = [
            0x01, 0x3F, 0x11, 0x26  // Invalid bytes count
        ]

        XCTAssertNil(AAAcceleration(bytes: bytes2))

        // Fail#2
        let bytes3: [UInt8] = [
            0x05,                   // Invalid Acceleration
            0x3F, 0x11, 0x26, 0xE9  // 0.567g
        ]

        XCTAssertNil(AAAcceleration(bytes: bytes3))
    }
}
