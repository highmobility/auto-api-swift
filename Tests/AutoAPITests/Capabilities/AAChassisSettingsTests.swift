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
//  AAChassisSettingsTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 13/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import AutoAPI
import XCTest


class AAChassisSettingsTests: XCTestCase {

    static var allTests = [("testGetState", testGetState),
                           ("testSetChassisPosition", testSetChassisPosition),
                           ("testSetDrivingMode", testSetDrivingMode),
                           ("testSetSpringRate", testSetSpringRate),
                           ("testStartStopSportChrono", testStartStopSportChrono),
                           ("testState", testState)]


    // MARK: XCTestCase

    func testGetState() {
        let bytes: [UInt8] = [
            0x00, 0x53, // MSB, LSB Message Identifier for Chassis Settings
            0x00        // Message Type for Get Chassis Settings
        ]

        XCTAssertEqual(AAChassisSettings.getChassisSettings.bytes, bytes)
    }

    func testSetChassisPosition() {
        let bytes: [UInt8] = [
            0x00, 0x53, // MSB, LSB Message Identifier for Chassis Settings
            0x15,       // Message Type for Set Chassis Position

            0x01,       // Property Identifier for Chassis Position
            0x00, 0x04, // Property size is 4 byte
            0x01,       // Data component
            0x00, 0x01, // Data component size is 1 byte
            0x32        // Set to +50mm
        ]

        XCTAssertEqual(AAChassisSettings.setChassisPosition(50).bytes, bytes)
    }

    func testSetDrivingMode() {
        let bytes: [UInt8] = [
            0x00, 0x53, // MSB, LSB Message Identifier for Chassis Settings
            0x12,       // Message Type for Set Driving Mode

            0x01,       // Property Identifier for Driving mode
            0x00, 0x04, // Property size is 4 byte
            0x01,       // Data component
            0x00, 0x01, // Data component size is 1 byte
            0x03        // Set mode to Sport+
        ]

        XCTAssertEqual(AAChassisSettings.setDrivingMode(.sportPlus).bytes, bytes)
    }

    func testSetSpringRate() {
        let bytes: [UInt8] = [
            0x00, 0x53, // MSB, LSB Message Identifier for Chassis Settings
            0x14,       // Message Type for Set Spring Rates

            0x01,       // Property Identifier for Spring rates
            0x00, 0x05, // Property size is 5 byte
            0x01,       // Data component
            0x00, 0x02, // Data component size is 2 byte
            0x01,       // Spring rate for the rear axle
            0x19        // Set to 25N/mm
        ]

        let springRate = AASpringRateValue(axle: .rear, value: 25)

        XCTAssertEqual(AAChassisSettings.setSpringRates([springRate]).bytes, bytes)
    }

    func testStartStopSportChrono() {
        let bytes: [UInt8] = [
            0x00, 0x53, // MSB, LSB Message Identifier for Chassis Settings
            0x13,       // Message Type for Start/Stop Sport Chrono

            0x01,       // Property Identifier for Sport chrono
            0x00, 0x04, // Property size is 4 byte
            0x01,       // Data component
            0x00, 0x01, // Data component size is 1 byte
            0x00        // Start Sport Chrono
        ]

        XCTAssertEqual(AAChassisSettings.startStopSportChrono(.start).bytes, bytes)
    }

