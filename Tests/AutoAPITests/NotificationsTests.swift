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
//  NotificationsTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 13/12/2017.
//

import AutoAPI
import XCTest


class NotificationsTests: XCTestCase {

    static var allTests = [("testClearNotificationReceive", testClearNotificationReceive),
                           ("testClearNotificationSend", testClearNotificationSend),
                           ("testNotificationReceive", testNotificationReceive),
                           ("testNotificationSend", testNotificationSend),
                           ("testNotificationActionReceive", testNotificationActionReceive),
                           ("testNotificationActionSend", testNotificationActionSend)]


    // MARK: XCTestCase

    func testClearNotificationReceive() {
        let bytes: [UInt8] = [
            0x00, 0x38, // MSB, LSB Message Identifier for Notifications
            0x02        // Message Type for Clear Notification
        ]

        guard let notifications = AAAutoAPI.parseBinary(bytes) as? Notifications else {
            return XCTFail("Parsed value is not Notifications")
        }

        XCTAssertTrue(notifications.receivedClearCommand)

        XCTAssertNil(notifications.actionItems)
        XCTAssertNil(notifications.receivedActionID)
        XCTAssertNil(notifications.text)
    }

    func testClearNotificationSend() {
        let bytes: [UInt8] = [
            0x00, 0x38, // MSB, LSB Message Identifier for Notifications
            0x02        // Message Type for Clear Notification
        ]

        XCTAssertEqual(Notifications.clearNotification, bytes)
    }

    func testNotificationReceive() {
        let bytes: [UInt8] = [
            0x00, 0x38, // MSB, LSB Message Identifier for Notifications
            0x00,       // Message Type for Notification

            0x01,       // Property Identifier for Text
            0x00, 0x11, // Property size is 17 bytes
            0x53, 0x74, 0x61, 0x72, 0x74,       //
            0x20, 0x6e, 0x61, 0x76, 0x69, 0x67, //
            0x61, 0x74, 0x69, 0x6f, 0x6e, 0x3f, // "Start navigation?"


            0x02,       // Property Identifier for Action Item
            0x00, 0x03, // Property size is 3 bytes
            0x00,       // Item identifier is 0
            0x4e, 0x6f, // Name is "No"

            0x02,       // Property Identifier for Action Item
            0x00, 0x04, // Property size is 4 bytes
            0x01,               // Item identifier is 1
            0x59, 0x65, 0x73    // Name is "Yes"
        ]

        guard let notifications = AAAutoAPI.parseBinary(bytes) as? Notifications else {
            return XCTFail("Parsed value is not Notifications")
        }

        XCTAssertEqual(notifications.text, "Start navigation?")
        XCTAssertEqual(notifications.actionItems?.count, 2)

        // Action item 0
        if let actionItem0 = notifications.actionItems?.first(where: { $0.identifier == 0 }) {
            XCTAssertEqual(actionItem0.name, "No")
        }
        else {
            XCTFail("Notifications doesn't contain Action Item 0")
        }

        // Action item 1
        if let actionItem1 = notifications.actionItems?.first(where: { $0.identifier == 1 }) {
            XCTAssertEqual(actionItem1.name, "Yes")
        }
        else {
            XCTFail("Notifications doesn't contain Action Item 1")
        }

        XCTAssertFalse(notifications.receivedClearCommand)
        XCTAssertNil(notifications.receivedActionID)
    }

    func testNotificationSend() {
        let bytes: [UInt8] = [
            0x00, 0x38, // MSB, LSB Message Identifier for Notifications
            0x00,       // Message Type for Notification

            0x01,       // Property Identifier for Text
            0x00, 0x11, // Property size is 17 bytes
            0x53, 0x74, 0x61, 0x72, 0x74,       //
            0x20, 0x6e, 0x61, 0x76, 0x69, 0x67, //
            0x61, 0x74, 0x69, 0x6f, 0x6e, 0x3f, // "Start navigation?"


            0x02,       // Property Identifier for Action Item
            0x00, 0x03, // Property size is 3 bytes
            0x00,       // Item identifier is 0
            0x4e, 0x6f, // Name is "No"

            0x02,       // Property Identifier for Action Item
            0x00, 0x04, // Property size is 4 bytes
            0x01,               // Item identifier is 1
            0x59, 0x65, 0x73    // Name is "Yes"
        ]

        let actionItem0 = ActionItem(identifier: 0x00, name: "No")
        let actionItem1 = ActionItem(identifier: 0x01, name: "Yes")
        let notification = Notifications.Notification(text: "Start navigation?", actionItems: [actionItem0, actionItem1])

        XCTAssertEqual(Notifications.notification(notification), bytes)
    }

    func testNotificationActionReceive() {
        let bytes: [UInt8] = [
            0x00, 0x38, // MSB, LSB Message Identifier for Notifications
            0x01,       // Message Type for Notification Action

            0xfe  // Action Item identifier selected by user
        ]

        guard let notifications = AAAutoAPI.parseBinary(bytes) as? Notifications else {
            return XCTFail("Parsed value is not Notifications")
        }

        XCTAssertEqual(notifications.receivedActionID, 0xFE)

        XCTAssertFalse(notifications.receivedClearCommand)
        XCTAssertNil(notifications.actionItems)
        XCTAssertNil(notifications.text)
    }

    func testNotificationActionSend() {
        let bytes: [UInt8] = [
            0x00, 0x38, // MSB, LSB Message Identifier for Notifications
            0x01,       // Message Type for Notification Action

            0xfe  // Action Item identifier selected by user
        ]

        XCTAssertEqual(Notifications.notificationAction(0xFE), bytes)
    }
}
