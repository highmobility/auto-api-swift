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
//  AAParkingBrakeTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 07/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import AutoAPI
import XCTest


class AAParkingBrakeTests: XCTestCase {

    static var allTests = [("testActivateInactivate", testActivateInactivate),
                           ("testGetState", testGetState),
                           ("testState", testState)]


    // MARK: XCTestCase

    func testActivateInactivate() {
        let bytes: [UInt8] = [
            0x00, 0x58, // MSB, LSB Message Identifier for Parking Brake
            0x12,       // Message Type for Set Parking Brake

            0x01,       // Property Identifier for Parking brake
            0x00, 0x04, // Propery size 4 bytes
            0x01,       // Data component
            0x00, 0x01, // Data component size 1 byte
            0x00        // Inactivate
        ]

        XCTAssertEqual(AAParkingBrake.activate(.inactive).bytes, bytes)
    }

    func testGetState() {
        let bytes: [UInt8] = [
            0x00, 0x58, // MSB, LSB Message Identifier for Parking Brake
            0x00        // Message Type for Get Parking Brake State
        ]

        XCTAssertEqual(AAParkingBrake.getBrakeState.bytes, bytes)
    }

    func testState() {
        let bytes: [UInt8] = [
            0x00, 0x58, // MSB, LSB Message Identifier for Parking Brake
            0x01,       // Message Type for Parking Brake State

            0x01,       // Property Identifier for Parking Brake
            0x00, 0x04, // Propery size 4 bytes
            0x01,       // Data component
            0x00, 0x01, // Data component size 1 byte
            0x01        // Parking brake active
        ]

        guard let parkingBrake = AAAutoAPI.parseBinary(bytes) as? AAParkingBrake else {
            return XCTFail("Parsed value is not AAParkingBrake")
        }

        XCTAssertEqual(parkingBrake.state?.value, .active)
    }
}
