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
//  ChassisSettingsTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 13/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import AutoAPI
import XCTest


class ChassisSettingsTests: XCTestCase {

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

        XCTAssertEqual(AAChassisSettings.getChassisSettings, bytes)
    }

    func testSetChassisPosition() {
        let bytes: [UInt8] = [
            0x00, 0x53, // MSB, LSB Message Identifier for Chassis Settings
            0x05,       // Message Type for Set Chassis Position

            0x32  // Set to +50mm
        ]

        XCTAssertEqual(AAChassisSettings.setChassisPosition(50), bytes)
    }

    func testSetDrivingMode() {
        let bytes: [UInt8] = [
            0x00, 0x53, // MSB, LSB Message Identifier for Chassis Settings
            0x02,       // Message Type for Set Driving Mode

            0x03  // Set mode to Sport+
        ]

        XCTAssertEqual(AAChassisSettings.setDrivingMode(.sportPlus), bytes)
    }

    func testSetSpringRate() {
        let bytes: [UInt8] = [
            0x00, 0x53, // MSB, LSB Message Identifier for Chassis Settings
            0x04,       // Message Type for Set Spring Rate

            0x01, // Spring rate for the rear axle
            0x19  // Set to 25N/mm
        ]

        XCTAssertEqual(AAChassisSettings.setSpringRate(.rear, 25), bytes)
    }

    func testStartStopSportChrono() {
        let bytes: [UInt8] = [
            0x00, 0x53, // MSB, LSB Message Identifier for Chassis Settings
            0x03,       // Message Type for Start/Stop Sport Chrono

            0x00  // Start Sport Chrono
        ]

        XCTAssertEqual(AAChassisSettings.startStopSportChrono(.start), bytes)
    }

    func testState() {
        let bytes: [UInt8] = [
            0x00, 0x53, // MSB, LSB Message Identifier for Chassis Settings
            0x01,       // Message Type for Chassis Settings

            0x01,       // Property Identifier for Driving Mode
            0x00, 0x01, // Property size 1 byte
            0x01,       // ECO driving mode

            0x02,       // Property Identifier for Sport Chrono
            0x00, 0x01, // Property size 1 byte
            0x01,       // Sport Chrono active

            0x03,       // Property Identifier for Spring rate
            0x00, 0x04, // Property size 4 bytes
            0x00,       // Front axle
            0x15,       // Spring rate is 21N/mm
            0x25,       // Maximum possible rate is 37N/mm
            0x15,       // Minimum possible rate is 21N/mm

            0x03,       // Property Identifier for Spring rate
            0x00, 0x04, // Property size 4 bytes
            0x01,       // Rear axle
            0x17,       // Spring rate is 23N/mm
            0x1F,       // Maximum possible rate is 31N/mm
            0x11,       // Minimum possible rate is 17N/mm

            0x04,       // Property Identifier for Chassis position
            0x00, 0x03, // Property size 3 bytes
            0x19,       // Position is +25mm
            0x37,       // Maximum possible position is +55mm
            0xE4        // Minimum possible position is -28mm
        ]

        guard let chassisSettings = AAAutoAPI.parseBinary(bytes) as? AAChassisSettings else {
            return XCTFail("Parsed value is not ChassisSettings")
        }

        XCTAssertEqual(chassisSettings.drivingMode, .eco)
        XCTAssertEqual(chassisSettings.isSportChroneActive, true)
        XCTAssertEqual(chassisSettings.springRates?.count, 2)

        // Front axle Spring rate
        if let frontAxleSpringRate = chassisSettings.springRates?.first(where: { $0.axle == .front }) {
            XCTAssertEqual(frontAxleSpringRate.maximum, 37)
            XCTAssertEqual(frontAxleSpringRate.minimum, 21)
            XCTAssertEqual(frontAxleSpringRate.rate, 21)
        }
        else {
            XCTFail("ChassisSettings doesn't contain Front Axle Spring Rate")
        }

        // Rear axle Spring rate
        if let rearAxleSpringRate = chassisSettings.springRates?.first(where: { $0.axle == .rear }) {
            XCTAssertEqual(rearAxleSpringRate.maximum, 31)
            XCTAssertEqual(rearAxleSpringRate.minimum, 17)
            XCTAssertEqual(rearAxleSpringRate.rate, 23)
        }
        else {
            XCTFail("ChassisSettings doesn't contain Rear Axle Spring Rate")
        }

        XCTAssertEqual(chassisSettings.chassisPosition?.maximum, 55)
        XCTAssertEqual(chassisSettings.chassisPosition?.minimum, -28)
        XCTAssertEqual(chassisSettings.chassisPosition?.position, 25)
    }
}
