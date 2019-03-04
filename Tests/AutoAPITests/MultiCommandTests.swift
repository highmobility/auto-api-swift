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
//  MultiCommandTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 04/03/2019.
//  Copyright © 2019 High Mobility. All rights reserved.
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

        guard let multiStates = AutoAPI.parseBinary(bytes) as? MultiCommand else {
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
