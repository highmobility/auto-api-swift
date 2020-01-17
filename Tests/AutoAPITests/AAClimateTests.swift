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
//  AAClimateTest.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import AutoAPI
import XCTest


class AAClimateTest: XCTestCase {

    // MARK: State Properties

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

    func testDriverTemperatureSetting() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x24, 0x01, 0x03, 0x00, 0x07, 0x01, 0x00, 0x04, 0x41, 0xac, 0x00, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAClimate else {
            return XCTFail("Could not parse bytes as AAClimate")
        }
    
        XCTAssertEqual(capability.driverTemperatureSetting?.value, 21.5)
    }

    func testOutsideTemperature() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x24, 0x01, 0x02, 0x00, 0x07, 0x01, 0x00, 0x04, 0x41, 0x40, 0x00, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAClimate else {
            return XCTFail("Could not parse bytes as AAClimate")
        }
    
        XCTAssertEqual(capability.outsideTemperature?.value, 12.0)
    }

    func testDefrostingTemperatureSetting() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x24, 0x01, 0x09, 0x00, 0x07, 0x01, 0x00, 0x04, 0x41, 0xac, 0x00, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAClimate else {
            return XCTFail("Could not parse bytes as AAClimate")
        }
    
        XCTAssertEqual(capability.defrostingTemperatureSetting?.value, 21.5)
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

    func testIonisingState() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x24, 0x01, 0x08, 0x00, 0x04, 0x01, 0x00, 0x01, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAClimate else {
            return XCTFail("Could not parse bytes as AAClimate")
        }
    
        XCTAssertEqual(capability.ionisingState?.value, .inactive)
    }

    func testHvacState() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x24, 0x01, 0x05, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAClimate else {
            return XCTFail("Could not parse bytes as AAClimate")
        }
    
        XCTAssertEqual(capability.hvacState?.value, .active)
    }

    func testPassengerTemperatureSetting() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x24, 0x01, 0x04, 0x00, 0x07, 0x01, 0x00, 0x04, 0x41, 0xac, 0x00, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAClimate else {
            return XCTFail("Could not parse bytes as AAClimate")
        }
    
        XCTAssertEqual(capability.passengerTemperatureSetting?.value, 21.5)
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