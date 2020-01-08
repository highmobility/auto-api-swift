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
//  AAClimateTest.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import AutoAPI
import XCTest


class AAClimateTest: XCTestCase {

    // MARK: State Properties

    func testDriverTemperatureSetting() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x24, 0x01, 0x03, 0x00, 0x07, 0x01, 0x00, 0x04, 0x41, 0xac, 0x00, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAClimate else {
            return XCTFail("Could not parse bytes as AAClimate")
        }
    
        XCTAssertEqual(capability.driverTemperatureSetting?.value, 21.5)
    }

    func testPassengerTemperatureSetting() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x24, 0x01, 0x04, 0x00, 0x07, 0x01, 0x00, 0x04, 0x41, 0xac, 0x00, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAClimate else {
            return XCTFail("Could not parse bytes as AAClimate")
        }
    
        XCTAssertEqual(capability.passengerTemperatureSetting?.value, 21.5)
    }

    func testHvacState() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x24, 0x01, 0x05, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAClimate else {
            return XCTFail("Could not parse bytes as AAClimate")
        }
    
        XCTAssertEqual(capability.hvacState?.value, .active)
    }

    func testIonisingState() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x24, 0x01, 0x08, 0x00, 0x04, 0x01, 0x00, 0x01, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAClimate else {
            return XCTFail("Could not parse bytes as AAClimate")
        }
    
        XCTAssertEqual(capability.ionisingState?.value, .inactive)
    }

    func testHvacWeekdayStartingTimes() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x24, 0x01, 0x0b, 0x00, 0x06, 0x01, 0x00, 0x03, 0x00, 0x10, 0x00, 0x0b, 0x00, 0x06, 0x01, 0x00, 0x03, 0x01, 0x10, 0x00, 0x0b, 0x00, 0x06, 0x01, 0x00, 0x03, 0x02, 0x10, 0x00, 0x0b, 0x00, 0x06, 0x01, 0x00, 0x03, 0x03, 0x10, 0x00, 0x0b, 0x00, 0x06, 0x01, 0x00, 0x03, 0x04, 0x10, 0x00, 0x0b, 0x00, 0x06, 0x01, 0x00, 0x03, 0x05, 0x12, 0x1e, 0x0b, 0x00, 0x06, 0x01, 0x00, 0x03, 0x06, 0x13, 0x1f, 0x0b, 0x00, 0x06, 0x01, 0x00, 0x03, 0x07, 0x10, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAClimate else {
            return XCTFail("Could not parse bytes as AAClimate")
        }
    
        guard let hvacWeekdayStartingTimes = capability.hvacWeekdayStartingTimes?.compactMap({ $0.value }) else {
            return XCTFail("Could not extract .hvacWeekdayStartingTimes values")
        }
    
        XCTAssertTrue(hvacWeekdayStartingTimes.contains { $0 == AAHVACWeekdayStartingTime(weekday: .monday, time: AATime(hour: 16, minute: 00)) })
        XCTAssertTrue(hvacWeekdayStartingTimes.contains { $0 == AAHVACWeekdayStartingTime(weekday: .tuesday, time: AATime(hour: 16, minute: 00)) })
        XCTAssertTrue(hvacWeekdayStartingTimes.contains { $0 == AAHVACWeekdayStartingTime(weekday: .wednesday, time: AATime(hour: 16, minute: 00)) })
        XCTAssertTrue(hvacWeekdayStartingTimes.contains { $0 == AAHVACWeekdayStartingTime(weekday: .thursday, time: AATime(hour: 16, minute: 00)) })
        XCTAssertTrue(hvacWeekdayStartingTimes.contains { $0 == AAHVACWeekdayStartingTime(weekday: .friday, time: AATime(hour: 16, minute: 00)) })
        XCTAssertTrue(hvacWeekdayStartingTimes.contains { $0 == AAHVACWeekdayStartingTime(weekday: .saturday, time: AATime(hour: 18, minute: 30)) })
        XCTAssertTrue(hvacWeekdayStartingTimes.contains { $0 == AAHVACWeekdayStartingTime(weekday: .sunday, time: AATime(hour: 19, minute: 31)) })
        XCTAssertTrue(hvacWeekdayStartingTimes.contains { $0 == AAHVACWeekdayStartingTime(weekday: .automatic, time: AATime(hour: 16, minute: 00)) })
    }

    func testInsideTemperature() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x24, 0x01, 0x01, 0x00, 0x07, 0x01, 0x00, 0x04, 0x41, 0x98, 0x00, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAClimate else {
            return XCTFail("Could not parse bytes as AAClimate")
        }
    
        XCTAssertEqual(capability.insideTemperature?.value, 19.0)
    }

    func testDefoggingState() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x24, 0x01, 0x06, 0x00, 0x04, 0x01, 0x00, 0x01, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAClimate else {
            return XCTFail("Could not parse bytes as AAClimate")
        }
    
        XCTAssertEqual(capability.defoggingState?.value, .inactive)
    }

    func testDefrostingTemperatureSetting() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x24, 0x01, 0x09, 0x00, 0x07, 0x01, 0x00, 0x04, 0x41, 0xac, 0x00, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAClimate else {
            return XCTFail("Could not parse bytes as AAClimate")
        }
    
        XCTAssertEqual(capability.defrostingTemperatureSetting?.value, 21.5)
    }

    func testDefrostingState() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x24, 0x01, 0x07, 0x00, 0x04, 0x01, 0x00, 0x01, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAClimate else {
            return XCTFail("Could not parse bytes as AAClimate")
        }
    
        XCTAssertEqual(capability.defrostingState?.value, .inactive)
    }

    func testRearTemperatureSetting() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x24, 0x01, 0x0c, 0x00, 0x07, 0x01, 0x00, 0x04, 0x41, 0xac, 0x00, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAClimate else {
            return XCTFail("Could not parse bytes as AAClimate")
        }
    
        XCTAssertEqual(capability.rearTemperatureSetting?.value, 21.5)
    }

    func testOutsideTemperature() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x24, 0x01, 0x02, 0x00, 0x07, 0x01, 0x00, 0x04, 0x41, 0x40, 0x00, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAClimate else {
            return XCTFail("Could not parse bytes as AAClimate")
        }
    
        XCTAssertEqual(capability.outsideTemperature?.value, 12.0)
    }

    
    // MARK: Getters

    func testGetClimateState() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x24, 0x00]
    
        XCTAssertEqual(bytes, AAClimate.getClimateState())
    }
    
    func testGetClimateProperties() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x24, 0x00, 0x0c]
        let getterBytes = AAClimate.getClimateProperties(propertyIDs: .rearTemperatureSetting)
    
        XCTAssertEqual(bytes, getterBytes)
    }

    
    // MARK: Setters

    func testChangeStartingTimes() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x24, 0x01] + [0x0b, 0x00, 0x06, 0x01, 0x00, 0x03, 0x00, 0x10, 0x00]
        let setterBytes = AAClimate.changeStartingTimes(hvacWeekdayStartingTimes: [AAHVACWeekdayStartingTime(weekday: .monday, time: AATime(hour: 16, minute: 00))])
    
        XCTAssertEqual(bytes, setterBytes)
    }

    func testStartStopHvac() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x24, 0x01] + [0x05, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
        let setterBytes = AAClimate.startStopHvac(hvacState: .active)
    
        XCTAssertEqual(bytes, setterBytes)
    }

    func testStartStopDefogging() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x24, 0x01] + [0x06, 0x00, 0x04, 0x01, 0x00, 0x01, 0x00]
        let setterBytes = AAClimate.startStopDefogging(defoggingState: .inactive)
    
        XCTAssertEqual(bytes, setterBytes)
    }

    func testStartStopDefrosting() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x24, 0x01] + [0x07, 0x00, 0x04, 0x01, 0x00, 0x01, 0x00]
        let setterBytes = AAClimate.startStopDefrosting(defrostingState: .inactive)
    
        XCTAssertEqual(bytes, setterBytes)
    }

    func testStartStopIonising() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x24, 0x01] + [0x08, 0x00, 0x04, 0x01, 0x00, 0x01, 0x00]
        let setterBytes = AAClimate.startStopIonising(ionisingState: .inactive)
    
        XCTAssertEqual(bytes, setterBytes)
    }

    func testSetTemperatureSettings() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x24, 0x01] + [0x03, 0x00, 0x07, 0x01, 0x00, 0x04, 0x41, 0xac, 0x00, 0x00, 0x04, 0x00, 0x07, 0x01, 0x00, 0x04, 0x41, 0xac, 0x00, 0x00, 0x0c, 0x00, 0x07, 0x01, 0x00, 0x04, 0x41, 0xac, 0x00, 0x00]
        let setterBytes = AAClimate.setTemperatureSettings(driverTemperatureSetting: 21.5, passengerTemperatureSetting: 21.5, rearTemperatureSetting: 21.5)
    
        XCTAssertEqual(bytes, setterBytes)
    }
}