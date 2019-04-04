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
//  ExtensionsTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 04/04/2019.
//  Copyright © 2019 High Mobility GmbH. All rights reserved.
//

@testable import AutoAPI
import XCTest


class ExtensionsTests: XCTestCase {

    static var allTests = [("testInt", testInt),
                           ("testUInt8", testUInt8),
                           ("testUInt16", testUInt16)]


    // MARK: XCTestCase

    func testInt() {
        XCTAssertEqual(Int(15).sizeBytes(amount: 2), [0x00, 0x0F])
    }

    func testUInt8() {
        // Bool
        XCTAssertTrue(UInt8(0x01).bool)
        XCTAssertFalse(UInt8(0x00).bool)

        // Int
        XCTAssertEqual(UInt8(55).int, Int(55))

        // Int8
        XCTAssertEqual(UInt8(55).int8, Int8(55))

        // Int16
        XCTAssertEqual(UInt8(55).int16, Int16(55))

        // UInt16
        XCTAssertEqual(UInt8(55).uint16, UInt16(55))

        // UInt32
        XCTAssertEqual(UInt8(55).uint32, UInt32(55))
    }

    func testUInt16() {
        XCTAssertEqual(UInt16(33).int, Int(33))
    }
}
