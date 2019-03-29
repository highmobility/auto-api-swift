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
//  AAActionItemTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 26/03/2019.
//  Copyright © 2019 High Mobility GmbH. All rights reserved.
//

@testable import AutoAPI
import XCTest


class AAActionItemTests: XCTestCase {

    static var allTests = [("testBytes", testBytes),
                           ("testInit", testInit)]


    // MARK: XCTestCase

    func testBytes() {
        let bytes: [UInt8] = [
            0x11,                                       // ID is 17
            0x74, 0x65, 0x72, 0x65, 0x20, 0x70,         //
            0xC3, 0xA4, 0x65, 0x76, 0x61, 0x73, 0x74    // "tere päevast"
        ]

        XCTAssertEqual(AAActionItem(identifier: 17, name: "tere päevast").bytes, bytes)
    }

    func testInit() {
        // Successful
        let bytes1: [UInt8] = [
            0x11,                                       // ID is 17
            0x74, 0x65, 0x72, 0x65, 0x20, 0x70,         //
            0xC3, 0xA4, 0x65, 0x76, 0x61, 0x73, 0x74    // "tere päevast"
        ]

        if let actionItem = AAActionItem(bytes: bytes1) {
            XCTAssertEqual(actionItem.identifier, 17)
            XCTAssertEqual(actionItem.name, "tere päevast")
        }
        else {
            XCTFail("Failed to initialise AAActionItem")
        }

        // Fail#1
        let bytes2: [UInt8] = []    // Invalid bytes count

        XCTAssertNil(AAActionItem(bytes: bytes2))

        // Fail#2
        let bytes3: [UInt8] = [
            0x05,                   // ID is 5
            0x3F, 0x11, 0x26, 0xE9  // Invalid string
        ]

        XCTAssertNil(AAActionItem(bytes: bytes3))
    }
}
