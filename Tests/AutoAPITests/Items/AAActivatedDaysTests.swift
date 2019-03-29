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
//  AAActivatedDaysTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 26/03/2019.
//  Copyright © 2019 High Mobility GmbH. All rights reserved.
//

@testable import AutoAPI
import XCTest


class AAActivatedDaysTests: XCTestCase {

    static var allTests = [("testBytes", testBytes),
                           ("testDescription", testDescription),
                           ("testInit", testInit)]


    // MARK: XCTestCase

    func testBytes() {
        let bytes: [UInt8] = [
            0b0000_1000 // Thursday
        ]

        XCTAssertEqual(AAActivatedDays.thursday.bytes, bytes)
    }

    func testDescription() {
        let activatedDays: AAActivatedDays = [.monday, .tuesday, .wednesday, .thursday, .friday, .saturday, .sunday, .automatic]

        XCTAssertEqual(activatedDays.description, "[.monday, .tuesday, .wednesday, .thursday, .friday, .saturday, .sunday, .automatic]")
    }

    func testInit() {
        // Successful
        let bytes: [UInt8] = [
            0b0000_0001 // Monday
        ]

        if let activatedDays = AAActivatedDays(bytes: bytes) {
            XCTAssertEqual(activatedDays, .monday)
        }
        else {
            XCTFail("Failed to initialise AAActivatedDays")
        }
    }
}
