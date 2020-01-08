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
//  AAFailureMessageTest.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import AutoAPI
import XCTest


class AAFailureMessageTest: XCTestCase {

    // MARK: State Properties

    func testFailureReason() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x02, 0x01, 0x03, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAFailureMessage else {
            return XCTFail("Could not parse bytes as AAFailureMessage")
        }
    
        XCTAssertEqual(capability.failureReason?.value, .unauthorised)
    }

    func testFailureDescription() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x02, 0x01, 0x04, 0x00, 0x0c, 0x01, 0x00, 0x09, 0x54, 0x72, 0x79, 0x20, 0x61, 0x67, 0x61, 0x69, 0x6e]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAFailureMessage else {
            return XCTFail("Could not parse bytes as AAFailureMessage")
        }
    
        XCTAssertEqual(capability.failureDescription?.value, "Try again")
    }

    func testFailedPropertyIDs() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x02, 0x01, 0x05, 0x00, 0x05, 0x01, 0x00, 0x02, 0x01, 0x02]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAFailureMessage else {
            return XCTFail("Could not parse bytes as AAFailureMessage")
        }
    
        XCTAssertEqual(capability.failedPropertyIDs?.value, [0x01, 0x02])
    }

    func testFailedMessageType() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x02, 0x01, 0x02, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAFailureMessage else {
            return XCTFail("Could not parse bytes as AAFailureMessage")
        }
    
        XCTAssertEqual(capability.failedMessageType?.value, 0x01)
    }

    func testFailedMessageID() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x02, 0x01, 0x01, 0x00, 0x05, 0x01, 0x00, 0x02, 0x00, 0x21]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAFailureMessage else {
            return XCTFail("Could not parse bytes as AAFailureMessage")
        }
    
        XCTAssertEqual(capability.failedMessageID?.value, 0x0021)
    }
}