//
// AutoAPITests
// Copyright (C) 2017 High-Mobility GmbH
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
//  ParkingTicketTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 12/12/2017.
//  Copyright © 2017 High Mobility. All rights reserved.
//

import AutoAPI
import XCTest


class ParkingTicketTests: XCTestCase {

    static var allTests = [("testEndParking", testEndParking),
                           ("testGetState", testGetState),
                           ("testStartParking", testStartParking),
                           ("testState", testState)]


    // MARK: XCTestCase

    func testEndParking() {
        let bytes: [UInt8] = [
            0x00, 0x47, // MSB, LSB Message Identifier for Parking Ticket
            0x03        // Message Type for End Parking
        ]

        XCTAssertEqual(ParkingTicket.endParking, bytes)
    }

    func testGetState() {
        let bytes: [UInt8] = [
            0x00, 0x47, // MSB, LSB Message Identifier for Parking Ticket
            0x00        // Message Type for Get Parking Ticket
        ]

        XCTAssertEqual(ParkingTicket.getParkingTicket, bytes)
    }

    func testStartParking() {
        let bytes: [UInt8] = [
            0x00, 0x47, // MSB, LSB Message Identifier for Parking Ticket
            0x02,       // Message Type for Start Parking

            0x01,       // Property Identifier for Operator Name
            0x00, 0x0E, // Property size is 14 bytes
            0x42, 0x65, 0x72, 0x6c, 0x69, 0x6e, 0x20,   //
            0x50, 0x61, 0x72, 0x6b, 0x69, 0x6e, 0x67,   // "Berlin Parking"

            0x02,       // Property Identifier for Operator Ticket ID
            0x00, 0x08, // Property size is 8 bytes
            0x36, 0x34, 0x38, 0x39, //
            0x34, 0x32, 0x33, 0x33, // Ticket number 64894233

            0x03,       // Property Identifier for Ticket Start Time
            0x00, 0x08, // Property size is 8 bytes
            0x11,       // Parking started 2017
            0x01,       // January
            0x0a,       // the 10th
            0x11,       // at 17h
            0x22,       // 34min
            0x00,       // 0sec
            0x00, 0x00  // 0min UTF time offset

            // No parking End Time is set
        ]

        let name = "Berlin Parking"
        let ticketID = "64894233"
        let startTime = YearTime(year: 2017, month: 1, day: 10, hour: 17, minute: 34, second: 0, offset: 0)
        let settings = ParkingTicket.Settings(operatorName: name, ticketID: ticketID, startTime: startTime, endTime: nil)


        XCTAssertEqual(ParkingTicket.startParking(settings), bytes)
    }

    func testState() {
        let bytes: [UInt8] = [
            0x00, 0x47, // MSB, LSB Message Identifier for Parking Ticket
            0x01,       // Message Type for Parking Ticket

            0x01,       // Property Identifier for Parking Ticket State
            0x00, 0x01, // Propery size is 1 byte
            0x01,       // Parking started

            0x02,       // Property Identifier for Operator Name
            0x00, 0x0E, // Property size is 14 bytes
            0x42, 0x65, 0x72, 0x6c, 0x69, 0x6e, 0x20,   //
            0x50, 0x61, 0x72, 0x6b, 0x69, 0x6e, 0x67,   // "Berlin Parking"

            0x03,       // Property Identifier for Operator Ticket ID
            0x00, 0x08, // Property size is 8 bytes
            0x36, 0x34, 0x38, 0x39, //
            0x34, 0x32, 0x33, 0x33, // Ticket number 64894233

            0x04,       // Property Identifier for Ticket Start Time
            0x00, 0x08, // Property size is 8 bytes
            0x11,       // Parking started 2017
            0x01,       // January
            0x0a,       // the 10th
            0x11,       // at 17h
            0x22,       // 34min
            0x00,       // 0sec
            0x00, 0x00, // 0min UTF time offset

            0x05,       // Property Identifier for Ticket End Time
            0x00, 0x08, // Property size is 8 bytes
            0x12,       // Parking ending 2018
            0x02,       // February
            0x14,       // the 20th
            0x16,       // at 22h
            0x0B,       // 11min
            0x00,       // 0sec
            0x00, 0x00  // 0min UTF time offset
        ]

        guard let parkingTicket = AutoAPI.parseBinary(bytes) as? ParkingTicket else {
            return XCTFail("Parsed value is not ParkingTicket")
        }

        XCTAssertEqual(parkingTicket.state, .started)
        XCTAssertEqual(parkingTicket.operatorName, "Berlin Parking")
        XCTAssertEqual(parkingTicket.ticketID, "64894233")

        XCTAssertEqual(parkingTicket.startTime?.year, 2017)
        XCTAssertEqual(parkingTicket.startTime?.month, 1)
        XCTAssertEqual(parkingTicket.startTime?.day, 10)
        XCTAssertEqual(parkingTicket.startTime?.hour, 17)
        XCTAssertEqual(parkingTicket.startTime?.minute, 34)
        XCTAssertEqual(parkingTicket.startTime?.second, 0)
        XCTAssertEqual(parkingTicket.startTime?.offset, 0)

        XCTAssertEqual(parkingTicket.endTime?.year, 2018)
        XCTAssertEqual(parkingTicket.endTime?.month, 2)
        XCTAssertEqual(parkingTicket.endTime?.day, 20)
        XCTAssertEqual(parkingTicket.endTime?.hour, 22)
        XCTAssertEqual(parkingTicket.endTime?.minute, 11)
        XCTAssertEqual(parkingTicket.endTime?.second, 0)
        XCTAssertEqual(parkingTicket.endTime?.offset, 0)
    }
}
