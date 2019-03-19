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
//  AAParkingTicketTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 12/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import AutoAPI
import XCTest


class AAParkingTicketTests: XCTestCase {

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

        XCTAssertEqual(AAParkingTicket.endParking().bytes, bytes)
    }

    func testGetState() {
        let bytes: [UInt8] = [
            0x00, 0x47, // MSB, LSB Message Identifier for Parking Ticket
            0x00        // Message Type for Get Parking Ticket
        ]

        XCTAssertEqual(AAParkingTicket.getTicket.bytes, bytes)
    }

    func testStartParking() {
        let bytes: [UInt8] = [
            0x00, 0x47, // MSB, LSB Message Identifier for Parking Ticket
            0x02,       // Message Type for Start Parking

            0x01,       // Property Identifier for Operator Name
            0x00, 0x11, // Property size is 17 bytes
            0x01,       // Data component
            0x00, 0x0E, // Data component size is 14 bytes
            0x42, 0x65, 0x72, 0x6c, 0x69, 0x6e, 0x20,   //
            0x50, 0x61, 0x72, 0x6b, 0x69, 0x6e, 0x67,   // "Berlin Parking"

            0x02,       // Property Identifier for Operator Ticket ID
            0x00, 0x0B, // Property size is 11 bytes
            0x01,       // Data component
            0x00, 0x08, // Data component size is 8 bytes
            0x36, 0x34, 0x38, 0x39, //
            0x34, 0x32, 0x33, 0x33, // Ticket number 64894233

            0x03,       // Property Identifier for Ticket Start Time
            0x00, 0x0B, // Property size is 11 bytes
            0x01,       // Data component
            0x00, 0x08, // Data component size is 8 bytes
            0x00, 0x00, 0x01, 0x59, 0x89, 0x71, 0x97, 0x40  // 10 January 2017 at 17:34:00 GMT

            // No parking End Time is set
        ]

        let startTime = Date(timeIntervalSince1970: 1_484_069_640.0)
        let parking = AAParkingTicket.startParking(ticketID: "64894233", startTime: startTime, endTime: nil, operatorName: "Berlin Parking")

        XCTAssertEqual(parking.bytes, bytes)
    }

    func testState() {
        let bytes: [UInt8] = [
            0x00, 0x47, // MSB, LSB Message Identifier for Parking Ticket
            0x01,       // Message Type for Parking Ticket

            0x01,       // Property identifier for Parking ticket state
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Data component size is 1 bytes
            0x01,       // Parking started

            0x02,       // Property identifier for Operator name
            0x00, 0x11, // Property size is 17 bytes
            0x01,       // Data component identifier
            0x00, 0x0E, // Data component size is 14 bytes
            0x42, 0x65, 0x72, 0x6C, 0x69, 0x6E, 0x20,
            0x50, 0x61, 0x72, 0x6B, 0x69, 0x6E, 0x67,   // Operator name is 'Berlin Parking'

            0x03,       // Property identifier for Operator ticket id
            0x00, 0x0B, // Property size is 11 bytes
            0x01,       // Data component identifier
            0x00, 0x08, // Data component size is 8 bytes
            0x36, 0x34, 0x38, 0x39, 0x34, 0x32, 0x33, 0x33, // Ticket number '64894233'

            0x04,       // Property identifier for Ticket start time
            0x00, 0x0B, // Property size is 11 bytes
            0x01,       // Data component identifier
            0x00, 0x08, // Data component size is 8 bytes
            0x00, 0x00, 0x01, 0x59, 0x89, 0xDF, 0xCA, 0x30, // Parking started 10 January 2017 at 19:34:22 GMT

            0x05,       // Property identifier for Ticket end time
            0x00, 0x0B, // Property size is 11 bytes
            0x01,       // Data component identifier
            0x00, 0x08, // Data component size is 8 bytes
            0x00, 0x00, 0x01, 0x5A, 0x5F, 0xB9, 0xBF, 0x08 // Parking ended 21 February 2017 at 08:11:33 GMT
        ]

        guard let parkingTicket = AAAutoAPI.parseBinary(bytes) as? AAParkingTicket else {
            return XCTFail("Parsed value is not ParkingTicket")
        }

        XCTAssertEqual(parkingTicket.state?.value, .started)
        XCTAssertEqual(parkingTicket.operatorName?.value, "Berlin Parking")
        XCTAssertEqual(parkingTicket.ticketID?.value, "64894233")

        XCTAssertEqual(parkingTicket.startTime?.value, Date(timeIntervalSince1970: 1_484_076_862.0))

        XCTAssertEqual(parkingTicket.endTime?.value, Date(timeIntervalSince1970: 1_487_664_693.0))
    }
}
