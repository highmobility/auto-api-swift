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
//  AAConditionBasedServiceTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 03/04/2019.
//  Copyright © 2019 High Mobility GmbH. All rights reserved.
//

@testable import AutoAPI
import XCTest


class AAConditionBasedServiceTests: XCTestCase {

    static var allTests = [("testBytes", testBytes),
                           ("testInit", testInit)]


    // MARK: XCTestCase

    func testBytes() {
        // Successful
        let bytes: [UInt8] = [
            0x13,                                                               // 2019
            0x05,                                                               // May
            0x00, 0x03,                                                         // Identifier is 3
            0x00,                                                               // Status is OK
            0x00, 0x0B,                                                         // Text size is 11 bytes
            0x42, 0x72, 0x61, 0x6B, 0x65, 0x20, 0x66, 0x6C, 0x75, 0x69, 0x64,   // Text is "Brake fluid"
            0x00, 0x2C,                                                         // Description size is 44 bytes
            0x4E, 0x65, 0x78, 0x74, 0x20, 0x63, 0x68, 0x61, 0x6E, 0x67, 0x65,
            0x20, 0x61, 0x74, 0x20, 0x73, 0x70, 0x65, 0x63, 0x69, 0x66, 0x69,
            0x65, 0x64, 0x20, 0x64, 0x61, 0x74, 0x65, 0x20, 0x61, 0x74, 0x20,
            0x74, 0x68, 0x65, 0x20, 0x6C, 0x61, 0x74, 0x65, 0x73, 0x74, 0x2E    // Description is "Next change at specified date at the latest."
        ]

        guard let date1 = DateComponents(calendar: .current, year: 2019, month: 5).date else {
            return XCTFail("Failed to generate a Date")
        }

        let cbs1 = AAConditionBasedService(date: date1, description: "Next change at specified date at the latest.", id: 3, status: .ok, text: "Brake fluid")

        XCTAssertEqual(cbs1.bytes, bytes)

        // Fail
        guard let date2 = DateComponents(calendar: .current, month: 5).date else {
            return XCTFail("Failed to generate a Date")
        }

        let cbs2 = AAConditionBasedService(date: date2, description: "Next change at specified date at the latest.", id: 3, status: .ok, text: "Brake fluid")

        XCTAssertEqual(cbs2.bytes, [])
    }

