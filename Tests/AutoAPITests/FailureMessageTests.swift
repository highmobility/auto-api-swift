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
//  FailureMessageTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 28/11/2017.
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

        guard let failureMessage = AutoAPI.parseBinary(bytes) as? FailureMessage else {
            return XCTFail("Parsed value is not FailureMessage")
        }

        XCTAssertEqual(failureMessage.failedMessageIdentifier, TrunkAccess.identifier)
        XCTAssertEqual(failureMessage.failedMessageType, TrunkAccess.MessageTypes.getTrunkState.rawValue)
        XCTAssertEqual(failureMessage.failureReason, .unauthorised)
        XCTAssertEqual(failureMessage.failureDescription, "Try again")
    }
}
