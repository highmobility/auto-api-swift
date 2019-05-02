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
//  AACheckControlMessageTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 26/03/2019.
//  Copyright © 2019 High Mobility GmbH. All rights reserved.
//

@testable import AutoAPI
import XCTest


class AACheckControlMessageTests: XCTestCase {

    static var allTests = [("testBytes", testBytes),
                           ("testInit", testInit)]


    // MARK: XCTestCase

    func testBytes() {
        let bytes: [UInt8] = [
            0x00, 0x01,                         // The id is 1
            0x00, 0x01, 0x9C, 0x78,             // The remaining time is 105 592 minutes
            0x00, 0x0C,                         // The following text size is 12 bytes
            0x43, 0x68, 0x65, 0x63, 0x6B, 0x20,
            0x65, 0x6E, 0x67, 0x69, 0x6E, 0x65, // "Check engine"
            0x05,                               // Size of the status is 5 bytes
            0x41, 0x6C, 0x65, 0x72, 0x74        // "Alert"
        ]

        XCTAssertEqual(AACheckControlMessage(id: 1, remainingMinutes: 105_592, status: "Alert", text: "Check engine").bytes, bytes)
    }

    func testInit() {
        // Successful
        let bytes1: [UInt8] = [
            0x00, 0x01,                         // The id is 1
            0x00, 0x01, 0x9C, 0x78,             // The remaining time is 105 592 minutes
            0x00, 0x0C,                         // The following text size is 12 bytes
            0x43, 0x68, 0x65, 0x63, 0x6B, 0x20,
            0x65, 0x6E, 0x67, 0x69, 0x6E, 0x65, // "Check engine"
            0x05,                               // Size of the status is 5 bytes
            0x41, 0x6C, 0x65, 0x72, 0x74        // "Alert"
        ]

        if let message = AACheckControlMessage(bytes: bytes1) {
            XCTAssertEqual(message.id, 1)
            XCTAssertEqual(message.remainingMinutes, 105_592)
            XCTAssertEqual(message.text, "Check engine")
            XCTAssertEqual(message.status, "Alert")
        }
        else {
            XCTFail("Failed to initialise AACheckControlMessage")
        }

        // Fail#1
        let bytes2: [UInt8] = [
            0x00, 0x01,                         // The id is 1
            0x00, 0x01, 0x9C, 0x78,             // The remaining time is 105 592 minutes
            0x00, 0x0C                          // The following text size is 12 bytes
            // Missing bytes
        ]

        XCTAssertNil(AACheckControlMessage(bytes: bytes2))

        // Fail#2
        let bytes3: [UInt8] = [
            0x00, 0x01,                         // The id is 1
            0x00, 0x01, 0x9C, 0x78,             // The remaining time is 105 592 minutes
            0x33, 0x0C                          // The following text size is A LOT of bytes
            // Missing bytes
        ]

        XCTAssertNil(AACheckControlMessage(bytes: bytes3))

        // Fail#3
        let bytes4: [UInt8] = [
            0x00, 0x01,                         // The id is 1
            0x00, 0x01, 0x9C, 0x78,             // The remaining time is 105 592 minutes
            0x00, 0x0C,                         // The following text size is 12 bytes
            0x43, 0x68, 0x65, 0x63, 0x6B, 0x20,
            0x65, 0x6E, 0x67, 0x69, 0x6E, 0x65  // "Check engine"
            // Missing bytes
        ]

        XCTAssertNil(AACheckControlMessage(bytes: bytes4))

        // Fail#4
        let bytes5: [UInt8] = [
            0x00, 0x01,                         // The id is 1
            0x00, 0x01, 0x9C, 0x78,             // The remaining time is 105 592 minutes
            0x00, 0x0C,                         // The following text size is 12 bytes
            0x43, 0x68, 0x65, 0x63, 0x6B, 0x20,
            0x65, 0x6E, 0x67, 0x69, 0x6E, 0x65, // "Check engine"
            0xA5,                               // Size of the status is MANY bytes
            0x41, 0x6C, 0x65, 0x72, 0x74        // "Alert"
        ]

        XCTAssertNil(AACheckControlMessage(bytes: bytes5))

        // Fail#5
        let bytes6: [UInt8] = [
            0x00, 0x01,                         // The id is 1
            0x00, 0x01, 0x9C, 0x78,             // The remaining time is 105 592 minutes
            0x00, 0x0C,                         // The following text size is 12 bytes
            0x43, 0x68, 0x65, 0x63, 0x6B, 0x20,
            0x65, 0x6E, 0x67, 0x69, 0x6E, 0x65, // "Check engine"
            0x05,                               // Size of the status is 5 bytes
            0xAA, 0x6C, 0x05, 0x12, 0x00        // Invalid String
        ]

        XCTAssertNil(AACheckControlMessage(bytes: bytes6))
    }
}
