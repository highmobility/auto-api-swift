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
//  AABasicPropertyTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 04/04/2019.
//  Copyright © 2019 High Mobility GmbH. All rights reserved.
//

@testable import AutoAPI
import XCTest


class AABasicPropertyTests: XCTestCase {

    static var allTests = [("testProperties", testProperties),
                           ("testInit", testInit)]


    // MARK: XCTestCase

    func testProperties() {
        let bytes: [UInt8] = [
            0x0B,       // Property Identifier for Number of seats
            0x00, 0x1F, // Property size 31 byte

            0x01,       // Data component identifier
            0x00, 0x01, // Component size 1 byte
            0x05,       // 5 seats

            0x02,       // Timestamp component identifier
            0x00, 0x08, // Component size 8 byte
            0x00, 0x00, 0x01, 0x69, 0xE7, 0xBF, 0x2E, 0x60, // 4 April 2019 at 09:47:40 GMT

            0x03,       // Failure component identifier
            0x00, 0x0D, // Component size 13 byte
            0x00,       // Property rate limit has been exceeded
            0x00, 0x0A, // The failure description is 10 bytes
            0x54, 0x72, 0x79, 0x20, 0x69, 0x6e, 0x20, 0x34, 0x30, 0x73 // "Try in 40s"
        ]

        guard let property = AABasicProperty(bytes: bytes) else {
            return XCTFail("Failed to initialise AABasicProperty")
        }

        XCTAssertEqual(property.identifier, 0x0B)
        XCTAssertEqual(property.failure, AAPropertyFailure(reason: .rateLimit, description: "Try in 40s"))
        XCTAssertEqual(property.timestamp, Date(timeIntervalSince1970: 1_554_371_260.0))
        XCTAssertEqual(property.valueBytes, [0x05])
    }

    func testInit() {
        // Successful already tested in -testProperties

        // Fail#1
        let bytes1: [UInt8] = [
            0x01    // Invalid bytes count
        ]

        XCTAssertNil(AABasicProperty(bytes: bytes1))

        // Fail#2
        let bytes2: [UInt8] = [
            0x0B,       // Property Identifier for Number of seats
            0x00, 0x1F, // Property size is INVALID

            0x01,       // Data component identifier
            0x00, 0x01, // Component size 1 byte
            0x05        // 5 seats
        ]

        XCTAssertNil(AABasicProperty(bytes: bytes2))
    }
}
