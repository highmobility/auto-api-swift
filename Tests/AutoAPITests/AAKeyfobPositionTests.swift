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
//  AAKeyfobPositionTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 12/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import AutoAPI
import XCTest


class AAKeyfobPositionTests: XCTestCase {

    static var allTests = [("testGetState", testGetState),
                           ("testState", testState)]


    // MARK: XCTestCase

    func testGetState() {
        let bytes: [UInt8] = [
            0x00, 0x48, // MSB, LSB Message Identifier for Keyfob Position
            0x00        // Message Type for Get Keyfob Position
        ]

        XCTAssertEqual(AAKeyfobPosition.getKeyfobPosition.bytes, bytes)
    }

    func testState() {
        let bytes: [UInt8] = [
            0x00, 0x48, // MSB, LSB Message Identifier for Keyfob Position
            0x01,       // Message Type for Keyfob Position

            0x01,       // Property Identifier for Keyfob Position
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Data component size is 1 bytes
            0x05        // Keyfob is positioned inside the car
        ]

        guard let keyfobPosition = AAAutoAPI.parseBinary(bytes) as? AAKeyfobPosition else {
            return XCTFail("Parsed value is not AAKeyfobPosition")
        }

        XCTAssertEqual(keyfobPosition.relativePosition?.value, .inside)
    }
}
