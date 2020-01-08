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
//  AAParkingTicketTest.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import AutoAPI
import XCTest


class AAParkingTicketTest: XCTestCase {

    // MARK: State Properties

    func testTicketEndTime() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x47, 0x01, 0x05, 0x00, 0x0b, 0x01, 0x00, 0x08, 0x00, 0x00, 0x01, 0x6d, 0xab, 0x1a, 0x85, 0x28]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAParkingTicket else {
            return XCTFail("Could not parse bytes as AAParkingTicket")
        }
    
        XCTAssertEqual(capability.ticketEndTime?.value, DateFormatter.hmFormatter.date(from: "2019-10-08T11:21:45.000Z")!)
    }

    func testOperatorTicketID() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x47, 0x01, 0x03, 0x00, 0x0b, 0x01, 0x00, 0x08, 0x36, 0x34, 0x38, 0x39, 0x34, 0x32, 0x33, 0x33]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAParkingTicket else {
            return XCTFail("Could not parse bytes as AAParkingTicket")
        }
    
        XCTAssertEqual(capability.operatorTicketID?.value, "64894233")
    }

    func testOperatorName() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x47, 0x01, 0x02, 0x00, 0x11, 0x01, 0x00, 0x0e, 0x42, 0x65, 0x72, 0x6c, 0x69, 0x6e, 0x20, 0x50, 0x61, 0x72, 0x6b, 0x69, 0x6e, 0x67]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAParkingTicket else {
            return XCTFail("Could not parse bytes as AAParkingTicket")
        }
    
        XCTAssertEqual(capability.operatorName?.value, "Berlin Parking")
    }

    func testTicketStartTime() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x47, 0x01, 0x04, 0x00, 0x0b, 0x01, 0x00, 0x08, 0x00, 0x00, 0x01, 0x59, 0x89, 0xdf, 0xca, 0x30]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAParkingTicket else {
            return XCTFail("Could not parse bytes as AAParkingTicket")
        }
    
        XCTAssertEqual(capability.ticketStartTime?.value, DateFormatter.hmFormatter.date(from: "2017-01-10T19:34:22.000Z")!)
    }

    func testStatus() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x47, 0x01, 0x01, 0x00, 0x04, 0x01, 0x00, 0x01, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAParkingTicket else {
            return XCTFail("Could not parse bytes as AAParkingTicket")
        }
    
        XCTAssertEqual(capability.status?.value, .ended)
    }

    
    // MARK: Getters

    func testGetParkingTicket() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x47, 0x00]
    
        XCTAssertEqual(bytes, AAParkingTicket.getParkingTicket())
    }
    
    func testGetParkingTicketProperties() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x47, 0x00, 0x05]
        let getterBytes = AAParkingTicket.getParkingTicketProperties(propertyIDs: .ticketEndTime)
    
        XCTAssertEqual(bytes, getterBytes)
    }

    
    // MARK: Setters

    func testStartParking() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x47, 0x01] + [0x03, 0x00, 0x0b, 0x01, 0x00, 0x08, 0x36, 0x34, 0x38, 0x39, 0x34, 0x32, 0x33, 0x33, 0x04, 0x00, 0x0b, 0x01, 0x00, 0x08, 0x00, 0x00, 0x01, 0x59, 0x89, 0xdf, 0xca, 0x30, 0x02, 0x00, 0x11, 0x01, 0x00, 0x0e, 0x42, 0x65, 0x72, 0x6c, 0x69, 0x6e, 0x20, 0x50, 0x61, 0x72, 0x6b, 0x69, 0x6e, 0x67, 0x05, 0x00, 0x0b, 0x01, 0x00, 0x08, 0x00, 0x00, 0x01, 0x6d, 0xab, 0x1a, 0x85, 0x28] + [0x01, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
        let setterBytes = AAParkingTicket.startParking(operatorTicketID: "64894233", ticketStartTime: DateFormatter.hmFormatter.date(from: "2017-01-10T19:34:22.000Z")!, operatorName: "Berlin Parking", ticketEndTime: DateFormatter.hmFormatter.date(from: "2019-10-08T11:21:45.000Z")!)
    
        XCTAssertEqual(bytes, setterBytes)
    }

    func testEndParking() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x47, 0x01] + [0x01, 0x00, 0x04, 0x01, 0x00, 0x01, 0x00]
        let setterBytes = AAParkingTicket.endParking()
    
        XCTAssertEqual(bytes, setterBytes)
    }
}