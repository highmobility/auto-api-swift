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
//  AANotificationsTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 13/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import AutoAPI
import XCTest


class AANotificationsTests: XCTestCase {

    static var allTests = [("testClearNotificationReceived", testClearNotificationReceived),
                           ("testClearNotificationSend", testClearNotificationSend),
                           ("testNotificationReceive", testNotificationReceive),
                           ("testNotificationSend", testNotificationSend),
                           ("testNotificationSend2", testNotificationSend2),
                           ("testNotificationActionReceive", testNotificationActionReceive),
                           ("testNotificationActionSend", testNotificationActionSend)]


    // MARK: XCTestCase

    func testClearNotificationReceived() {
        let bytes: [UInt8] = [
            0x00, 0x38, // MSB, LSB Message Identifier for Notifications
            0x02        // Message Type for Clear Notification
        ]

        guard let notifications = AAAutoAPI.parseBinary(bytes) as? AANotifications else {
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

        XCTAssertEqual(AANotifications.clearNotification.bytes, bytes)
    }

    func testNotificationReceive() {
        let bytes: [UInt8] = [
            0x00, 0x38, // MSB, LSB Message Identifier for Notifications
            0x00,       // Message Type for Notification

            0x01,       // Property Identifier for Text
            0x00, 0x14, // Property size is 20 bytes
            0x01,       // Data component
            0x00, 0x11, // Data component size is 17 bytes
            0x53, 0x74, 0x61, 0x72, 0x74,       //
            0x20, 0x6e, 0x61, 0x76, 0x69, 0x67, //
            0x61, 0x74, 0x69, 0x6f, 0x6e, 0x3f, // "Start navigation?"


            0x02,       // Property Identifier for Action Item
            0x00, 0x06, // Property size is 6 bytes
            0x01,       // Data component
            0x00, 0x03, // Data component size is 3 bytes
            0x00,       // Item identifier is 0
            0x4e, 0x6f, // Name is "No"

            0x02,       // Property Identifier for Action Item
            0x00, 0x07, // Property size is 7 bytes
            0x01,       // Data component
            0x00, 0x04, // Data component size is 4 bytes
            0x01,               // Item identifier is 1
            0x59, 0x65, 0x73    // Name is "Yes"
        ]

        guard let notifications = AAAutoAPI.parseBinary(bytes) as? AANotifications else {
            return XCTFail("Parsed value is not Notifications")
        }

        XCTAssertEqual(notifications.text?.value, "Start navigation?")
        XCTAssertEqual(notifications.actionItems?.count, 2)

        // Action item 0
        if let actionItem0 = notifications.actionItems?.first(where: { $0.value?.identifier == 0x00 }) {
            XCTAssertEqual(actionItem0.value?.name, "No")
        }
        else {
            XCTFail("Notifications doesn't contain Action Item 0")
        }

        // Action item 1
        if let actionItem1 = notifications.actionItems?.first(where: { $0.value?.identifier == 0x01 }) {
            XCTAssertEqual(actionItem1.value?.name, "Yes")
        }
        else {
            XCTFail("Notifications doesn't contain Action Item 1")
        }

        XCTAssertFalse(notifications.receivedClearCommand)
        XCTAssertNil(notifications.receivedActionID?.value)
    }

    func testNotificationSend() {
        let bytes: [UInt8] = [
            0x00, 0x38, // MSB, LSB Message Identifier for Notifications
            0x00,       // Message Type for Notification

            0x01,       // Property Identifier for Text
            0x00, 0x14, // Property size is 20 bytes
            0x01,       // Data component
            0x00, 0x11, // Data component size is 17 bytes
            0x53, 0x74, 0x61, 0x72, 0x74,       //
            0x20, 0x6e, 0x61, 0x76, 0x69, 0x67, //
            0x61, 0x74, 0x69, 0x6f, 0x6e, 0x3f, // "Start navigation?"


            0x02,       // Property Identifier for Action Item
            0x00, 0x06, // Property size is 6 bytes
            0x01,       // Data component
            0x00, 0x03, // Data component size is 3 bytes
            0x00,       // Item identifier is 0
            0x4e, 0x6f, // Name is "No"

            0x02,       // Property Identifier for Action Item
            0x00, 0x07, // Property size is 7 bytes
            0x01,       // Data component
            0x00, 0x04, // Data component size is 4 bytes
            0x01,               // Item identifier is 1
            0x59, 0x65, 0x73    // Name is "Yes"
        ]

        let actionItem0 = AAActionItem(identifier: 0x00, name: "No")
        let actionItem1 = AAActionItem(identifier: 0x01, name: "Yes")
        let notification = AANotifications.received(text: "Start navigation?", actionItems: [actionItem0, actionItem1])

        XCTAssertEqual(notification.bytes, bytes)
    }

    func testNotificationSend2() {
        let bytes: [UInt8] = [
            0x00, 0x38, // MSB, LSB Message Identifier for Notifications
            0x00,       // Message Type for Notification

            0x01,       // Property Identifier for Text
            0x00, 0x14, // Property size is 20 bytes
            0x01,       // Data component
            0x00, 0x11, // Data component size is 17 bytes
            0x53, 0x74, 0x61, 0x72, 0x74,       //
            0x20, 0x6e, 0x61, 0x76, 0x69, 0x67, //
            0x61, 0x74, 0x69, 0x6f, 0x6e, 0x3f, // "Start navigation?"
        ]

        let notification = AANotifications.received(text: "Start navigation?", actionItems: nil)

        XCTAssertEqual(notification.bytes, bytes)
    }

    func testNotificationActionReceive() {
        let bytes: [UInt8] = [
            0x00, 0x38, // MSB, LSB Message Identifier for Notifications
            0x11,       // Message Type for Notification Action

            0x10,       // Property Identifier for Received Action ID
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component
            0x00, 0x01, // Data component size is 1 byte
            0xfe        // Action Item identifier selected by user
        ]

        guard let notifications = AAAutoAPI.parseBinary(bytes) as? AANotifications else {
            return XCTFail("Parsed value is not Notifications")
        }

        XCTAssertEqual(notifications.receivedActionID?.value, 0xFE)

        XCTAssertFalse(notifications.receivedClearCommand)
        XCTAssertNil(notifications.actionItems)
        XCTAssertNil(notifications.text)
    }

    func testNotificationActionSend() {
        let bytes: [UInt8] = [
            0x00, 0x38, // MSB, LSB Message Identifier for Notifications
            0x11,       // Message Type for Notification Action

            0x10,       // Property Identifier for Received Action ID
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component
            0x00, 0x01, // Data component size is 1 byte
            0xfe  // Action Item identifier selected by user
        ]

        XCTAssertEqual(AANotifications.activatedAction(0xFE).bytes, bytes)
    }
}
