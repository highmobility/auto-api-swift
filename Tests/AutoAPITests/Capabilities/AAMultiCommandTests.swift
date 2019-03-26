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
//  AAMultiCommandTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 26/03/2019.
//  Copyright © 2019 High Mobility GmbH. All rights reserved.
//

import AutoAPI
import XCTest


class AAMultiCommandTests: XCTestCase {

    static var allTests = [("testSend", testSend),
                           ("testState", testState)]


    // MARK: XCTestCase

    func testSend() {
        let bytes: [UInt8] = [
            0x00, 0x13, // MSB, LSB Message Identifier for Multi Command
            0x02,       // Message Type for Multi Command

            // First command with Lock/Unlock Doors command
            0x01,       // Property Identifier for Command
            0x00, 0x0D, // Property size is 13 bytes
            0x01,       // Data component
            0x00, 0x0A, // Data component size is 10 bytes
            0x00, 0x20, // MSB, LSB Message Identifier for Door Locks
            0x12,       // Message Type for Lock/Unlock Doors
            0x01,       // Property Identifier for Lock state
            0x00, 0x04, // Property size is 4 byte
            0x01,       // Data component
            0x00, 0x01, // Data component size is 1 byte
            0x01,       // Lock

            // Second command with Set Theft Alarm command
            0x01,       // Property Identifier for Command
            0x00, 0x0D, // Property size is 13 bytes
            0x01,       // Data component
            0x00, 0x0A, // Data component size is 10 bytes
            0x00, 0x46, // MSB, LSB Message Identifier for Theft Alarm
            0x12,       // Message Type for Set Theft Alarm
            0x01,       // Property Identifier for Theft alarm
            0x00, 0x04, // Property size 4 bytes
            0x01,       // Data component
            0x00, 0x01, // Data component size 1 byte
            0x01        // Trigger alarm
        ]

        let doors = AADoorLocks.lockUnlock(.locked)
        let theftAlarm = AATheftAlarm.setAlarmState(.armed)

        XCTAssertEqual(AAMultiCommand.combined(doors, theftAlarm).bytes, bytes)
    }

    func testState() {
        let bytes: [UInt8] = [
            0x00, 0x13, // MSB, LSB Message Identifier for Multi Command
            0x01,       // Message Type for Multi State

            // First state with Door Lock State
            0x01,       // Property Identifier for State
            0x00, 0x0E, // Property size is 14 bytes
            0x01,       // Data component
            0x00, 0x0B, // Data component size is 11 bytes
            0x00, 0x20, // MSB, LSB Message Identifier for Door Locks
            0x01,       // Message Type for Door Lock State
            0x03,       // Property Identifier for Locks
            0x00, 0x05, // Property size is 5 bytes
            0x01,       // Data component
            0x00, 0x02, // Data component size is 2 bytes
            0x01,       // Front right door
            0x01,       // Is locked

            // Second state with Theft Alarm State
            0x01,       // Property Identifier for State
            0x00, 0x0D, // Property size is 13 bytes
            0x01,       // Data component
            0x00, 0x0A, // Data component size is 10 bytes
            0x00, 0x46, // MSB, LSB Message Identifier for Theft Alarm
            0x01,       // Message Type for Theft Alarm State
            0x01,       // Property Identifier for Theft Alarm
            0x00, 0x04, // Property size is 4 byte
            0x01,       // Data component
            0x00, 0x01, // Data component size is 1 byte
            0x01        // Vehicle is armed
        ]

        guard let multiCommand = AutoAPI.parseBinary(bytes) as? AAMultiCommand else {
            return XCTFail("Parsed value is not AAMultiCommand")
        }

        // States
        XCTAssertEqual(multiCommand.states?.count, 2)

        if let doorLocks = multiCommand.states?.first(where: { $0 is AADoorLocks }) as? AADoorLocks {
            XCTAssertEqual(doorLocks.locks?.count, 1)

            if let lock = doorLocks.locks?.first(where: { $0.value?.location == .frontRight }) {
                XCTAssertEqual(lock.value?.lock, .locked)
            }
            else {
                XCTFail("Locks doesn't contain Front Right door")
            }
        }
        else {
            XCTFail("States doesn't contain AADoorLocks")
        }

        if let theftAlarm = multiCommand.states?.first(where: { $0 is AATheftAlarm }) as? AATheftAlarm {
            XCTAssertEqual(theftAlarm.state?.value, .armed)
        }
        else {
            XCTFail("States doesn't contain AATheftAlarm")
        }
    }
}