    func testState() {
        let bytes: [UInt8] = [
            0x00, 0x53, // MSB, LSB Message Identifier for Chassis Settings
            0x01,       // Message Type for Chassis Settings

            0x01,       // Property identifier for Driving mode
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Data component size is 1 bytes
            0x01,       // ECO driving mode

            0x02,       // Property identifier for Sport chrono
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Data component size is 1 bytes
            0x01,       // Sport Chrono active

            0x05,       // Property identifier for Current spring rates
            0x00, 0x05, // Property size is 5 bytes
            0x01,       // Data component identifier
            0x00, 0x02, // Data component size is 2 bytes
            0x00,       // Front axle
            0x15,       // Spring rate is 21N/mm

            0x05,       // Property identifier for Current spring rates
            0x00, 0x05, // Property size is 5 bytes
            0x01,       // Data component identifier
            0x00, 0x02, // Data component size is 2 bytes
            0x01,       // Rear axle
            0x17,       // Spring rate is 23N/mm

            0x06,       // Property identifier for Maximum spring rates
            0x00, 0x05, // Property size is 5 bytes
            0x01,       // Data component identifier
            0x00, 0x02, // Data component size is 2 bytes
            0x00,       // Front axle
            0x25,       // Maximum spring rate is 37N/mm

            0x06,       // Property identifier for Maximum spring rates
            0x00, 0x05, // Property size is 5 bytes
            0x01,       // Data component identifier
            0x00, 0x02, // Data component size is 2 bytes
            0x01,       // Rear axle
            0x27,       // Maximum spring rate is 39N/mm

            0x07,       // Property identifier for Minimum spring rates
            0x00, 0x05, // Property size is 5 bytes
            0x01,       // Data component identifier
            0x00, 0x02, // Data component size is 2 bytes
            0x00,       // Front axle
            0x10,       // Minimum spring rate is 16N/mm

            0x07,       // Property identifier for Minimum spring rates
            0x00, 0x05, // Property size is 5 bytes
            0x01,       // Data component identifier
            0x00, 0x02, // Data component size is 2 bytes
            0x01,       // Rear axle
            0x12,       // Minimum spring rate is 18N/mm

            0x08,       // Property identifier for Current chassis position
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Data component size is 1 bytes
            0x19,       // Position is +25mm

            0x09,       // Property identifier for Maximum chassis position
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Data component size is 1 bytes
            0x37,       // Maximum possible position is +55mm

            0x0A,       // Property identifier for Minimum chassis position
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Data component size is 1 bytes
            0xE4,       // Minimum possible position is -28mm
        ]

        guard let chassisSettings = AAAutoAPI.parseBinary(bytes) as? AAChassisSettings else {
            return XCTFail("Parsed value is not AAChassisSettings")
        }

        XCTAssertEqual(chassisSettings.drivingMode?.value, .eco)
        XCTAssertEqual(chassisSettings.sportChronoState?.value, .active)
        XCTAssertEqual(chassisSettings.currentChassisPosition?.value, 25)
        XCTAssertEqual(chassisSettings.maximumChassisPosition?.value, 55)
        XCTAssertEqual(chassisSettings.minimumChassisPosition?.value, -28)

        // Current Spring Rates
        XCTAssertEqual(chassisSettings.currentSpringRates?.count, 2)

        if let springRate = chassisSettings.currentSpringRates?.first(where: { $0.value?.axle == .front }) {
            XCTAssertEqual(springRate.value?.value, 21)
        }
        else {
            XCTFail("Current Spring Rates doesn't contain Front Axle Spring Rate")
        }

        if let springRate = chassisSettings.currentSpringRates?.first(where: { $0.value?.axle == .rear }) {
            XCTAssertEqual(springRate.value?.value, 23)
        }
        else {
            XCTFail("Current Spring Rates doesn't contain Rear Axle Spring Rate")
        }

        // Maximum Spring Rates
        XCTAssertEqual(chassisSettings.maximumSpringRates?.count, 2)

        if let springRate = chassisSettings.maximumSpringRates?.first(where: { $0.value?.axle == .front }) {
            XCTAssertEqual(springRate.value?.value, 37)
        }
        else {
            XCTFail("Maximum Spring Rates doesn't contain Front Axle Spring Rate")
        }

        if let springRate = chassisSettings.maximumSpringRates?.first(where: { $0.value?.axle == .rear }) {
            XCTAssertEqual(springRate.value?.value, 39)
        }
        else {
            XCTFail("Maximum Spring Rates doesn't contain Rear Axle Spring Rate")
        }

        // Minimum Spring Rates

        if let springRate = chassisSettings.minimumSpringRates?.first(where: { $0.value?.axle == .front }) {
            XCTAssertEqual(springRate.value?.value, 16)
        }
        else {
            XCTFail("Minimum Spring Rates doesn't contain Front Axle Spring Rate")
        }

        if let springRate = chassisSettings.minimumSpringRates?.first(where: { $0.value?.axle == .rear }) {
            XCTAssertEqual(springRate.value?.value, 18)
        }
        else {
            XCTFail("Minimum Spring Rates doesn't contain Rear Axle Spring Rate")
        }
    }
}
