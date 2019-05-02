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
//  AAVehicleTimeTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 12/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import AutoAPI
import XCTest


class AAVehicleTimeTests: XCTestCase {

    static var allTests = [("testGetState", testGetState),
                           ("testState", testState)]


    // MARK: XCTestCase

    func testGetState() {
        let bytes: [UInt8] = [
            0x00, 0x50, // MSB, LSB Message Identifier for Vehicle Time
            0x00        // Message Type for Get Vehicle Time
        ]

        XCTAssertEqual(AAVehicleTime.getTime.bytes, bytes)
    }

    func testState() {
        let bytes: [UInt8] = [
            0x00, 0x50, // MSB, LSB Message Identifier for Vehicle Time
            0x01,       // Message Type for Vehicle Time

            0x01,       // Property identifier for Vehicle time
            0x00, 0x0B, // Property size is 11 bytes
            0x01,       // Data component identifier
            0x00, 0x08, // Data component size is 8 bytes
            0x00, 0x00, 0x01, 0x59, 0x99, 0xE5, 0xBF, 0xC0, // 13 January 2017 at 22:14:48 GMT
        ]

        guard let vehicleTime = AAAutoAPI.parseBinary(bytes) as? AAVehicleTime else {
            return XCTFail("Parsed value is not AAVehicleTime")
        }

        XCTAssertEqual(vehicleTime.time?.value, Date(timeIntervalSince1970: 1_484_345_688.0))
    }
}
