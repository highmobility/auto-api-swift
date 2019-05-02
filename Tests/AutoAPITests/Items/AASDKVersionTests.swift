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
//  AASDKVersionTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 03/04/2019.
//  Copyright © 2019 High Mobility GmbH. All rights reserved.
//

@testable import AutoAPI
import XCTest


class AASDKVersionTests: XCTestCase {

    static var allTests = [("testBytes", testBytes),
                           ("testInit", testInit)]


    // MARK: XCTestCase

    func testBytes() {
        let bytes: [UInt8] = [
            0x01,   // Major 1
            0x0F,   // Minor 15
            0x21    // Patch is 33, giving the complete version "1.15.33"
        ]

        XCTAssertEqual(AASDKVersion(major: 1, minor: 15, patch: 33).bytes, bytes)
    }

    func testInit() {
        // Successful
        let bytes1: [UInt8] = [
            0x01,   // Major 1
            0x0F,   // Minor 15
            0x21    // Patch is 33, giving the complete version "1.15.33"
        ]

        if let version = AASDKVersion(bytes: bytes1) {
            XCTAssertEqual(version.major, 1)
            XCTAssertEqual(version.minor, 15)
            XCTAssertEqual(version.patch, 33)
            XCTAssertEqual(version.string, "1.15.33")
        }
        else {
            XCTFail("Failed to initialise AASDKVersion")
        }

        // Fail#1
        let bytes2: [UInt8] = [
            0x01    // Invalid bytes count
        ]

        XCTAssertNil(AASDKVersion(bytes: bytes2))
    }
}
