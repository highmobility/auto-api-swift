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
//  AAClimateTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 30/11/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import AutoAPI
import XCTest


class AAClimateTests: XCTestCase {

    static var allTests = [("testChangeStartingTimes", testChangeStartingTimes),
                           ("testChangeTemperatures", testChangeTemperatures),
                           ("testGetState", testGetState),
                           ("testStartStopDefogging", testStartStopDefogging),
                           ("testStartStopDefrosting", testStartStopDefrosting),
                           ("testStartStopHVAC", testStartStopHVAC),
                           ("testStartStopIonising", testStartStopIonising),
                           ("testState", testState)]


    // MARK: XCTestCase

    func testChangeStartingTimes() {
        let bytes: [UInt8] = [
            0x00, 0x24, // MSB, LSB Message Identifier for Climate
            0x12,       // Message Type for Set HVAC Starting Times

            0x01,       // Property Identifier for HVAC weekday starting times
            0x00, 0x06, // Property size is 6 bytes
            0x01,       // Data component
            0x00, 0x03, // Data component size is 3 bytes
            0x00,       // HVAC activated for Mondays
            0x08, 0x00, // Start at 08:00

            0x01,       // Property Identifier for HVAC weekday starting times
            0x00, 0x06, // Property size is 6 bytes
            0x01,       // Data component
            0x00, 0x03, // Data component size is 3 bytes
            0x02,       // HVAC activated for Wednesdays
            0x08, 0x0A  // Start at 08:10
        ]

        let time1 = AAClimateWeekdayTime(weekday: .monday, time: AATime(hour: 8, minute: 0))
        let time2 = AAClimateWeekdayTime(weekday: .wednesday, time: AATime(hour: 8, minute: 10))

        XCTAssertEqual(AAClimate.changeStartingTimes([time1, time2]).bytes, bytes)
    }

    func testChangeTemperatures() {
        let bytes: [UInt8] = [
            0x00, 0x24, // MSB, LSB Message Identifier for Climate
            0x17,       // Message Type for Set Temperature Settings

            0x01,       // Property Identifier for Driver temperature setting
            0x00, 0x07, // Property size is 7 bytes
            0x01,       // Data component identifier
            0x00, 0x04, // Data component size is 4 bytes
            0x41, 0xa4, 0x00, 0x00, // 20.5C

            0x02,       // Property Identifier for Passenger temperature setting
            0x00, 0x07, // Property size is 7 bytes
            0x01,       // Data component identifier
            0x00, 0x04, // Data component size is 4 bytes
            0x41, 0xa4, 0x00, 0x00, // 20.5C

            0x03,       // Property Identifier for Rear temperature setting
            0x00, 0x07, // Property size is 7 bytes
            0x01,       // Data component identifier
            0x00, 0x04, // Data component size is 4 bytes
            0x41, 0x98, 0x00, 0x00, // 19C
        ]

        XCTAssertEqual(AAClimate.changeTemperatures(driver: 20.5, passenger: 20.5, rear: 19.0).bytes, bytes)
    }

    func testGetState() {
        let bytes: [UInt8] = [
            0x00, 0x24, // MSB, LSB Message Identifier for Climate
            0x00        // Message Type for Get Climate State
        ]

        XCTAssertEqual(AAClimate.getClimateState.bytes, bytes)
    }

    func testStartStopDefogging() {
        let bytes: [UInt8] = [
            0x00, 0x24, // MSB, LSB Message Identifier for Climate
            0x14,       // Message Type for Start/Stop Defogging

            0x01,       // Property Identifier for Defogging state
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Data component size is 1 bytes
            0x01        // Start defogging
        ]

        XCTAssertEqual(AAClimate.startStopDefogging(.active).bytes, bytes)
    }

    func testStartStopDefrosting() {
        let bytes: [UInt8] = [
            0x00, 0x24, // MSB, LSB Message Identifier for Climate
            0x15,       // Message Type for Start/Stop Defrosting

            0x01,       // Property Identifier for Defrosting state
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Data component size is 1 bytes
            0x01        // Start
        ]

        XCTAssertEqual(AAClimate.startStopDefrosting(.active).bytes, bytes)
    }

    func testStartStopHVAC() {
        let bytes: [UInt8] = [
            0x00, 0x24, // MSB, LSB Message Identifier for Climate
            0x13,       // Message Type for Start/Stop HVAC

            0x01,       // Property Identifier for HVAC state
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Data component size is 1 bytes
            0x01        // Start HVAC
        ]

        XCTAssertEqual(AAClimate.startStopHVAC(.active).bytes, bytes)
    }

    func testStartStopIonising() {
        let bytes: [UInt8] = [
            0x00, 0x24, // MSB, LSB Message Identifier for Climate
            0x16,       // Message Type for Start/Stop Ionising

            0x01,       // Property Identifier for Ionising state
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Data component size is 1 bytes
            0x01        // Start
        ]

        XCTAssertEqual(AAClimate.startStopIonising(.active).bytes, bytes)
    }

