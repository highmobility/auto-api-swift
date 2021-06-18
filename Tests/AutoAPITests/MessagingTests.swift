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
//  MessagingTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 13/12/2017.
//

import AutoAPI
import XCTest


class MessagingTests: XCTestCase {

    static var allTests = [("testMessageReceived", testMessageReceived),
                           ("testSendMessage", testSendMessage)]


    // MARK: XCTestCase

    func testMessageReceived() {
        let bytes: [UInt8] = [
            0x00, 0x37, // MSB, LSB Message Identifier for Messaging
            0x00,       // Message Type for Message Received

            0x01,       // Property Identifier for Sender Handle
            0x00, 0x0e, // Property size is 14 bytes
            0x2b, 0x31, 0x20, 0x35, 0x35, 0x35, 0x2d,   //
            0x35, 0x35, 0x35, 0x2d, 0x35, 0x35, 0x35,   // +1 555-555-555

            0x02,       // Property Identifier for Text
            0x00, 0x05, // Property size is 5 bytes
            0x48, 0x65, 0x6c, 0x6c, 0x6f    // "Hello"
        ]

        let message = Messaging.Message(senderHandle: "+1 555-555-555", text: "Hello")

        XCTAssertEqual(Messaging.messageReceived(message), bytes)
    }

    func testSendMessage() {
        let bytes: [UInt8] = [
            0x00, 0x37, // MSB, LSB Message Identifier for Messaging
            0x01,       // Message Type for Send Message

            0x01,       // Property Identifier for Recipient Handle
            0x00, 0x0e, // Propery size is 14 bytes
            0x2b, 0x31, 0x20, 0x35, 0x35, 0x35, 0x2d,   //
            0x35, 0x35, 0x35, 0x2d, 0x35, 0x35, 0x35,   // +1 555-555-555

            0x02,       // Property Identifier for Text
            0x00, 0x0d, // Property size is 13 bytes
            0x48, 0x65, 0x6c, 0x6c, 0x6f, 0x20,         //
            0x79, 0x6f, 0x75, 0x20, 0x74, 0x6f, 0x6f    // "Hello you too"
        ]

        guard let messaging = AAAutoAPI.parseBinary(bytes) as? Messaging else {
            return XCTFail("Parsed value is not Messaging")
        }

        XCTAssertEqual(messaging.recipientHandle, "+1 555-555-555")
        XCTAssertEqual(messaging.text, "Hello you too")
    }
}
