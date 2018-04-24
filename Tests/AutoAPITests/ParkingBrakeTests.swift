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
//  ParkingBrakeTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 07/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import AutoAPI
import XCTest


class ParkingBrakeTests: XCTestCase {

    static var allTests = [("testActivateInactivate", testActivateInactivate),
                           ("testGetState", testGetState),
                           ("testState", testState)]


    // MARK: XCTestCase

    func testActivateInactivate() {
        let bytes: [UInt8] = [
            0x00, 0x58, // MSB, LSB Message Identifier for Parking Brake
            0x02,       // Message Type for Set Parking Brake
            0x00        // Inactivate
        ]

        XCTAssertEqual(ParkingBrake.activate(false), bytes)
    }

    func testGetState() {
        let bytes: [UInt8] = [
            0x00, 0x58, // MSB, LSB Message Identifier for Parking Brake
            0x00        // Message Type for Get Parking Brake State
        ]

        XCTAssertEqual(ParkingBrake.getParkingBrakeState, bytes)
    }

    func testState() {
        let bytes: [UInt8] = [
            0x00, 0x58, // MSB, LSB Message Identifier for Parking Brake
            0x01,       // Message Type for Parking Brake State

            0x01,       // Property Identifier for Parking Brake
            0x00, 0x01, // Property size 1 byte
            0x01        // Parking brake active
        ]

        guard let parkingBrake = AutoAPI.parseBinary(bytes) as? ParkingBrake else {
            return XCTFail("Parsed value is not ParkingBrake")
        }

        XCTAssertEqual(parkingBrake.isActive, true)
    }
}
