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
//  AACapabilityValueTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 04/04/2019.
//  Copyright © 2019 High Mobility GmbH. All rights reserved.
//

@testable import AutoAPI
import XCTest


class AACapabilityValueTests: XCTestCase {

    static var allTests = [("testBytes", testBytes),
                           ("testEquatable", testEquatable),
                           ("testInit", testInit)]


    // MARK: XCTestCase

    func testBytes() {
        let bytes: [UInt8] = [
            0x00, 0x20, // Identifier for Door Locks
            0x00,       // Supports Get Lock State
            0x01,       // Supports Lock State
            0x12        // Supports Lock/Unlock Doors
        ]

        XCTAssertEqual(AACapabilityValue(capability: AADoorLocks.self, supportedMessageTypes: [0x00, 0x01, 0x12]).bytes, bytes)
    }

    func testEquatable() {
        let value1 = AACapabilityValue(capability: AACharging.self, supportedMessageTypes: [0x00, 0x01])
        let value2 = AACapabilityValue(capability: AACharging.self, supportedMessageTypes: [0x00, 0x01])

        XCTAssertEqual(value1, value2)
    }

    func testInit() {
        // Successful
        let bytes1: [UInt8] = [
            0x00, 0x20, // Identifier for Door Locks
            0x00,       // Supports Get Lock State
            0x01,       // Supports Lock State
            0x12        // Supports Lock/Unlock Doors
        ]

        if let value = AACapabilityValue(bytes: bytes1) {
            XCTAssertEqual(value.identifier, AADoorLocks.identifier)
            XCTAssertEqual(value.supportedMessageTypes, [0x00, 0x01, 0x12])
        }
        else {
            XCTFail("Failed to initialise AACapabilityValue")
        }

        // Fail#1
        let bytes2: [UInt8] = [
            0x01    // Invalid bytes count
        ]

        XCTAssertNil(AACapabilityValue(bytes: bytes2))

        // Fail#2
        let bytes3: [UInt8] = [
            0xF1, 0xF2, // INVALID
            0x00,       // Supports Get Lock State
            0x01,       // Supports Lock State
            0x12        // Supports Lock/Unlock Doors
        ]

        XCTAssertNil(AACapabilityValue(bytes: bytes3))
    }
}
