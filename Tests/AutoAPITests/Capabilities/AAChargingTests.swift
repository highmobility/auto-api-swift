//
// AutoAPITests
// Copyright (C) 2019 High-Mobility GmbH
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
//  AAChargingTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 30/11/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import AutoAPI
import XCTest


class AAChargingTests: XCTestCase {

    static var allTests = [("testGetState", testGetState),
                           ("testSetChargeLimit", testSetChargeLimit),
                           ("testSetChargeMode", testSetChargeMode),
                           ("testSetChargeTimer", testSetChargeTimer),
                           ("testSetReductionTimes", testSetReductionTimes),
                           ("testStartStopCharging", testStartStopCharging),
                           ("testState", testState)]


    // MARK: XCTestCase

    func testGetState() {
        let bytes: [UInt8] = [
            0x00, 0x23, // MSB, LSB Message Identifier for Charging
            0x00        // Message Type for Get Charge State
        ]

        XCTAssertEqual(AACharging.getChargingState.bytes, bytes)
    }

    func testOpenClose() {
        let bytes: [UInt8] = [
            0x00, 0x23, // MSB, LSB Message Identifier for Charging
            0x14,       // Message Type for Open/Close Charge Port

            0x01,       // Property Identifier for Charge port
            0x00, 0x04, // Property size is 4 byte
            0x01,       // Data component
            0x00, 0x01, // Data component size is 1 byte
            0x01        // Open charge port
        ]

        XCTAssertEqual(AACharging.openCloseChargePort(.open).bytes, bytes)
    }

    func testSetChargeLimit() {
        let bytes: [UInt8] = [
            0x00, 0x23, // MSB, LSB Message Identifier for Charging
            0x13,       // Message Type for Set Charge Limit

            0x01,       // Property Identifier for Charge limit
            0x00, 0x0B, // Property size is 11 byte
            0x01,       // Data component
            0x00, 0x08, // Data component size is 8 byte
            0x40, 0x56, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00  // 90%
        ]

        XCTAssertEqual(AACharging.setChargeLimit(90.0).bytes, bytes)
    }

    func testSetChargeMode() {
        let bytes: [UInt8] = [
            0x00, 0x23, // MSB, LSB Message Identifier for Charging
            0x15,       // Message Type for Set Charge Mode

            0x01,       // Property Identifier for Charge mode
            0x00, 0x04, // Property size is 4 byte
            0x01,       // Data component
            0x00, 0x01, // Data component size is 1 byte
            0x02        // Inductive
        ]

        guard let chargeModeBytes = AACharging.setChargeMode(.inductive)?.bytes else {
            return XCTFail("Failed to generate Set Charge Mode bytes")
        }

        XCTAssertEqual(chargeModeBytes, bytes)

        // Alos check the failure version
        XCTAssertNil(AACharging.setChargeMode(.immediate), "Immediate Charge Mode shouldn't be possible to set")
    }

    func testSetChargeTimer() {
        let bytes: [UInt8] = [
            0x00, 0x23, // MSB, LSB Message Identifier for Charging
            0x16,       // Message Type for Set Charge Timer

            0x0D,       // Property Identifier for Charge timer
            0x00, 0x0C, // Property size 12 bytes
            0x01,       // Data component
            0x00, 0x09, // Data component size is 9 byte
            0x02,                                           // Departure time
            0x00, 0x00, 0x01, 0x69, 0xB9, 0x3F, 0x7A, 0xB8  // 26 March 2019 at 09:05:39 GMT
        ]

        let timer = AAChargingTimer(type: .departureDate, time: Date(timeIntervalSince1970: 1_553_591_139.0))

        XCTAssertEqual(AACharging.setChargingTimers([timer]).bytes, bytes)
    }

    func testSetReductionTimes() {
        let bytes: [UInt8] = [
            0x00, 0x23, // MSB, LSB Message Identifier for Charging
            0x17,        // Message Type for Set Reduction of Charging-current Times

            0x01,       // Property Identifier for Charging-current reduction times
            0x00, 0x06, // Property size is 6 byte
            0x01,       // Data component
            0x00, 0x03, // Data component size is 3 byte
            0x01,       // Stop time
            0x10,       // at 16h
            0x20        // 32min
        ]

        let reductionTime = AAReductionTime(state: .stop, time: AATime(hour: 16, minute: 32))

        XCTAssertEqual(AACharging.setReductionOfChargingCurrentTimes([reductionTime]).bytes, bytes)
    }

    func testStartStopCharging() {
        let bytes: [UInt8] = [
            0x00, 0x23, // MSB, LSB Message Identifier for Charging
            0x12,       // Message Type for Start/Stop Charging

            0x01,       // Property Identifier for State
            0x00, 0x04, // Property size is 4 byte
            0x01,       // Data component
            0x00, 0x01, // Data component size is 1 byte
            0x01        // Start Charging
        ]

        XCTAssertEqual(AACharging.startStopCharging(.active).bytes, bytes)
    }

