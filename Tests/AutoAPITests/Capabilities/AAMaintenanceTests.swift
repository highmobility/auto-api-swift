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
//  AAMaintenanceTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 29/11/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import AutoAPI
import XCTest


class AAMaintenanceTests: XCTestCase {

    static var allTests = [("testGetState", testGetState),
                           ("testState", testState)]


    // MARK: XCTestCase

    func testGetState() {
        let bytes: [UInt8] = [
            0x00, 0x34, // MSB, LSB Message Identifier for Maintenance
            0x00        // Message Type for Get Maintenance State
        ]

        XCTAssertEqual(AAMaintenance.getMaintenanceState.bytes, bytes)
    }

    func testState() {
        let bytes: [UInt8] = [
            0x00, 0x34, // MSB, LSB Message Identifier for Maintenance
            0x01,       // Message Type for Maintenance State

            0x01,       // Property identifier for Days to next service
            0x00, 0x05, // Property size is 5 bytes
            0x01,       // Data component identifier
            0x00, 0x02, // Data component size is 2 bytes
            0x01, 0xF5, // 501 days until servicing

            0x02,       // Property identifier for Kilometers to next service
            0x00, 0x07, // Property size is 7 bytes
            0x01,       // Data component identifier
            0x00, 0x04, // Data component size is 4 bytes
            0x00, 0x00, 0x0E, 0x61, // 3'681 km until servicing

            0x03,       // Property identifier for Cbs reports count
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Data component size is 1 bytes
            0x03,       // 3 Condition Based Services

            0x04,       // Property identifier for Months to exhaust inpection
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Data component size is 1 bytes
            0x05,       // 5 months until exhaust inspection

            0x05,       // Property identifier for Teleservice availability
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Data component size is 1 bytes
            0x02,       // Teleservice successful

            0x06,       // Property identifier for Service distance threshold
            0x00, 0x05, // Property size is 5 bytes
            0x01,       // Data component identifier
            0x00, 0x02, // Data component size is 2 bytes
            0x01, 0xF4, // Service distance threshold is 500km

            0x07,       // Property identifier for Service time threshold
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Data component size is 1 bytes
            0x04,       // Service time threshold is 4 weeks

            0x08,       // Property identifier for Automatic teleservice call date
            0x00, 0x0B, // Property size is 11 bytes
            0x01,       // Data component identifier
            0x00, 0x08, // Data component size is 8 bytes
            0x00, 0x00, 0x01, 0x59, 0xB8, 0xCB, 0xE7, 0xC0, // 19 January 2017 at 22:14:48 GMT      - 1 484 864 088

            0x09,       // Property identifier for Teleservice battery call date
            0x00, 0x0B, // Property size is 11 bytes
            0x01,       // Data component identifier
            0x00, 0x08, // Data component size is 8 bytes
            0x00, 0x00, 0x01, 0x5B, 0x78, 0xD5, 0x2B, 0xC0, // 16 April 2017 at 22:14:48 GMT        - 1 492 380 888

            0x0A,       // Property identifier for Next inspection date
            0x00, 0x0B, // Property size is 11 bytes
            0x01,       // Data component identifier
            0x00, 0x08, // Data component size is 8 bytes
            0x00, 0x00, 0x01, 0x62, 0xCF, 0x72, 0xD4, 0x80, // 16 April 2018 at 17:13:52 GMT        - 1 523 898 832

            0x0B,       // Property identifier for Condition based services
            0x00, 0x43, // Property size is 67 bytes
            0x01,       // Data component identifier
            0x00, 0x40, // Data component size is 64 bytes
            0x13,                                                               // 2019
            0x05,                                                               // May
            0x00, 0x03,                                                         // Identifier is 3
            0x00,                                                               // Status is OK
            0x00, 0x0B,                                                         // Text size is 11 bytes
            0x42, 0x72, 0x61, 0x6B, 0x65, 0x20, 0x66, 0x6C, 0x75, 0x69, 0x64,   // Text is "Brake fluid"
            0x00, 0x2C,                                                         // Description size is 44 bytes
            0x4E, 0x65, 0x78, 0x74, 0x20, 0x63, 0x68, 0x61, 0x6E, 0x67, 0x65,
            0x20, 0x61, 0x74, 0x20, 0x73, 0x70, 0x65, 0x63, 0x69, 0x66, 0x69,
            0x65, 0x64, 0x20, 0x64, 0x61, 0x74, 0x65, 0x20, 0x61, 0x74, 0x20,
            0x74, 0x68, 0x65, 0x20, 0x6C, 0x61, 0x74, 0x65, 0x73, 0x74, 0x2E,   // Description is "Next change at specified date at the latest."

            0x0B,       // Property identifier for Condition based services
            0x00, 0x52, // Property size is 82 bytes
            0x01,       // Data component identifier
            0x00, 0x4F, // Data component size is 79 bytes
            0x13,                                                   // 2019
            0x03,                                                   // March
            0x00, 0x20,                                             // Identifier is 32
            0x01,                                                   // Status is pending
            0x00, 0x12,                                             // Text size is 18 bytes
            0x56, 0x65, 0x68, 0x69, 0x63, 0x6C, 0x65, 0x20, 0x69,
            0x6E, 0x73, 0x70, 0x65, 0x63, 0x74, 0x69, 0x6F, 0x6E,   // Text is "Vehicle inspection"
            0x00, 0x34,                                             // Description size is 52 bytes
            0x4E, 0x65, 0x78, 0x74, 0x20, 0x6D, 0x61, 0x6E, 0x64,
            0x61, 0x74, 0x6F, 0x72, 0x79, 0x20, 0x76, 0x65, 0x68,
            0x69, 0x63, 0x6C, 0x65, 0x20, 0x69, 0x6E, 0x73, 0x70,
            0x65, 0x63, 0x74, 0x69, 0x6F, 0x6E, 0x20, 0x6F, 0x6E,
            0x20, 0x73, 0x70, 0x65, 0x63, 0x69, 0x66, 0x69, 0x65,
            0x64, 0x20, 0x64, 0x61, 0x74, 0x65, 0x2E,               // Description is "Next mandatory vehicle inspection on specified date."

            0x0C,       // Property identifier for Brake fluid change date
            0x00, 0x0B, // Property size is 11 bytes
            0x01,       // Data component identifier
            0x00, 0x08, // Data component size is 8 bytes
            0x00, 0x00, 0x01, 0x69, 0x7C, 0xC6, 0x33, 0xB0  // 14 March 2019 at 15:15:58 GMT        - 1 552 576 558
        ]

        guard let maintenance = AAAutoAPI.parseBinary(bytes) as? AAMaintenance else {
            return XCTFail("Parsed value is not AAMaintenance")
        }

        XCTAssertEqual(maintenance.daysToNextService?.value, 501)
        XCTAssertEqual(maintenance.kmToNextService?.value, 3_681)
        XCTAssertEqual(maintenance.cbsReportsCount?.value, 3)
        XCTAssertEqual(maintenance.monthsToExhaustInspection?.value, 5)
        XCTAssertEqual(maintenance.teleserviceAvailability?.value, .successful)
        XCTAssertEqual(maintenance.serviceDistanceThreshold?.value, 500)
        XCTAssertEqual(maintenance.serviceTimeThreshold?.value, 4)
        XCTAssertEqual(maintenance.automaticTeleserviceCallDate?.value, Date(timeIntervalSince1970: 1_484_864_088.0))
        XCTAssertEqual(maintenance.teleserviceBatteryCallDate?.value, Date(timeIntervalSince1970: 1_492_380_888.0))
        XCTAssertEqual(maintenance.nextInspectionDate?.value, Date(timeIntervalSince1970: 1_523_898_832.0))
        XCTAssertEqual(maintenance.brakeFluidChangeDate?.value, Date(timeIntervalSince1970: 1_552_576_558.0))

        // Condition Based Services
        let CBSs = maintenance.conditionBasedServices

        XCTAssertEqual(CBSs?.count, 2)

        if let service = CBSs?.first(where: { $0.value?.id == 3 }) {
            if let date = DateComponents(calendar: .current, year: 2019, month: 5).date {
                XCTAssertEqual(service.value?.date, date)
            }
            else {
                return XCTFail("Failed to generate a Date")
            }

            XCTAssertEqual(service.value?.status, .ok)
            XCTAssertEqual(service.value?.text, "Brake fluid")
            XCTAssertEqual(service.value?.description, "Next change at specified date at the latest.")
        }
        else {
            XCTFail("Condition Based Services doesn't contain ID#3 Service")
        }

        if let service = CBSs?.first(where: { $0.value?.id == 32 }) {
            if let date = DateComponents(calendar: .current, year: 2019, month: 3).date {
                XCTAssertEqual(service.value?.date, date)
            }
            else {
                return XCTFail("Failed to generate a Date")
            }

            XCTAssertEqual(service.value?.status, .pending)
            XCTAssertEqual(service.value?.text, "Vehicle inspection")
            XCTAssertEqual(service.value?.description, "Next mandatory vehicle inspection on specified date.")
        }
        else {
            XCTFail("Condition Based Services doesn't contain ID#3 Service")
        }
    }
}
