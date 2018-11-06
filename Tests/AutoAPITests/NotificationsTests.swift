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
//  NotificationsTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 13/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
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

        XCTAssertEqual(AANotifications.clearNotification, bytes)
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

        guard let notifications = AAAutoAPI.parseBinary(bytes) as? AANotifications else {
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

        let actionItem0 = AAActionItem(identifier: 0x00, name: "No")
        let actionItem1 = AAActionItem(identifier: 0x01, name: "Yes")
        let notification = AANotifications.Notification(text: "Start navigation?", actionItems: [actionItem0, actionItem1])

        XCTAssertEqual(AANotifications.notification(notification), bytes)
    }

    func testNotificationActionReceive() {
        let bytes: [UInt8] = [
            0x00, 0x38, // MSB, LSB Message Identifier for Notifications
            0x01,       // Message Type for Notification Action

            0xfe  // Action Item identifier selected by user
        ]

        guard let notifications = AAAutoAPI.parseBinary(bytes) as? AANotifications else {
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

        XCTAssertEqual(AANotifications.notificationAction(0xFE), bytes)
    }
}
