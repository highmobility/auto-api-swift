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
//  MultiCommandTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 04/03/2019.
//

import AutoAPI
import XCTest


class MultiCommandTests: XCTestCase {

    static var allTests = [("testStatesReceived", testStatesReceived),
                           ("testSendCommands", testSendCommands)]


    // MARK: XCTestCase

    func testStatesReceived() {
        let bytes: [UInt8] = [
            0x00, 0x13, // MSB, LSB Message Identifier for Multi Command
            0x01,       // Message Type for Multi State

            // First state with Auto API level 7 Door Lock State
            0x01,       // Property Identifier for State
            0x00, 0x08, // Property size is 8 bytes
             0x00, 0x20, // MSB, LSB Message Identifier for Door Locks
             0x01,       // Message Type for Door Lock State
             0x03,       // Property Identifier for Locks
             0x00, 0x02, // Property size is 2 bytes
             0x01,       // Front right door
             0x01,       // Is locked

            // Second state with Auto API level 7 Theft Alarm State
            0x01,       // Property Identifier for State
            0x00, 0x07, // Property size is 7 bytes
             0x00, 0x46, // MSB, LSB Message Identifier for Theft Alarm
             0x01,       // Message Type for Theft Alarm State
             0x01,       // Property Identifier for Theft Alarm
             0x00, 0x01, // Property size is 1 byte
             0x01        // Vehicle is armed
        ]

        guard let multiStates = AAAutoAPI.parseBinary(bytes) as? MultiCommand else {
            return XCTFail("Parsed value is not MultiCommand")
        }

        // Go through the STATES
        let states = multiStates.states

        XCTAssertEqual(states?.count, 2)

        // DOOR LOCKS
        if let doorLocks = states?.flatMapFirst({ $0 as? DoorLocks }) {
            if let leftDoor = doorLocks.outsideLocks?.first(where: { $0.location == .frontRight }) {
                XCTAssertEqual(leftDoor.lock, .locked)
            }
            else {
                XCTFail("Doors doesn't contain .frontRight")
            }
        }
        else {
            XCTFail("States doesn't contain DoorLocks")
        }

        // THEFT ALARM
        if let theftAlarm = states?.flatMapFirst({ $0 as? TheftAlarm }) {
            XCTAssertEqual(theftAlarm.state, .armed)
        }
        else {
            XCTFail("States doesn't contain TheftAlarm")
        }
    }



    func testSendCommands() {
        let bytes: [UInt8] = [
            0x00, 0x13, // MSB, LSB Message Identifier for Multi Command
            0x02,       // Message Type for Multi Command

            // First command with Auto API level 7 Lock/Unlock Doors command
            0x01,       // Property Identifier for Command
            0x00, 0x04, // Property size is 4 bytes
             0x00, 0x20, // MSB, LSB Message Identifier for Door Locks
             0x02,       // Message Type for Lock/Unlock Doors
             0x01,       // Lock

            // Second command with Auto API level 7 Set Theft Alarm command
            0x01,       // Property Identifier for Command
            0x00, 0x04, // Property size is 4 bytes
             0x00, 0x46, // MSB, LSB Message Identifier for Theft Alarm
             0x02,       // Message Type for Set Theft Alarm
             0x01        // Arm the theft alarm
        ]

        let doorLocks = DoorLocks.lockUnlock(.lock)
        let theftAlarm = TheftAlarm.setTheftAlarm(.arm)
        let multiCommand = MultiCommand.combined(doorLocks, theftAlarm)

        XCTAssertEqual(multiCommand, bytes)
    }
}
