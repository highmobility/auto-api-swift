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
//  AANotificationsTest.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import AutoAPI
import XCTest


class AANotificationsTest: XCTestCase {

    // MARK: State Properties

    func testText() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x38, 0x01, 0x01, 0x00, 0x0e, 0x01, 0x00, 0x0b, 0x4f, 0x70, 0x65, 0x6e, 0x20, 0x47, 0x61, 0x72, 0x61, 0x67, 0x65]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AANotifications else {
            return XCTFail("Could not parse bytes as AANotifications")
        }
    
        XCTAssertEqual(capability.text?.value, "Open Garage")
    }

    func testActivatedAction() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x38, 0x01, 0x03, 0x00, 0x04, 0x01, 0x00, 0x01, 0x1b]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AANotifications else {
            return XCTFail("Could not parse bytes as AANotifications")
        }
    
        XCTAssertEqual(capability.activatedAction?.value, 27)
    }

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