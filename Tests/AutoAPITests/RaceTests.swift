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
//  RaceTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 07/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import AutoAPI
import XCTest


class RaceTests: XCTestCase {

    static var allTests = [("testGetState", testGetState),
                           ("testState", testState)]


    // MARK: XCTestCase

    func testGetState() {
        let bytes: [UInt8] = [
            0x00, 0x57, // MSB, LSB Message Identifier for Race
            0x00        // Message Type for Get Race State
        ]

        XCTAssertEqual(Race.getRaceState, bytes)
    }

    func testState() {
        let bytes: [UInt8] = [
            0x00, 0x57, // MSB, LSB Message Identifier for Race
            0x01,       // Message Type for Race State

            0x01,                   // Property Identifier for Acceleration
            0x00, 0x05,             // Property size 5 bytes
            0x00,                   // Longitudinal acceleration
            0x3f, 0x5d, 0x2f, 0x1b, // 0.864 g

            0x01,                   // Property Identifier for Acceleration
            0x00, 0x05,             // Property size 5 bytes
            0x01,                   // Lateral acceleration
            0xbf, 0x40, 0xc4, 0x9c, // -0.753 g

            0x02,                   // Property Identifier for Understeering
            0x00, 0x01,             // Property size 1 byte
            0x13,                   // 19%

            0x03,                   // Property Identifier for Oversteering
            0x00, 0x01,             // Property size 1 byte
            0x00,                   // 0%

            0x04,                   // Property Identifier for Gas pedal position
            0x00, 0x01,             // Property size 1 byte
            0x62,                   // 98%

            0x05,                   // Property Identifier for Steering angle
            0x00, 0x01,             // Property size 1 byte
            0xE2,                    // -30° (turning to the right)

            0x06,                   // Property Identifier for Brake pressure
            0x00, 0x04,             // Property size 4 bytes
            0x41, 0x38, 0xf5, 0xc3, // 11.56 bar

            0x07,                   // Property Identifier for Yaw rate
            0x00, 0x04,             // Property size 4 bytes
            0x40, 0xd5, 0x1e, 0xb8, // 6.66 °/s

            0x08,                   // Property Identifier for Rear suspension steering
            0x00, 0x01,             // Property size 1 byte
            0x03,                   // Steering is +3°

            0x09,                   // Property Identifier for ESP intervention
            0x00, 0x01,             // Property size 1 byte
            0x01,                   // ESP intervention active

            0x0A,                   // Property Identifier for Brake Torque Vectoring
            0x00, 0x02,             // Property size 2 bytes
            0x01,                   // Rear axle
            0x01,                   // Active

            0x0B,                   // Property Identifier for Gear mode
            0x00, 0x01,             // Property size 1 byte
            0x04,                   // Gear in mode "Drive"

            0x0C,                   // Property Identifier for Selected gear
            0x00, 0x01,             // Property size 1 byte
            0x04,                   // 4th gear selected

            0x0D,       // Property identifier for Brake pedal position
            0x00, 0x01, // Property size is 1 bytes
            0x00,       // 0%, no brakes

            0x0E,       // Property identifier for Brake pedal switch
            0x00, 0x01, // Property size is 1 bytes
            0x01,       // Brake pedal switch active, brake lights active

            0x0F,       // Property identifier for Clutch pedal switch
            0x00, 0x01, // Property size is 1 bytes
            0x01,       // Clutch pedal switch active, clutch fully depressed

            0x10,       // Property identifier for Accelerator pedal idle switch
            0x00, 0x01, // Property size is 1 bytes
            0x01,       // Accelerator pedal idle switch active, pedal fully released

            0x11,       // Property identifier for Accelerator pedal kickdown switch
            0x00, 0x01, // Property size is 1 bytes
            0x01        // Accelerator pedal switch active, pedal fully depressed
        ]

        guard let race = AutoAPI.parseBinary(bytes) as? Race else {
            return XCTFail("Parsed value is not Race")
        }

        XCTAssertEqual(race.understeering, 19)
        XCTAssertEqual(race.oversteering, 0)
        XCTAssertEqual(race.gasPedalPosition, 98)
        XCTAssertEqual(race.steeringAngle, -30)
        XCTAssertEqual(race.brakePressure, 11.56)
        XCTAssertEqual(race.yawRate, 6.66)
        XCTAssertEqual(race.rearSuspensionSteering, 3)
        XCTAssertEqual(race.isESPActive, true)
        XCTAssertEqual(race.isBrakePedalSwitchActive, true)
        XCTAssertEqual(race.isClutchPedalSwitchActive, true)
        XCTAssertEqual(race.isAcceleratorPedalIdleSwitchActive, true)
        XCTAssertEqual(race.isAcceleratorPedalKickdownSwitchActive, true)

        // Accelerations
        let accelerations = race.accelerations

        XCTAssertEqual(accelerations?.count, 2)

        if let longitudinalAcceleration = accelerations?.first(where: { $0.type == .longitudinal }) {
            XCTAssertEqual(longitudinalAcceleration.value, 0.864)
        }
        else {
            XCTFail("Accelerations doesn't contain Longitudinal Acceleration")
        }

        if let lateralAcceleration = accelerations?.first(where: { $0.type == .lateral }) {
            XCTAssertEqual(lateralAcceleration.value, -0.753)
        }
        else {
            XCTFail("Accelerations doesn't contain Lateral Acceleration")
        }

        // Brake Torque Vectorings
        XCTAssertEqual(race.brakeTorqueVectorings?.count, 1)

        if let btv = race.brakeTorqueVectorings?.first(where: { $0.axle == .rear }) {
            XCTAssertTrue(btv.isActive)
        }
        else {
            XCTFail("BrakeTorqueVectorings doesn't contain Rear Axle")
        }

        XCTAssertEqual(race.gearMode, .drive)
        XCTAssertEqual(race.selectedGear, 4)
        XCTAssertEqual(race.brakePedalPosition, 0)
    }
}
