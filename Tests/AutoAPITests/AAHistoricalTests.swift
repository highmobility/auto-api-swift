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
//  AAHistoricalTest.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import AutoAPI
import XCTest


class AAHistoricalTest: XCTestCase {

    // MARK: State Properties

    func testStates() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x12, 0x01, 0x01, 0x00, 0x16, 0x01, 0x00, 0x13, 0x0b, 0x00, 0x20, 0x01, 0x06, 0x00, 0x04, 0x01, 0x00, 0x01, 0x00, 0x04, 0x00, 0x05, 0x01, 0x00, 0x02, 0x00, 0x01, 0x01, 0x00, 0x18, 0x01, 0x00, 0x15, 0x0b, 0x00, 0x23, 0x01, 0x0a, 0x00, 0x07, 0x01, 0x00, 0x04, 0x40, 0x60, 0x00, 0x00, 0x0b, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAHistorical else {
            return XCTFail("Could not parse bytes as AAHistorical")
        }
    
        guard let states = capability.states?.compactMap({ $0.value }) else {
            return XCTFail("Could not extract .states values")
        }
    
        XCTAssertTrue(states.contains { $0 is AADoors })
        XCTAssertTrue(states.contains { $0 is AACharging })
    }

    
    // MARK: Non-state Properties

    func testStartDate() {
        let bytes: Array<UInt8> = [0x03, 0x00, 0x0b, 0x01, 0x00, 0x08, 0x00, 0x00, 0x01, 0x6d, 0xa6, 0x52, 0x43, 0x00]
    
        guard let property: AAProperty<Date> = AAOpaqueProperty(bytes: bytes)?.property() else {
            return XCTFail("Could not create a property for .startDate")
        }
    
        XCTAssertEqual(property.value, DateFormatter.hmFormatter.date(from: "2019-10-07T13:04:32.000Z")!)
    }

    func testEndDate() {
        let bytes: Array<UInt8> = [0x04, 0x00, 0x0b, 0x01, 0x00, 0x08, 0x00, 0x00, 0x01, 0x6d, 0x71, 0xe2, 0xc4, 0xf0]
    
        guard let property: AAProperty<Date> = AAOpaqueProperty(bytes: bytes)?.property() else {
            return XCTFail("Could not create a property for .endDate")
        }
    
        XCTAssertEqual(property.value, DateFormatter.hmFormatter.date(from: "2019-09-27T08:42:30.000Z")!)
    }

    func testCapabilityID() {
        let bytes: Array<UInt8> = [0x02, 0x00, 0x05, 0x01, 0x00, 0x02, 0x00, 0x60]
    
        guard let property: AAProperty<UInt16> = AAOpaqueProperty(bytes: bytes)?.property() else {
            return XCTFail("Could not create a property for .capabilityID")
        }
    
        XCTAssertEqual(property.value, 0x0060)
    }

    
    // MARK: Setters

    func testRequestStates() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x12, 0x01] + [0x02, 0x00, 0x05, 0x01, 0x00, 0x02, 0x00, 0x60, 0x03, 0x00, 0x0b, 0x01, 0x00, 0x08, 0x00, 0x00, 0x01, 0x6d, 0xa6, 0x52, 0x43, 0x00, 0x04, 0x00, 0x0b, 0x01, 0x00, 0x08, 0x00, 0x00, 0x01, 0x6d, 0x71, 0xe2, 0xc4, 0xf0]
        let setterBytes = AAHistorical.requestStates(capabilityID: 0x0060, startDate: DateFormatter.hmFormatter.date(from: "2019-10-07T13:04:32.000Z")!, endDate: DateFormatter.hmFormatter.date(from: "2019-09-27T08:42:30.000Z")!)
    
        XCTAssertEqual(bytes, setterBytes)
    }
}