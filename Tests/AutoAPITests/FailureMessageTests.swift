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
//  FailureMessageTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 28/11/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import AutoAPI
import XCTest


class FailureMessageTests: XCTestCase {

    static var allTests = [("testFailure", testFailure)]


    // MARK: XCTestCase

    func testFailure() {
        let bytes: [UInt8] = [
            0x00, 0x02, // MSB, LSB Message Identifier for Failure Message
            0x01,       // Message Type for Failure

            0x01, // Property identifier for Failed message identifier
            0x00, 0x02, // Property size is 2 bytes
            0x00, 0x21, // MSB, LSB Message Identifier for Trunk State

            0x02, // Property identifier for Failed message type
            0x00, 0x01, // Property size is 1 bytes
            0x00,       // Get Trunk State Message Type

            0x03, // Property identifier for Failure reason
            0x00, 0x01, // Property size is 1 bytes
            0x01,       // Unauthorised

            0x04, // Property identifier for Failure description
            0x00, 0x09, // Property size is 9 bytes
            0x54, 0x72, 0x79, 0x20, 0x61, 0x67, 0x61, 0x69, 0x6e // Try again
        ]

        guard let failureMessage = AAAutoAPI.parseBinary(bytes) as? AAFailureMessage else {
            return XCTFail("Parsed value is not FailureMessage")
        }

        XCTAssertEqual(failureMessage.failedMessageIdentifier, AATrunkAccess.identifier)
        XCTAssertEqual(failureMessage.failedMessageType, AATrunkAccess.MessageTypes.getTrunkState.rawValue)
        XCTAssertEqual(failureMessage.failureReason, .unauthorised)
        XCTAssertEqual(failureMessage.failureDescription, "Try again")
    }
}
