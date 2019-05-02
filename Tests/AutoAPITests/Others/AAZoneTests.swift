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
//  AAZoneTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 04/04/2019.
//  Copyright © 2019 High Mobility GmbH. All rights reserved.
//

@testable import AutoAPI
import XCTest


class AAZoneTests: XCTestCase {

    static var allTests = [("testDescription", testDescription),
                           ("testInit", testInit),
                           ("testProperties", testProperties)]


    // MARK: XCTestCase

    func testDescription() {
        XCTAssertEqual(AAZone.matrix(0x54).description, "5x4")
        XCTAssertEqual(AAZone.unavailable.description, "unavailable")
    }

    func testInit() {
        // RawValue
        XCTAssertEqual(AAZone(rawValue: 0x00), .unavailable)
        XCTAssertEqual(AAZone(rawValue: 0x54), .matrix(0x54))

        // Arguments
        XCTAssertEqual(AAZone(horisontal: 0, vertical: 0), .unavailable)
        XCTAssertEqual(AAZone(horisontal: 5, vertical: 4), .matrix(0x54))
    }

    func testProperties() {
        // Good value
        let zone1 = AAZone.matrix(0x54)

        XCTAssertEqual(zone1.horisontal, 5)
        XCTAssertEqual(zone1.vertical, 4)
        XCTAssertEqual(zone1.rawValue, 0x54)

        // Bad value
        let zone2 = AAZone.unavailable

        XCTAssertEqual(zone2.horisontal, 0)
        XCTAssertEqual(zone2.vertical, 0)
        XCTAssertEqual(zone2.rawValue, 0x00)
    }
}
