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
//  AAPropertyComponentTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 04/04/2019.
//  Copyright © 2019 High Mobility GmbH. All rights reserved.
//

@testable import AutoAPI
import XCTest


class AAPropertyComponentTests: XCTestCase {

    static var allTests = [("testBytes", testBytes),
                           ("testComponents", testComponents),
                           ("testInit", testInit)]


    // MARK: XCTestCase

    func testBytes() {
        let bytes: [UInt8] = [
            0x01,       // Data component identifier
            0x00, 0x01, // Component size 1 byte
            0x05        // 5 seats
        ]

        XCTAssertEqual(AAPropertyComponent(type: .data, value: [0x05]).bytes, bytes)
    }

    func testComponents() {
        // Successful
        let bytes1: [UInt8] = [
            0x01,       // Data component identifier
            0x00, 0x01, // Component size 1 byte
            0x05,       // 5 seats
            0x02,       // Timestamp component identifier
            0x00, 0x08, // Component size 8 byte
            0x00, 0x00, 0x01, 0x69, 0xE7, 0xBF, 0x2E, 0x60  // 4 April 2019 at 09:47:40 GMT
        ]

        XCTAssertNil(AAPropertyComponents(bytes: bytes1).component(for: .failure))

        // Failure
        let bytes2: [UInt8] = [
            0x01,       // Data component identifier
            0x00, 0x51, // Component size is INVALID
            0x05,       // 5 seats
            0x02,       // Timestamp component identifier
            0x00, 0x08, // Component size 8 byte
            0x00, 0x00, 0x01, 0x69, 0xE7, 0xBF, 0x2E, 0x60  // 4 April 2019 at 09:47:40 GMT
        ]

        XCTAssertNil(AAPropertyComponents(bytes: bytes2).component(for: .data))
    }

    func testInit() {
        // Successful
        let bytes1: [UInt8] = [
            0x01,       // Data component identifier
            0x00, 0x01, // Component size 1 byte
            0x05        // 5 seats
        ]

        if let component = AAPropertyComponent(bytes: bytes1) {
            XCTAssertEqual(component.type, .data)
            XCTAssertEqual(component.value, [0x05])
        }
        else {
            XCTFail("Failed to initialise AAPropertyComponent")
        }

        // Fail#1
        let bytes2: [UInt8] = [
            0x01    // Invalid bytes count
        ]

        XCTAssertNil(AAPropertyComponent(bytes: bytes2))

        // Fail#2
        let bytes3: [UInt8] = [
            0x01,       // Data component identifier
            0x00, 0x51, // Component size is INVALID
            0x05        // 5 seats
        ]

        XCTAssertNil(AAPropertyComponent(bytes: bytes3))

        // Fail#3
        let bytes4: [UInt8] = [
            0x0F,       // INVALID
            0x00, 0x01, // Component size is 1 byte
            0x05        // 5 seats
        ]

        XCTAssertNil(AAPropertyComponent(bytes: bytes4))
    }
}
