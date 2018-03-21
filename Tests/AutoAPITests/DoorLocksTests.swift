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
//  DoorLocksTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 20/11/2017.
//  Copyright © 2017 High Mobility. All rights reserved.
//

import AutoAPI
import XCTest


class DoorLocksTests: XCTestCase {

    static var allTests = [("testGetState", testGetState),
                           ("testLockUnlock", testLockUnlock),
                           ("testState", testState)]


    // MARK: XCTestCase

    func testGetState() {
        let bytes: [UInt8] = [
            0x00, 0x20, // MSB, LSB Message Identifier for Door Locks
            0x00        // Message Type for Get Lock State
        ]

        XCTAssertEqual(DoorLocks.getLockState, bytes)
    }

    func testLockUnlock() {
        let bytes: [UInt8] = [
            0x00, 0x20, // MSB, LSB Message Identifier for Door Locks
            0x02,       // Message Type for Lock/Unlock Doors
            0x00        // Unlock
        ]

        XCTAssertEqual(DoorLocks.lockUnlock(.unlock), bytes)
    }
    
    func testState() {
        let bytes: [UInt8] = [
            0x00, 0x20, // MSB, LSB Message Identifier for Door Locks
            0x01,       // Message Type for Lock State

            0x01,       // Property Identifier for Door
            0x00, 0x03, // Property size 3 byte
            0x00,       // Front Left door
            0x01,       // Door open
            0x00,       // Door unlocked

            0x01,       // Property Identifier for Door
            0x00, 0x03, // Property size 3 byte
            0x01,       // Front Right door
            0x00,       // Door closed
            0x00,       // Door unlocked

            0x01,       // Property Identifier for Door
            0x00, 0x03, // Property size 3 byte
            0x02,       // Rear Right door
            0x00,       // Door closed
            0x01,       // Door locked

            0x01,       // Property Identifier for Door
            0x00, 0x03, // Property size 3 byte
            0x03,       // Rear Left door
            0x00,       // Door closed
            0x01        // Door locked
        ]

        guard let doorLocks = AutoAPI.parseBinary(bytes) as? DoorLocks else {
            return XCTFail("Parsed value is not DoorLocks")
        }

        let doors = doorLocks.doors

        XCTAssertEqual(doors?.count, 4)

        if let frontLeftDoor = doors?.first(where: { $0.location == .frontLeft }) {
            XCTAssertEqual(frontLeftDoor.position, .open)
            XCTAssertEqual(frontLeftDoor.lock, .unlocked)
        }
        else {
            XCTFail("Doors doesn't contain Front Left Door")
        }

        if let frontRightDoor = doors?.first(where: { $0.location == .frontRight }) {
            XCTAssertEqual(frontRightDoor.position, .closed)
            XCTAssertEqual(frontRightDoor.lock, .unlocked)
        }
        else {
            XCTFail("Doors doesn't contain Front Right Door")
        }

        if let rearRightDoor = doors?.first(where: { $0.location == .rearRight }) {
            XCTAssertEqual(rearRightDoor.position, .closed)
            XCTAssertEqual(rearRightDoor.lock, .locked)
        }
        else {
            XCTFail("Doors doesn't contain Rear Right Door")
        }

        if let rearLeftDoor = doors?.first(where: { $0.location == .rearLeft }) {
            XCTAssertEqual(rearLeftDoor.position, .closed)
            XCTAssertEqual(rearLeftDoor.lock, .locked)
        }
        else {
            XCTFail("Doors doesn't contain Rear Left Door")
        }
    }
}
