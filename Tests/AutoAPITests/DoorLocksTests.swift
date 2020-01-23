//
//  The MIT License
//
//  Copyright (c) 2014- High-Mobility GmbH (https://high-mobility.com)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//
//
//  DoorLocksTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 20/11/2017.
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
            0x01,       // Door locked


            0x02,       // Property Identifier for Inside door lock
            0x00, 0x02, // Property size is 2 bytes
            0x01,       // Front Right door
            0x00,       // Lock unlocked

            0x02,       // Property Identifier for Inside door lock
            0x00, 0x02, // Property size is 2 bytes
            0x02,       // Rear Right door
            0x01,       // Lock locked


            0x03,       // Property Identifier for Outside door lock
            0x00, 0x02, // Property size is 2 bytes
            0x00,       // Front Left door
            0x00,       // Lock unlocked

            0x03,       // Property Identifier for Outside door lock
            0x00, 0x02, // Property size is 2 bytes
            0x03,       // Rear Left door
            0x01,       // Lock locked
        ]

        guard let doorLocks = AutoAPI.parseBinary(bytes) as? DoorLocks else {
            return XCTFail("Parsed value is not DoorLocks")
        }

        // Doors
        XCTAssertEqual(doorLocks.doors?.count, 4)

        if let frontLeftDoor = doorLocks.doors?.first(where: { $0.location == .frontLeft }) {
            XCTAssertEqual(frontLeftDoor.position, .open)
            XCTAssertEqual(frontLeftDoor.lock, .unlocked)
        }
        else {
            XCTFail("Doors doesn't contain Front Left Door")
        }

        if let frontRightDoor = doorLocks.doors?.first(where: { $0.location == .frontRight }) {
            XCTAssertEqual(frontRightDoor.position, .closed)
            XCTAssertEqual(frontRightDoor.lock, .unlocked)
        }
        else {
            XCTFail("Doors doesn't contain Front Right Door")
        }

        if let rearRightDoor = doorLocks.doors?.first(where: { $0.location == .rearRight }) {
            XCTAssertEqual(rearRightDoor.position, .closed)
            XCTAssertEqual(rearRightDoor.lock, .locked)
        }
        else {
            XCTFail("Doors doesn't contain Rear Right Door")
        }

        if let rearLeftDoor = doorLocks.doors?.first(where: { $0.location == .rearLeft }) {
            XCTAssertEqual(rearLeftDoor.position, .closed)
            XCTAssertEqual(rearLeftDoor.lock, .locked)
        }
        else {
            XCTFail("Doors doesn't contain Rear Left Door")
        }

        // Inside locks
        XCTAssertEqual(doorLocks.insideLocks?.count, 2)

        if let insideLock = doorLocks.insideLocks?.first(where: { $0.location == .frontRight }) {
            XCTAssertEqual(insideLock.lock, .unlocked)
        }
        else {
            XCTFail("Inside Locks doesn't contain Front Right Door")
        }

        if let insideLock = doorLocks.insideLocks?.first(where: { $0.location == .rearRight }) {
            XCTAssertEqual(insideLock.lock, .locked)
        }
        else {
            XCTFail("Inside Locks doesn't contain Rear Right Door")
        }

        // Outside locks
        XCTAssertEqual(doorLocks.outsideLocks?.count, 2)

        if let outsideLock = doorLocks.outsideLocks?.first(where: { $0.location == .frontLeft }) {
            XCTAssertEqual(outsideLock.lock, .unlocked)
        }
        else {
            XCTFail("Outside Locks doesn't contain Front Left Door")
        }

        if let outsideLock = doorLocks.outsideLocks?.first(where: { $0.location == .rearLeft }) {
            XCTAssertEqual(outsideLock.lock, .locked)
        }
        else {
            XCTFail("Outside Locks doesn't contain Rear Left Door")
        }
    }
}
