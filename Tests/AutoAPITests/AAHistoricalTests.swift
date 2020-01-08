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
//  AAHistoricalTest.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
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