    func testInit() {
        // Successful
        let bytes1: [UInt8] = [
            0x13,                                                               // 2019
            0x05,                                                               // May
            0x00, 0x03,                                                         // Identifier is 3
            0x00,                                                               // Status is OK
            0x00, 0x0B,                                                         // Text size is 11 bytes
            0x42, 0x72, 0x61, 0x6B, 0x65, 0x20, 0x66, 0x6C, 0x75, 0x69, 0x64,   // Text is "Brake fluid"
            0x00, 0x2C,                                                         // Description size is 44 bytes
            0x4E, 0x65, 0x78, 0x74, 0x20, 0x63, 0x68, 0x61, 0x6E, 0x67, 0x65,
            0x20, 0x61, 0x74, 0x20, 0x73, 0x70, 0x65, 0x63, 0x69, 0x66, 0x69,
            0x65, 0x64, 0x20, 0x64, 0x61, 0x74, 0x65, 0x20, 0x61, 0x74, 0x20,
            0x74, 0x68, 0x65, 0x20, 0x6C, 0x61, 0x74, 0x65, 0x73, 0x74, 0x2E    // Description is "Next change at specified date at the latest."
        ]

        if let service = AAConditionBasedService(bytes: bytes1) {
            if let date = DateComponents(calendar: .current, year: 2019, month: 5).date {
                XCTAssertEqual(service.date, date)
            }
            else {
                return XCTFail("Failed to generate a Date")
            }

            XCTAssertEqual(service.id, 3)
            XCTAssertEqual(service.status, .ok)
            XCTAssertEqual(service.text, "Brake fluid")
            XCTAssertEqual(service.description, "Next change at specified date at the latest.")
        }
        else {
            XCTFail("Failed to initialise AAConditionBasedService")
        }

        // Fail#1
        let bytes2: [UInt8] = [
            0x01    // Invalid bytes count
        ]

        XCTAssertNil(AAConditionBasedService(bytes: bytes2))

        // Fail#2
        let bytes3: [UInt8] = [
            0x13,                                                               // 2019
            0x05,                                                               // May
            0x00, 0x03,                                                         // Identifier is 3
            0x00,                                                               // Status is OK
            0x00, 0x5B,                                                         // Text size is INVALID
            0x42, 0x72, 0x61, 0x6B, 0x65, 0x20, 0x66, 0x6C, 0x75, 0x69, 0x64,   // Text is "Brake fluid"
            0x00, 0x2C,                                                         // Description size is 44 bytes
            0x4E, 0x65, 0x78, 0x74, 0x20, 0x63, 0x68, 0x61, 0x6E, 0x67, 0x65,
            0x20, 0x61, 0x74, 0x20, 0x73, 0x70, 0x65, 0x63, 0x69, 0x66, 0x69,
            0x65, 0x64, 0x20, 0x64, 0x61, 0x74, 0x65, 0x20, 0x61, 0x74, 0x20,
            0x74, 0x68, 0x65, 0x20, 0x6C, 0x61, 0x74, 0x65, 0x73, 0x74, 0x2E    // Description is "Next change at specified date at the latest."
        ]

        XCTAssertNil(AAConditionBasedService(bytes: bytes3))

        // Fail#3
        let bytes4: [UInt8] = [
            0x13,                                                               // 2019
            0x05,                                                               // May
            0x00, 0x03,                                                         // Identifier is 3
            0x00,                                                               // Status is OK
            0x00, 0x0B,                                                         // Text size is 11 bytes
            0x42, 0x72, 0x61, 0x6B, 0x65, 0x20, 0x66, 0x6C, 0x75, 0x69, 0x64,   // Text is "Brake fluid"
            0x00, 0x5C,                                                         // Description size is INVALID
            0x4E, 0x65, 0x78, 0x74, 0x20, 0x63, 0x68, 0x61, 0x6E, 0x67, 0x65,
            0x20, 0x61, 0x74, 0x20, 0x73, 0x70, 0x65, 0x63, 0x69, 0x66, 0x69,
            0x65, 0x64, 0x20, 0x64, 0x61, 0x74, 0x65, 0x20, 0x61, 0x74, 0x20,
            0x74, 0x68, 0x65, 0x20, 0x6C, 0x61, 0x74, 0x65, 0x73, 0x74, 0x2E    // Description is "Next change at specified date at the latest."
        ]

        XCTAssertNil(AAConditionBasedService(bytes: bytes4))

        // Fail#4
        let bytes5: [UInt8] = [
            0x13,                                                               // 2019
            0x05,                                                               // May
            0x00, 0x03,                                                         // Identifier is 3
            0x0F,                                                               // Status is INVALID
            0x00, 0x0B,                                                         // Text size is 11 bytes
            0x42, 0x72, 0x61, 0x6B, 0x65, 0x20, 0x66, 0x6C, 0x75, 0x69, 0x64,   // Text is "Brake fluid"
            0x00, 0x2C,                                                         // Description size is 44 bytes
            0x4E, 0x65, 0x78, 0x74, 0x20, 0x63, 0x68, 0x61, 0x6E, 0x67, 0x65,
            0x20, 0x61, 0x74, 0x20, 0x73, 0x70, 0x65, 0x63, 0x69, 0x66, 0x69,
            0x65, 0x64, 0x20, 0x64, 0x61, 0x74, 0x65, 0x20, 0x61, 0x74, 0x20,
            0x74, 0x68, 0x65, 0x20, 0x6C, 0x61, 0x74, 0x65, 0x73, 0x74, 0x2E    // Description is "Next change at specified date at the latest."
        ]

        XCTAssertNil(AAConditionBasedService(bytes: bytes5))

        // Fail#5
        let bytes6: [UInt8] = [
            0x13,                                                               // 2019
            0x05,                                                               // May
            0x00, 0x03,                                                         // Identifier is 3
            0x00,                                                               // Status is OK
            0x00, 0x0B,                                                         // Text size is 11 bytes
            0x42, 0x72, 0x61, 0x6B, 0x65, 0x20, 0x66, 0xFC, 0xF5, 0x69, 0x64,   // Text is "Brake fluid"
            0x00, 0x2C,                                                         // Description size is 44 bytes
            0x4E, 0x65, 0x78, 0x74, 0x20, 0x63, 0x68, 0x61, 0x6E, 0x67, 0x65,
            0x20, 0x61, 0x74, 0x20, 0x73, 0x70, 0x65, 0x63, 0x69, 0x66, 0x69,
            0x65, 0x64, 0x20, 0x64, 0x61, 0x74, 0x65, 0x20, 0x61, 0x74, 0x20,
            0x74, 0x68, 0x65, 0x20, 0x6C, 0x61, 0x74, 0x65, 0x73, 0x74, 0x2E    // Description is "Next change at specified date at the latest."
        ]

        XCTAssertNil(AAConditionBasedService(bytes: bytes6))
    }
}
