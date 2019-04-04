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
//  AAPropertyTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 04/04/2019.
//  Copyright © 2019 High Mobility GmbH. All rights reserved.
//

@testable import AutoAPI
import XCTest


class AAPropertyTests: XCTestCase {

    static var allTests = [("testDescription", testDescription),
                           ("testInit", testInit),
                           ("testValue", testValue)]


    // MARK: XCTestCase

    func testDescription() {
        // With value
        let bytes1: [UInt8] = [
            0x0B,       // Property Identifier for Number of seats
            0x00, 0x04, // Property size 4 byte
            0x01,       // Data component identifier
            0x00, 0x01, // Component size 1 byte
            0x05        // 5 seats
        ]
        let description1 = "AAProperty<UInt8>, id: 0x0B, failure: nil, timestamp: nil, value: 5"

        XCTAssertEqual(AAProperty<UInt8>(bytes: bytes1)?.description, description1)

        // With timestamp
        let bytes2: [UInt8] = [
            0x0B,       // Property Identifier for Number of seats
            0x00, 0x0B, // Property size 11 byte
            0x02,       // Timestamp component identifier
            0x00, 0x08, // Component size 8 byte
            0x00, 0x00, 0x01, 0x69, 0xE7, 0xBF, 0x2E, 0x60  // 4 April 2019 at 09:47:40 GMT
        ]
        let description2 = "AAProperty<UInt8>, id: 0x0B, failure: nil, timestamp: 2019-04-04 09:47:40 +0000, value: nil"

        XCTAssertEqual(AAProperty<UInt8>(bytes: bytes2)?.description, description2)

        // With failure
        let bytes3: [UInt8] = [
            0x0B,       // Property Identifier for Number of seats
            0x00, 0x10, // Property size 16 byte
            0x03,       // Failure component identifier
            0x00, 0x0D, // Component size 13 byte
            0x00,       // Property rate limit has been exceeded
            0x00, 0x0A, // The failure description is 10 bytes
            0x54, 0x72, 0x79, 0x20, 0x69, 0x6e, 0x20, 0x34, 0x30, 0x73 // "Try in 40s"
        ]
        let description3 = #"AAProperty<UInt8>, id: 0x0B, failure: AAPropertyFailure(reason: AutoAPI.AAPropertyFailureReason.rateLimit, description: "Try in 40s"), timestamp: nil, value: nil"#

        XCTAssertEqual(AAProperty<UInt8>(bytes: bytes3)?.description, description3)
    }

    func testInit() {
        // Successful#1
        let bytes1: [UInt8] = [
            0x0B,       // Property Identifier for Number of seats
            0x00, 0x04, // Property size 4 byte
            0x01,       // Data component identifier
            0x00, 0x01, // Component size 1 byte
            0x05        // 5 seats
        ]

        if let property = AAProperty<UInt8>(bytes: bytes1) {
            XCTAssertEqual(property.value, 5)
        }
        else {
            XCTFail("Failed to initialise AAProperty")
        }

        // Successful#2
        XCTAssertEqual(AAProperty<UInt8>(identifier: 0x0B, value: 5)?.bytes, bytes1)

        // Fail#1
        let bytes2: [UInt8] = [
            0x01    // Invalid bytes count
        ]

        XCTAssertNil(AAProperty<UInt8>(bytes: bytes2))
    }

    func testValue() {
        // Success
        let bytes1: [UInt8] = [
            0x0B,       // Property Identifier for Number of seats
            0x00, 0x04, // Property size 4 byte
            0x01,       // Data component identifier
            0x00, 0x01, // Component size 1 byte
            0x05        // 5 seats
        ]

        XCTAssertEqual(AAProperty<UInt8>(bytes: bytes1)?.value, 5)

        // Failure
        let bytes2: [UInt8] = [
            0x0B,       // Property Identifier for Number of seats
            0x00, 0x04, // Property size 4 byte
            0x0F,       // INVALID
            0x00, 0x01, // Component size 1 byte
            0x05        // 5 seats
        ]

        XCTAssertNil(AAProperty<UInt8>(bytes: bytes2)?.value)
    }
}
