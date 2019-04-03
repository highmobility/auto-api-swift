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
//  AADoorLocksTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 20/11/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import AutoAPI
import XCTest


class AADoorLocksTests: XCTestCase {

    static var allTests = [("testGetState", testGetState),
                           ("testLockUnlock", testLockUnlock),
                           ("testState", testState)]


    // MARK: XCTestCase

    func testGetState() {
        let bytes: [UInt8] = [
            0x00, 0x20, // MSB, LSB Message Identifier for Door Locks
            0x00        // Message Type for Get Lock State
        ]

        XCTAssertEqual(AADoorLocks.getLocksState.bytes, bytes)
    }

    func testLockUnlock() {
        let bytes: [UInt8] = [
            0x00, 0x20, // MSB, LSB Message Identifier for Door Locks
            0x12,       // Message Type for Lock/Unlock Doors

            0x01,       // Property Identifier for Lock state
            0x00, 0x04, // Property size is 4 byte
            0x01,       // Data component
            0x00, 0x01, // Data component size is 1 byte
            0x01        // Lock
        ]

        XCTAssertEqual(AADoorLocks.lockUnlock(.locked).bytes, bytes)
    }
    
    func testState() {
        let bytes: [UInt8] = [
            0x00, 0x20, // MSB, LSB Message Identifier for Door Locks
            0x01,       // Message Type for Lock State

            0x02,       // Property identifier for Inside locks
            0x00, 0x05, // Property size is 5 bytes
            0x01,       // Data component identifier
            0x00, 0x02, // Data component size is 2 bytes
            0x00,   // Front Left door
            0x00,   // Inside unlocked

            0x02,       // Property identifier for Inside locks
            0x00, 0x05, // Property size is 5 bytes
            0x01,       // Data component identifier
            0x00, 0x02, // Data component size is 2 bytes
            0x01,   // Front Right door
            0x00,   // Inside unlocked

            0x03,       // Property identifier for Locks
            0x00, 0x05, // Property size is 5 bytes
            0x01,       // Data component identifier
            0x00, 0x02, // Data component size is 2 bytes
            0x00,   // Front Left door
            0x01,   // Outside locked

            0x03,       // Property identifier for Locks
            0x00, 0x05, // Property size is 5 bytes
            0x01,       // Data component identifier
            0x00, 0x02, // Data component size is 2 bytes
            0x01,   // Front Right door
            0x01,   // Outside locked

            0x04,       // Property identifier for Positions
            0x00, 0x05, // Property size is 5 bytes
            0x01,       // Data component identifier
            0x00, 0x02, // Data component size is 2 bytes
            0x00,   // Front Left door
            0x01,   // Door open

            0x04,       // Property identifier for Positions
            0x00, 0x05, // Property size is 5 bytes
            0x01,       // Data component identifier
            0x00, 0x02, // Data component size is 2 bytes
            0x01,   // Front Right door
            0x00,   // Door closed

            0x04,       // Property identifier for Positions
            0x00, 0x05, // Property size is 5 bytes
            0x01,       // Data component identifier
            0x00, 0x02, // Data component size is 2 bytes
            0x02,   // Rear Right door
            0x00,   // Door closed

            0x04,       // Property identifier for Positions
            0x00, 0x05, // Property size is 5 bytes
            0x01,       // Data component identifier
            0x00, 0x02, // Data component size is 2 bytes
            0x03,   // Rear Left door
            0x00    // Door closed
        ]

        guard let doorLocks = AAAutoAPI.parseBinary(bytes) as? AADoorLocks else {
            return XCTFail("Parsed value is not AADoorLocks")
        }

        // Inside locks
        XCTAssertEqual(doorLocks.insideLocks?.count, 2)

        if let insideLock = doorLocks.insideLocks?.first(where: { $0.value?.location == .frontLeft }) {
            XCTAssertEqual(insideLock.value?.lock, .unlocked)
        }
        else {
            XCTFail("Inside Locks doesn't contain Front Left Door")
        }

        if let insideLock = doorLocks.insideLocks?.first(where: { $0.value?.location == .frontRight }) {
            XCTAssertEqual(insideLock.value?.lock, .unlocked)
        }
        else {
            XCTFail("Inside Locks doesn't contain Front Right Door")
        }

        // Outside locks
        XCTAssertEqual(doorLocks.locks?.count, 2)

        if let outsideLock = doorLocks.locks?.first(where: { $0.value?.location == .frontLeft }) {
            XCTAssertEqual(outsideLock.value?.lock, .locked)
        }
        else {
            XCTFail("Locks doesn't contain Front Left Door")
        }

        if let outsideLock = doorLocks.locks?.first(where: { $0.value?.location == .frontRight }) {
            XCTAssertEqual(outsideLock.value?.lock, .locked)
        }
        else {
            XCTFail("Locks doesn't contain Rear Left Door")
        }

        // Positions
        XCTAssertEqual(doorLocks.positions?.count, 4)

        if let frontLeftDoor = doorLocks.positions?.first(where: { $0.value?.location == .frontLeft }) {
            XCTAssertEqual(frontLeftDoor.value?.position, .open)
        }
        else {
            XCTFail("Positions doesn't contain Front Left Door")
        }

        if let frontRightDoor = doorLocks.positions?.first(where: { $0.value?.location == .frontRight }) {
            XCTAssertEqual(frontRightDoor.value?.position, .closed)
        }
        else {
            XCTFail("Positions doesn't contain Front Right Door")
        }

        if let rearRightDoor = doorLocks.positions?.first(where: { $0.value?.location == .rearRight }) {
            XCTAssertEqual(rearRightDoor.value?.position, .closed)
        }
        else {
            XCTFail("Positions doesn't contain Rear Right Door")
        }

        if let rearLeftDoor = doorLocks.positions?.first(where: { $0.value?.location == .rearLeft }) {
            XCTAssertEqual(rearLeftDoor.value?.position, .closed)
        }
        else {
            XCTFail("Positions doesn't contain Rear Left Door")
        }
    }
}
