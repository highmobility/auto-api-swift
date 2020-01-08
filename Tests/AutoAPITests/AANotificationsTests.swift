//
// AutoAPI
// Copyright (C) 2020 High-Mobility GmbH
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
//  AANotificationsTest.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import AutoAPI
import XCTest


class AANotificationsTest: XCTestCase {

    // MARK: State Properties

    func testActionItems() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x38, 0x01, 0x02, 0x00, 0x0a, 0x01, 0x00, 0x07, 0x1b, 0x00, 0x04, 0x4f, 0x70, 0x65, 0x6e, 0x02, 0x00, 0x0c, 0x01, 0x00, 0x09, 0x1c, 0x00, 0x06, 0x43, 0x61, 0x6e, 0x63, 0x65, 0x6c]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AANotifications else {
            return XCTFail("Could not parse bytes as AANotifications")
        }
    
        guard let actionItems = capability.actionItems?.compactMap({ $0.value }) else {
            return XCTFail("Could not extract .actionItems values")
        }
    
        XCTAssertTrue(actionItems.contains { $0 == AAActionItem(id: 27, name: "Open") })
        XCTAssertTrue(actionItems.contains { $0 == AAActionItem(id: 28, name: "Cancel") })
    }

    func testActivatedAction() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x38, 0x01, 0x03, 0x00, 0x04, 0x01, 0x00, 0x01, 0x1b]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AANotifications else {
            return XCTFail("Could not parse bytes as AANotifications")
        }
    
        XCTAssertEqual(capability.activatedAction?.value, 27)
    }

    func testText() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x38, 0x01, 0x01, 0x00, 0x0e, 0x01, 0x00, 0x0b, 0x4f, 0x70, 0x65, 0x6e, 0x20, 0x47, 0x61, 0x72, 0x61, 0x67, 0x65]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AANotifications else {
            return XCTFail("Could not parse bytes as AANotifications")
        }
    
        XCTAssertEqual(capability.text?.value, "Open Garage")
    }

    func testClear() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x38, 0x01, 0x04, 0x00, 0x04, 0x01, 0x00, 0x01, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AANotifications else {
            return XCTFail("Could not parse bytes as AANotifications")
        }
    
        XCTAssertEqual(capability.clear?.value, .clear)
    }

    
    // MARK: Setters

    func testNotification() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x38, 0x01] + [0x01, 0x00, 0x0e, 0x01, 0x00, 0x0b, 0x4f, 0x70, 0x65, 0x6e, 0x20, 0x47, 0x61, 0x72, 0x61, 0x67, 0x65, 0x02, 0x00, 0x0a, 0x01, 0x00, 0x07, 0x1b, 0x00, 0x04, 0x4f, 0x70, 0x65, 0x6e]
        let setterBytes = AANotifications.notification(text: "Open Garage", actionItems: [AAActionItem(id: 27, name: "Open")])
    
        XCTAssertEqual(bytes, setterBytes)
    }

    func testAction() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x38, 0x01] + [0x03, 0x00, 0x04, 0x01, 0x00, 0x01, 0x1b]
        let setterBytes = AANotifications.action(activatedAction: 27)
    
        XCTAssertEqual(bytes, setterBytes)
    }

    func testClearNotification() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x38, 0x01] + [0x04, 0x00, 0x04, 0x01, 0x00, 0x01, 0x00]
        let setterBytes = AANotifications.clearNotification()
    
        XCTAssertEqual(bytes, setterBytes)
    }
}