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
//  ChargingTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 30/11/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import AutoAPI
import XCTest


class ChargingTests: XCTestCase {

    static var allTests = [("testGetState", testGetState),
                           ("testSetChargeLimit", testSetChargeLimit),
                           ("testSetChargeMode", testSetChargeMode),
                           ("testSetChargeTimer", testSetChargeTimer),
                           ("testStartStopCharging", testStartStopCharging),
                           ("testState", testState)]


    // MARK: XCTestCase

    func testGetState() {
        let bytes: [UInt8] = [
            0x00, 0x23, // MSB, LSB Message Identifier for Charging
            0x00        // Message Type for Get Charge State
        ]

        XCTAssertEqual(AACharging.getChargeState, bytes)
    }

    func testOpenClose() {
        let bytes: [UInt8] = [
            0x00, 0x23, // MSB, LSB Message Identifier for Charging
            0x04,       // Message Type for Open Gas Flap
            0x01        // Open charge port
        ]

        XCTAssertEqual(AACharging.openCloseChargePort(.open), bytes)
    }

    func testSetChargeLimit() {
        let bytes: [UInt8] = [
            0x00, 0x23, // MSB, LSB Message Identifier for Charging
            0x03,       // Message Type for Set Charge Limit
            0x5A        // 90%
        ]

        XCTAssertEqual(AACharging.setChargeLimit(90), bytes)
    }

    func testSetChargeMode() {
        let bytes: [UInt8] = [
            0x00, 0x23, // MSB, LSB Message Identifier for Charging
            0x05,       // Message Type for Set Charge Mode
            0x02        // Inductive charging
        ]

        XCTAssertEqual(AACharging.setChargeMode(.inductive) ?? [], bytes)
    }

    func testSetChargeTimer() {
        let bytes: [UInt8] = [
            0x00, 0x23, // MSB, LSB Message Identifier for Charging
            0x06,       // Message Type for Set Charge Timer

            0x0D,       // Property Identifier for Charge timer
            0x00, 0x09, // Property size 9 bytes
            0x02,       // Departure time
            0x12,       // 2018
            0x01,       // January
            0x0a,       // the 10th
            0x10,       // at 16h
            0x20,       // 32min
            0x05,       // 5 seconds
            0x00, 0x00  // 0 min UTC time offset
        ]

        let time = YearTime(year: 2018, month: 1, day: 10, hour: 16, minute: 32, second: 5, offset: 0)

        XCTAssertEqual(AACharging.setChargeTimer(.init(type: .departureDate, time: time)), bytes)


        
    }

    func testStartStopCharging() {
        let bytes: [UInt8] = [
            0x00, 0x23, // MSB, LSB Message Identifier for Charging
            0x02,       // Message Type for Start/Stop Charging
            0x01        // Start Charging
        ]

        XCTAssertEqual(AACharging.startCharging(true), bytes)
    }

    func testState() {
        let bytes: [UInt8] = [
            0x00, 0x23, // MSB, LSB Message Identifier for Charging
            0x01,       // Message Type for Charge State

            0x01,       // Property Identifier for Charging
            0x00, 0x01, // Property size 1 byte
            0x02,       // Charging

            0x02,       // Property Identifier for Estimated Range
            0x00, 0x02, // Property size 2 bytes
            0x00,       // MSB estimated range
            0xFF,       // LSB estimated range, 255 km

            0x03,       // Property Identifier for Battery Level
            0x00, 0x01, // Property size 1 byte
            0x32,       // Battery level 50%

            0x04,                   // Property Identifier for Battery Current (AC)
            0x00, 0x04,             // Property size 4 bytes
            0xbf, 0x19, 0x99, 0x9a, // Battery current (AC) -0.6

            0x05,                   // Property Identifier for Battery Current (DC)
            0x00, 0x04,             // Property size 4 bytes
            0xbf, 0x19, 0x99, 0x9a, // Battery current (DC) -0.6

            0x06,                   // Property Identifier for Charger Voltage (AC)
            0x00, 0x04,             // Property size 4 bytes
            0x43, 0xc8, 0x00, 0x00, // Charger voltage 400V

            0x07,                   // Property Identifier for Charger Voltage (DC)
            0x00, 0x04,             // Property size 4 bytes
            0x43, 0xcd, 0x00, 0x00, // Charger voltage 410V

            0x08,       // Property Identifier for Charge Limit
            0x00, 0x01, // Property size 1 byte
            0x5A,       // Charge limit 90%

            0x09,       // Property Identifier for Time to complete charge
            0x00, 0x02, // Property size 2 bytes
            0x00,       // MSB time to complete charge
            0x3C,       // LSB time to complete charge 60 minutes

            0x0A,                   // Property Identifier for Charge rate
            0x00, 0x04,             // Property size 4 bytes
            0x00, 0x00, 0x00, 0x00, // Charge rate 0kW

            0x0B,       // Property Identifier for Charge port
            0x00, 0x01, // Property size 1 byte
            0x01,       // Charge port open

            0x0C,       // Property identifier for Charge mode
            0x00, 0x01, // Property size is 1 bytes
            0x00,       // Immediate charging

            0x0D,       // Property identifier for Charge timer
            0x00, 0x09, // Property size is 9 bytes
            0x02,       // Departure time
            0x12,       // 2018
            0x01,       // January
            0x0A,       // the 10th
            0x10,       // at 16h
            0x20,       // 32min
            0x05,       // 5 seconds
            0x00, 0x00  // 0 min UTC time offset
        ]

        guard let charging = AutoAPI.parseBinary(bytes) as? AACharging else {
            return XCTFail("Parsed value is not Charging")
        }

        XCTAssertEqual(charging.chargingState, .charging)
        XCTAssertEqual(charging.estimatedRange, 255)
        XCTAssertEqual(charging.batteryLevel, 50)
        XCTAssertEqual(charging.batteryCurrentAC, -0.6)
        XCTAssertEqual(charging.batteryCurrentDC, -0.6)
        XCTAssertEqual(charging.chargerVoltageAC, 400.0)
        XCTAssertEqual(charging.chargerVoltageDC, 410.0)
        XCTAssertEqual(charging.chargeLimit, 90)
        XCTAssertEqual(charging.timeToCompleteCharge, 60)
        XCTAssertEqual(charging.chargingRate, 0.0)
        XCTAssertEqual(charging.chargePortState, .open)
        XCTAssertEqual(charging.chargeMode, .immediate)

        let time = YearTime(year: 2018, month: 1, day: 10, hour: 16, minute: 32, second: 5, offset: 0)
        
        XCTAssertEqual(charging.chargeTimer, AAChargeTimer(type: .departureDate, time: time))
    }
}
