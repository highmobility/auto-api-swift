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
//  AAParkingTicketTest.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import AutoAPI
import XCTest


class AAParkingTicketTest: XCTestCase {

    // MARK: State Properties

    func testOperatorName() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x47, 0x01, 0x02, 0x00, 0x11, 0x01, 0x00, 0x0e, 0x42, 0x65, 0x72, 0x6c, 0x69, 0x6e, 0x20, 0x50, 0x61, 0x72, 0x6b, 0x69, 0x6e, 0x67]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAParkingTicket else {
            return XCTFail("Could not parse bytes as AAParkingTicket")
        }
    
        XCTAssertEqual(capability.operatorName?.value, "Berlin Parking")
    }

    func testOperatorTicketID() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x47, 0x01, 0x03, 0x00, 0x0b, 0x01, 0x00, 0x08, 0x36, 0x34, 0x38, 0x39, 0x34, 0x32, 0x33, 0x33]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAParkingTicket else {
            return XCTFail("Could not parse bytes as AAParkingTicket")
        }
    
        XCTAssertEqual(capability.operatorTicketID?.value, "64894233")
    }

    func testTicketEndTime() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x47, 0x01, 0x05, 0x00, 0x0b, 0x01, 0x00, 0x08, 0x00, 0x00, 0x01, 0x6d, 0xab, 0x1a, 0x85, 0x28]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAParkingTicket else {
            return XCTFail("Could not parse bytes as AAParkingTicket")
        }
    
        XCTAssertEqual(capability.ticketEndTime?.value, DateFormatter.hmFormatter.date(from: "2019-10-08T11:21:45.000Z")!)
    }

    func testStatus() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x47, 0x01, 0x01, 0x00, 0x04, 0x01, 0x00, 0x01, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAParkingTicket else {
            return XCTFail("Could not parse bytes as AAParkingTicket")
        }
    
        XCTAssertEqual(capability.status?.value, .ended)
    }

    func testTicketStartTime() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x47, 0x01, 0x04, 0x00, 0x0b, 0x01, 0x00, 0x08, 0x00, 0x00, 0x01, 0x59, 0x89, 0xdf, 0xca, 0x30]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAParkingTicket else {
            return XCTFail("Could not parse bytes as AAParkingTicket")
        }
    
        XCTAssertEqual(capability.ticketStartTime?.value, DateFormatter.hmFormatter.date(from: "2017-01-10T19:34:22.000Z")!)
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