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
//  AAChargingTest.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import AutoAPI
import XCTest


class AAChargingTest: XCTestCase {

    // MARK: State Properties

    func testEstimatedRange() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x23, 0x01, 0x02, 0x00, 0x05, 0x01, 0x00, 0x02, 0x01, 0xb0]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AACharging else {
            return XCTFail("Could not parse bytes as AACharging")
        }
    
        XCTAssertEqual(capability.estimatedRange?.value, 432)
    }

    func testTimeToCompleteCharge() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x23, 0x01, 0x09, 0x00, 0x04, 0x01, 0x00, 0x01, 0x3c]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AACharging else {
            return XCTFail("Could not parse bytes as AACharging")
        }
    
        XCTAssertEqual(capability.timeToCompleteCharge?.value, 60)
    }

    func testPlugType() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x23, 0x01, 0x0f, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AACharging else {
            return XCTFail("Could not parse bytes as AACharging")
        }
    
        XCTAssertEqual(capability.plugType?.value, .type2)
    }

    func testChargingWindowChosen() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x23, 0x01, 0x10, 0x00, 0x04, 0x01, 0x00, 0x01, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AACharging else {
            return XCTFail("Could not parse bytes as AACharging")
        }
    
        XCTAssertEqual(capability.chargingWindowChosen?.value, .notChosen)
    }

    func testDepartureTimes() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x23, 0x01, 0x11, 0x00, 0x06, 0x01, 0x00, 0x03, 0x01, 0x10, 0x20, 0x11, 0x00, 0x06, 0x01, 0x00, 0x03, 0x00, 0x0b, 0x33]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AACharging else {
            return XCTFail("Could not parse bytes as AACharging")
        }
    
        guard let departureTimes = capability.departureTimes?.compactMap({ $0.value }) else {
            return XCTFail("Could not extract .departureTimes values")
        }
    
        XCTAssertTrue(departureTimes.contains { $0 == AADepartureTime(state: .active, time: AATime(hour: 16, minute: 32)) })
        XCTAssertTrue(departureTimes.contains { $0 == AADepartureTime(state: .inactive, time: AATime(hour: 11, minute: 51)) })
    }

    func testMaxChargingCurrent() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x23, 0x01, 0x0e, 0x00, 0x07, 0x01, 0x00, 0x04, 0x41, 0xc8, 0x00, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AACharging else {
            return XCTFail("Could not parse bytes as AACharging")
        }
    
        XCTAssertEqual(capability.maxChargingCurrent?.value, 25.0)
    }

    func testChargeLimit() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x23, 0x01, 0x08, 0x00, 0x0b, 0x01, 0x00, 0x08, 0x3f, 0xec, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcd]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AACharging else {
            return XCTFail("Could not parse bytes as AACharging")
        }
    
        XCTAssertEqual(capability.chargeLimit?.value, 0.9)
    }

    func testReductionTimes() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x23, 0x01, 0x13, 0x00, 0x06, 0x01, 0x00, 0x03, 0x00, 0x11, 0x21, 0x13, 0x00, 0x06, 0x01, 0x00, 0x03, 0x01, 0x0c, 0x34]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AACharging else {
            return XCTFail("Could not parse bytes as AACharging")
        }
    
        guard let reductionTimes = capability.reductionTimes?.compactMap({ $0.value }) else {
            return XCTFail("Could not extract .reductionTimes values")
        }
    
        XCTAssertTrue(reductionTimes.contains { $0 == AAReductionTime(startStop: .start, time: AATime(hour: 17, minute: 33)) })
        XCTAssertTrue(reductionTimes.contains { $0 == AAReductionTime(startStop: .stop, time: AATime(hour: 12, minute: 52)) })
    }

    func testBatteryCurrentAC() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x23, 0x01, 0x04, 0x00, 0x07, 0x01, 0x00, 0x04, 0xbf, 0x19, 0x99, 0x9a]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AACharging else {
            return XCTFail("Could not parse bytes as AACharging")
        }
    
        XCTAssertEqual(capability.batteryCurrentAC?.value, -0.6)
    }

    func testBatteryTemperature() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x23, 0x01, 0x14, 0x00, 0x07, 0x01, 0x00, 0x04, 0x42, 0x19, 0x99, 0x9a]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AACharging else {
            return XCTFail("Could not parse bytes as AACharging")
        }
    
        XCTAssertEqual(capability.batteryTemperature?.value, 38.4)
    }

    func testBatteryLevel() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x23, 0x01, 0x03, 0x00, 0x0b, 0x01, 0x00, 0x08, 0x3f, 0xe0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AACharging else {
            return XCTFail("Could not parse bytes as AACharging")
        }
    
        XCTAssertEqual(capability.batteryLevel?.value, 0.5)
    }

    func testChargerVoltageAC() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x23, 0x01, 0x06, 0x00, 0x07, 0x01, 0x00, 0x04, 0x43, 0xc8, 0x00, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AACharging else {
            return XCTFail("Could not parse bytes as AACharging")
        }
    
        XCTAssertEqual(capability.chargerVoltageAC?.value, 400)
    }

    func testStatus() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x23, 0x01, 0x17, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AACharging else {
            return XCTFail("Could not parse bytes as AACharging")
        }
    
        XCTAssertEqual(capability.status?.value, .charging)
    }

    func testBatteryCurrentDC() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x23, 0x01, 0x05, 0x00, 0x07, 0x01, 0x00, 0x04, 0xbf, 0x19, 0x99, 0x9a]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AACharging else {
            return XCTFail("Could not parse bytes as AACharging")
        }
    
        XCTAssertEqual(capability.batteryCurrentDC?.value, -0.6)
    }

    func testTimers() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x23, 0x01, 0x15, 0x00, 0x0c, 0x01, 0x00, 0x09, 0x00, 0x00, 0x00, 0x01, 0x59, 0x89, 0x38, 0xe7, 0x88, 0x15, 0x00, 0x0c, 0x01, 0x00, 0x09, 0x01, 0x00, 0x00, 0x01, 0x59, 0x89, 0x3c, 0x91, 0x08, 0x15, 0x00, 0x0c, 0x01, 0x00, 0x09, 0x02, 0x00, 0x00, 0x01, 0x59, 0x89, 0x3c, 0x91, 0x08]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AACharging else {
            return XCTFail("Could not parse bytes as AACharging")
        }
    
        guard let timers = capability.timers?.compactMap({ $0.value }) else {
            return XCTFail("Could not extract .timers values")
        }
    
        XCTAssertTrue(timers.contains { $0 == AATimer(timerType: .preferredStartTime, date: DateFormatter.hmFormatter.date(from: "2017-01-10T16:32:05.000Z")!) })
        XCTAssertTrue(timers.contains { $0 == AATimer(timerType: .preferredEndTime, date: DateFormatter.hmFormatter.date(from: "2017-01-10T16:36:05.000Z")!) })
        XCTAssertTrue(timers.contains { $0 == AATimer(timerType: .departureDate, date: DateFormatter.hmFormatter.date(from: "2017-01-10T16:36:05.000Z")!) })
    }

    func testPluggedIn() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x23, 0x01, 0x16, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AACharging else {
            return XCTFail("Could not parse bytes as AACharging")
        }
    
        XCTAssertEqual(capability.pluggedIn?.value, .pluggedIn)
    }

    func testChargerVoltageDC() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x23, 0x01, 0x07, 0x00, 0x07, 0x01, 0x00, 0x04, 0x43, 0xc8, 0x00, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AACharging else {
            return XCTFail("Could not parse bytes as AACharging")
        }
    
        XCTAssertEqual(capability.chargerVoltageDC?.value, 400)
    }

    func testChargingRateKW() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x23, 0x01, 0x0a, 0x00, 0x07, 0x01, 0x00, 0x04, 0x40, 0x60, 0x00, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AACharging else {
            return XCTFail("Could not parse bytes as AACharging")
        }
    
        XCTAssertEqual(capability.chargingRateKW?.value, 3.5)
    }

    func testChargePortState() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x23, 0x01, 0x0b, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AACharging else {
            return XCTFail("Could not parse bytes as AACharging")
        }
    
        XCTAssertEqual(capability.chargePortState?.value, .open)
    }

    func testChargeMode() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x23, 0x01, 0x0c, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AACharging else {
            return XCTFail("Could not parse bytes as AACharging")
        }
    
        XCTAssertEqual(capability.chargeMode?.value, .timerBased)
    }

    
    // MARK: Getters

    func testGetChargingState() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x23, 0x00]
    
        XCTAssertEqual(bytes, AACharging.getChargingState())
    }
    
    func testGetChargingProperties() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x23, 0x00, 0x17]
        let getterBytes = AACharging.getChargingProperties(propertyIDs: .status)
    
        XCTAssertEqual(bytes, getterBytes)
    }

    
    // MARK: Setters

    func testStartStopCharging() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x23, 0x01] + [0x17, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
        let setterBytes = AACharging.startStopCharging(status: .charging)
    
        XCTAssertEqual(bytes, setterBytes)
    }

    func testSetChargeLimit() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x23, 0x01] + [0x08, 0x00, 0x0b, 0x01, 0x00, 0x08, 0x3f, 0xec, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcd]
        let setterBytes = AACharging.setChargeLimit(chargeLimit: 0.9)
    
        XCTAssertEqual(bytes, setterBytes)
    }

    func testOpenCloseChargingPort() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x23, 0x01] + [0x0b, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
        let setterBytes = AACharging.openCloseChargingPort(chargePortState: .open)
    
        XCTAssertEqual(bytes, setterBytes)
    }

    func testSetChargeMode() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x23, 0x01] + [0x0c, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
        let setterBytes = AACharging.setChargeMode(chargeMode: .timerBased)
    
        XCTAssertEqual(bytes, setterBytes)
    }

    func testSetChargingTimers() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x23, 0x01] + [0x15, 0x00, 0x0c, 0x01, 0x00, 0x09, 0x00, 0x00, 0x00, 0x01, 0x59, 0x89, 0x38, 0xe7, 0x88]
        let setterBytes = AACharging.setChargingTimers(timers: [AATimer(timerType: .preferredStartTime, date: DateFormatter.hmFormatter.date(from: "2017-01-10T16:32:05.000Z")!)])
    
        XCTAssertEqual(bytes, setterBytes)
    }

    func testSetReductionOfChargingCurrentTimes() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x23, 0x01] + [0x13, 0x00, 0x06, 0x01, 0x00, 0x03, 0x00, 0x11, 0x21]
        let setterBytes = AACharging.setReductionOfChargingCurrentTimes(reductionTimes: [AAReductionTime(startStop: .start, time: AATime(hour: 17, minute: 33))])
    
        XCTAssertEqual(bytes, setterBytes)
    }
}