    func testState() {
        let bytes: [UInt8] = [
            0x00, 0x23, // MSB, LSB Message Identifier for Charging
            0x01,       // Message Type for Charge State

            0x02,       // Property identifier for Estimated range
            0x00, 0x05, // Property size is 5 bytes
            0x01,       // Data component identifier
            0x00, 0x02, // Data component size is 2 bytes
            0x01, 0xB0, // 432 km estimated range

            0x03,       // Property identifier for Battery level
            0x00, 0x0B, // Property size is 11 bytes
            0x01,       // Data component identifier
            0x00, 0x08, // Data component size is 8 bytes
            0x3F, 0xE0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, // Battery level 50%

            0x04,       // Property identifier for Battery current ac
            0x00, 0x07, // Property size is 7 bytes
            0x01,       // Data component identifier
            0x00, 0x04, // Data component size is 4 bytes
            0xBF, 0x19, 0x99, 0x9A, // Battery current (AC) -0.6

            0x05,       // Property identifier for Battery current dc
            0x00, 0x07, // Property size is 7 bytes
            0x01,       // Data component identifier
            0x00, 0x04, // Data component size is 4 bytes
            0xBF, 0x19, 0x99, 0x9A, // Battery current (DC) -0.6

            0x06,       // Property identifier for Charger voltage ac
            0x00, 0x07, // Property size is 7 bytes
            0x01,       // Data component identifier
            0x00, 0x04, // Data component size is 4 bytes
            0x43, 0xC8, 0x00, 0x00, // Charger voltage 400V

            0x07,       // Property identifier for Charger voltage dc
            0x00, 0x07, // Property size is 7 bytes
            0x01,       // Data component identifier
            0x00, 0x04, // Data component size is 4 bytes
            0x43, 0xC8, 0x00, 0x00, // Charger voltage 400V

            0x08,       // Property identifier for Charge limit
            0x00, 0x0B, // Property size is 11 bytes
            0x01,       // Data component identifier
            0x00, 0x08, // Data component size is 8 bytes
            0x3F, 0xEC, 0xCC, 0xCC, 0xCC, 0xCC, 0xCC, 0xCD, // Charge limit 90%

            0x09,       // Property identifier for Time to complete charge
            0x00, 0x05, // Property size is 5 bytes
            0x01,       // Data component identifier
            0x00, 0x02, // Data component size is 2 bytes
            0x00, 0x3C, // Time to complete charge 60 minutes

            0x0A,       // Property identifier for Charging rate kw
            0x00, 0x07, // Property size is 7 bytes
            0x01,       // Data component identifier
            0x00, 0x04, // Data component size is 4 bytes
            0x40, 0x60, 0x00, 0x00, // 3.5 kW charge rate

            0x0B,       // Property identifier for Charge port state
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Data component size is 1 bytes
            0x01,       // Charge port open

            0x0C,       // Property identifier for Charge mode
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Data component size is 1 bytes
            0x01,       // Timer based charging

            0x0E,       // Property identifier for Max charging current
            0x00, 0x07, // Property size is 7 bytes
            0x01,       // Data component identifier
            0x00, 0x04, // Data component size is 4 bytes
            0x41, 0xC8, 0x00, 0x00, // Maximum charging current is 25.0 A

            0x0F,       // Property identifier for Plug type
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Data component size is 1 bytes
            0x01,       // The socket is Type 2

            0x10,       // Property identifier for Charging window chosen
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Data component size is 1 bytes
            0x00,       // No charging windows has been chosen

            0x11,       // Property identifier for Departure times
            0x00, 0x06, // Property size is 6 bytes
            0x01,       // Data component identifier
            0x00, 0x03, // Data component size is 3 bytes
            0x01,       // Departure time is active
            0x10,       // at 16h
            0x20,       // 32min

            0x11,       // Property identifier for Departure times
            0x00, 0x06, // Property size is 6 bytes
            0x01,       // Data component identifier
            0x00, 0x03, // Data component size is 3 bytes
            0x00,       // Departure time is inactive
            0x0B,       // at 11h
            0x33,       // 51min

            0x13,       // Property identifier for Reduction times
            0x00, 0x06, // Property size is 6 bytes
            0x01,       // Data component identifier
            0x00, 0x03, // Data component size is 3 bytes
            0x00,       // Start reduction of charging current
            0x11,       // at 17h
            0x21,       // 33min

            0x13,       // Property identifier for Reduction times
            0x00, 0x06, // Property size is 6 bytes
            0x01,       // Data component identifier
            0x00, 0x03, // Data component size is 3 bytes
            0x01,       // Stop reduction of charging current
            0x0C,       // at 12h
            0x34,       // 52min

            0x14,       // Property identifier for Battery temperature
            0x00, 0x07, // Property size is 7 bytes
            0x01,       // Data component identifier
            0x00, 0x04, // Data component size is 4 bytes
            0x42, 0x19, 0x99, 0x9A, // The battery temperature is 38.4 degrees Celsius

            0x15,       // Property identifier for Timers
            0x00, 0x0C, // Property size is 12 bytes
            0x01,       // Data component identifier
            0x00, 0x09, // Data component size is 9 bytes
            0x00,                                           // Preferred start time
            0x00, 0x00, 0x01, 0x59, 0x89, 0x38, 0xE7, 0x88, // 10 January 2017 at 16:32:05 UTC

            0x15,       // Property identifier for Timers
            0x00, 0x0C, // Property size is 12 bytes
            0x01,       // Data component identifier
            0x00, 0x09, // Data component size is 9 bytes
            0x01,                                           // Preferred end time
            0x00, 0x00, 0x01, 0x59, 0x89, 0x3C, 0x91, 0x08, // 10 January 2017 at 16:36:05 GMT

            0x16,       // Property identifier for Plugged in
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Data component size is 1 bytes
            0x01,       // The charger is plugged in

            0x17,       // Property identifier for Charging state
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Data component size is 1 bytes
            0x01        // The vehicle is charging
        ]

        var charging: AACharging!

        measure {
            guard let parsed = AAAutoAPI.parseBinary(bytes) as? AACharging else {
                return XCTFail("Parsed value is not AACharging")
            }

            charging = parsed
        }

        XCTAssertEqual(charging.estimatedRange?.value, 432)
        XCTAssertEqual(charging.batteryLevel?.value, 0.5)
        XCTAssertEqual(charging.batteryCurrentAC?.value, -0.6)
        XCTAssertEqual(charging.batteryCurrentDC?.value, -0.6)
        XCTAssertEqual(charging.chargerVoltageAC?.value, 400.0)
        XCTAssertEqual(charging.chargerVoltageDC?.value, 400.0)
        XCTAssertEqual(charging.chargeLimit?.value, 0.9)
        XCTAssertEqual(charging.timeToCompleteCharge?.value, 60)
        XCTAssertEqual(charging.chargingRate?.value, 3.5)
        XCTAssertEqual(charging.chargePortState?.value, .open)
        XCTAssertEqual(charging.chargeMode?.value, .timerBased)
        XCTAssertEqual(charging.maxChargingCurrentAC?.value, 25.0)
        XCTAssertEqual(charging.plugType?.value, .type2)
        XCTAssertEqual(charging.chargingWindowChosen?.value, .notChosen)
        XCTAssertEqual(charging.batteryTemperature?.value, 38.4)
        XCTAssertEqual(charging.pluggedIn?.value, .pluggedIn)
        XCTAssertEqual(charging.state?.value, .charging)

        // Departure Times
        XCTAssertEqual(charging.departureTimes?.count, 2)

        if let departureTime = charging.departureTimes?.first(where: { $0.value?.state == .active }) {
            XCTAssertEqual(departureTime.value?.time, AATime(hour: 16, minute: 32))
        }
        else {
            XCTFail("Deprature Times doesn't contain Active time")
        }

        if let departureTime = charging.departureTimes?.first(where: { $0.value?.state == .inactive }) {
            XCTAssertEqual(departureTime.value?.time, AATime(hour: 11, minute: 51))
        }
        else {
            XCTFail("Deprature Times doesn't contain Inactive time")
        }

        // Reduction Times
        XCTAssertEqual(charging.reductionOfChargingCurrentTimes?.count, 2)

        if let reduction = charging.reductionOfChargingCurrentTimes?.first(where: { $0.value?.state == .start }) {
            XCTAssertEqual(reduction.value?.time, AATime(hour: 17, minute: 33))
        }
        else {
            XCTFail("Reduction of Charging Current Times doesn't contain Start time")
        }

        if let reduction = charging.reductionOfChargingCurrentTimes?.first(where: { $0.value?.state == .stop }) {
            XCTAssertEqual(reduction.value?.time, AATime(hour: 12, minute: 52))
        }
        else {
            XCTFail("Reduction of Charging Current Times doesn't contain Stop time")
        }

        // Timers
        XCTAssertEqual(charging.timers?.count, 2)

        if let timer = charging.timers?.first(where: { $0.value?.type == .prefferedStartTime }) {
            XCTAssertEqual(timer.value?.time, Date(timeIntervalSince1970: 1_484_065_925.0))
        }
        else {
            XCTFail("Charging Timers doesn't contain Preffered Start Time timer")
        }

        if let timer = charging.timers?.first(where: { $0.value?.type == .prefferedEndTime }) {
            XCTAssertEqual(timer.value?.time, Date(timeIntervalSince1970: 1_484_066_165.0))
        }
        else {
            XCTFail("Charging Timers doesn't contain Preffered End Time timer")
        }
    }
}