    func testState() {
        let bytes: [UInt8] = [
            0x00, 0x24, // MSB, LSB Message Identifier for Climate
            0x01,       // Message Type for Climate State

            0x01,       // Property identifier for Inside temperature
            0x00, 0x07, // Property size is 7 bytes
            0x01,       // Data component identifier
            0x00, 0x04, // Data component size is 4 bytes
            0x41, 0x98, 0x00, 0x00, // Inside temperature 19C

            0x02,       // Property identifier for Outside temperature
            0x00, 0x07, // Property size is 7 bytes
            0x01,       // Data component identifier
            0x00, 0x04, // Data component size is 4 bytes
            0x41, 0x40, 0x00, 0x00, // Outside temperature 12C

            0x03,       // Property identifier for Driver temperature setting
            0x00, 0x07, // Property size is 7 bytes
            0x01,       // Data component identifier
            0x00, 0x04, // Data component size is 4 bytes
            0x41, 0xAC, 0x00, 0x00, // Driver temperature setting 21.5C

            0x04,       // Property identifier for Passenger temperature setting
            0x00, 0x07, // Property size is 7 bytes
            0x01,       // Data component identifier
            0x00, 0x04, // Data component size is 4 bytes
            0x41, 0xAC, 0x00, 0x00, // Passenger temperature setting 21.5C

            0x05,       // Property identifier for Hvac state
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Data component size is 1 bytes
            0x01,       // HVAC activated

            0x06,       // Property identifier for Defogging state
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Data component size is 1 bytes
            0x00,       // Defogging deactivated

            0x07,       // Property identifier for Defrosting state
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Data component size is 1 bytes
            0x00,       // Defrosting deactivated

            0x08,       // Property identifier for Ionising state
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Data component size is 1 bytes
            0x00,       // Ionising deactivated

            0x09,       // Property identifier for Defrosting temperature
            0x00, 0x07, // Property size is 7 bytes
            0x01,       // Data component identifier
            0x00, 0x04, // Data component size is 4 bytes
            0x41, 0xAC, 0x00, 0x00, // Defrosting temperature at 21.5C

            0x0B,       // Property identifier for Hvac weekday starting times
            0x00, 0x06, // Property size is 6 bytes
            0x01,       // Data component identifier
            0x00, 0x03, // Data component size is 3 bytes
            0x05,       // Auto-HVAC activated for Saturdays
            0x12,       // at 18h
            0x1E,       // 30min

            0x0B,       // Property identifier for Hvac weekday starting times
            0x00, 0x06, // Property size is 6 bytes
            0x01,       // Data component identifier
            0x00, 0x03, // Data component size is 3 bytes
            0x06,       // Auto-HVAC activated for Sundays
            0x12,       // at 18h
            0x1E,       // 30min

            0x0C,       // Property identifier for Rear temperature setting
            0x00, 0x07, // Property size is 7 bytes
            0x01,       // Data component identifier
            0x00, 0x04, // Data component size is 4 bytes
            0x41, 0xAC, 0x00, 0x00  // Rear temperature setting 21.5C
        ]

        guard let climate = AAAutoAPI.parseBinary(bytes) as? AAClimate else {
            return XCTFail("Parsed value is not AAClimate")
        }

        XCTAssertEqual(climate.insideTemperature?.value, 19.0)
        XCTAssertEqual(climate.outsideTemperature?.value, 12.0)
        XCTAssertEqual(climate.driverTemperature?.value, 21.5)
        XCTAssertEqual(climate.passengerTemperature?.value, 21.5)
        XCTAssertEqual(climate.hvacState?.value, .active)
        XCTAssertEqual(climate.defoggingState?.value, .inactive)
        XCTAssertEqual(climate.defrostingState?.value, .inactive)
        XCTAssertEqual(climate.ionisingState?.value, .inactive)
        XCTAssertEqual(climate.defrostingTemperature?.value, 21.5)
        XCTAssertEqual(climate.rearTemperature?.value, 21.5)

        // HVAC Weekday Starting Times
        XCTAssertEqual(climate.weekdaysStartingTimes?.count, 2)

        if let startingTime = climate.weekdaysStartingTimes?.first(where: { $0.value?.weekday == .saturday }) {
            XCTAssertEqual(startingTime.value?.time, AATime(hour: 18, minute: 30))
        }
        else {
            XCTFail("HVAC Weekday Starting Times doesn't contain Saturday")
        }

        if let startingTime = climate.weekdaysStartingTimes?.first(where: { $0.value?.weekday == .sunday }) {
            XCTAssertEqual(startingTime.value?.time, AATime(hour: 18, minute: 30))
        }
        else {
            XCTFail("HVAC Weekday Starting Times doesn't contain Sunday")
        }
    }
}
