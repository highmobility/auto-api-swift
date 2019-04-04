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
//  AAPropertyFailureTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 04/04/2019.
//  Copyright © 2019 High Mobility GmbH. All rights reserved.
//

@testable import AutoAPI
import XCTest


class AAPropertyFailureTests: XCTestCase {

    static var allTests = [("testBytes", testBytes),
                           ("testInit", testInit)]


    // MARK: XCTestCase

    func testBytes() {
        let bytes: [UInt8] = [
            0x00,       // Property rate limit has been exceeded
            0x00, 0x0A, // The failure description is 10 bytes
            0x54, 0x72, 0x79, 0x20, 0x69, 0x6e, 0x20, 0x34, 0x30, 0x73 // "Try in 40s"
        ]

        XCTAssertEqual(AAPropertyFailure(bytes: bytes)?.bytes, bytes)
    }

    func testInit() {
        // Successful
        let bytes1: [UInt8] = [
            0x00,       // Property rate limit has been exceeded
            0x00, 0x0A, // The failure description is 10 bytes
            0x54, 0x72, 0x79, 0x20, 0x69, 0x6e, 0x20, 0x34, 0x30, 0x73 // "Try in 40s"
        ]

        if let failure = AAPropertyFailure(bytes: bytes1) {
            XCTAssertEqual(failure.reason, .rateLimit)
            XCTAssertEqual(failure.description, "Try in 40s")
        }
        else {
            XCTFail("Failed to initialise AAPropertyFailure")
        }

        // Fail#1
        let bytes2: [UInt8] = [
            0x01    // Invalid bytes count
        ]

        XCTAssertNil(AAPropertyFailure(bytes: bytes2))

        // Fail#2
        let bytes3: [UInt8] = [
            0x00,       // Property rate limit has been exceeded
            0x00, 0x5A, // The failure description is INVALID
            0x54, 0x72, 0x79, 0x20, 0x69, 0x6e, 0x20, 0x34, 0x30, 0x73 // "Try in 40s"
        ]

        XCTAssertNil(AAPropertyFailure(bytes: bytes3))

        // Fail#3
        let bytes4: [UInt8] = [
            0x0F,       // INVALID
            0x00, 0x0A, // The failure description is 10 bytes
            0x54, 0x72, 0x79, 0x20, 0x69, 0x6e, 0x20, 0x34, 0x30, 0x73 // "Try in 40s"
        ]

        XCTAssertNil(AAPropertyFailure(bytes: bytes4))
    }
}
