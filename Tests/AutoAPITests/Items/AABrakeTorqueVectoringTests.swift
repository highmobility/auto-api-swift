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
//  AABrakeTorqueVectoringTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 26/03/2019.
//  Copyright © 2019 High Mobility GmbH. All rights reserved.
//

@testable import AutoAPI
import XCTest


class AABrakeTorqueVectoringTests: XCTestCase {

    static var allTests = [("testBytes", testBytes),
                           ("testInit", testInit)]


    // MARK: XCTestCase

    func testBytes() {
        let bytes: [UInt8] = [
            0x00,   // Front
            0x00    // Inactive
        ]

        XCTAssertEqual(AABrakeTorqueVectoring(axle: .front, state: .inactive).bytes, bytes)
    }

    func testInit() {
        // Successful
        let bytes1: [UInt8] = [
            0x01,   // Rear
            0x01    // Active
        ]

        if let vectoring = AABrakeTorqueVectoring(bytes: bytes1) {
            XCTAssertEqual(vectoring.axle, .rear)
            XCTAssertEqual(vectoring.state, .active)
        }
        else {
            XCTFail("Failed to initialise AABrakeTorqueVectoring")
        }

        // Fail#1
        let bytes2: [UInt8] = [
            0x01    // Invalid bytes count
        ]

        XCTAssertNil(AABrakeTorqueVectoring(bytes: bytes2))

        // Fail#2
        let bytes3: [UInt8] = [
            0x05,   // Invalid Axle
            0x3F    // Invalid State
        ]

        XCTAssertNil(AABrakeTorqueVectoring(bytes: bytes3))
    }
}
