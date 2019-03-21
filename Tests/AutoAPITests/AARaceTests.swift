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
//  AARaceTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 07/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import AutoAPI
import XCTest


class AARaceTests: XCTestCase {

    static var allTests = [("testGetState", testGetState),
                           ("testState", testState)]


    // MARK: XCTestCase

    func testGetState() {
        let bytes: [UInt8] = [
            0x00, 0x57, // MSB, LSB Message Identifier for Race
            0x00        // Message Type for Get Race State
        ]

        XCTAssertEqual(AARace.getRaceState.bytes, bytes)
    }

    func testState() {
        let bytes: [UInt8] = [
            0x00, 0x57, // MSB, LSB Message Identifier for Race
            0x01,       // Message Type for Race State

            0x01,       // Property identifier for Accelerations
            0x00, 0x08, // Property size is 8 bytes
            0x01,       // Data component identifier
            0x00, 0x05, // Data component size is 5 bytes
            0x00,                   // Longitudinal acceleration
            0x3F, 0x5D, 0x2F, 0x1B, // 0.864 g

            0x01,       // Property identifier for Accelerations
            0x00, 0x08, // Property size is 8 bytes
            0x01,       // Data component identifier
            0x00, 0x05, // Data component size is 5 bytes
            0x01,                   // Lateral acceleration
            0xBF, 0x40, 0xC4, 0x9C, // -0.753 g

            0x02,       // Property identifier for Understeering
            0x00, 0x0B, // Property size is 11 bytes
            0x01,       // Data component identifier
            0x00, 0x08, // Data component size is 8 bytes
            0x3F, 0xC8, 0x51, 0xEB, 0x85, 0x1E, 0xB8, 0x52, // 19% understeering

            0x03,       // Property identifier for Oversteering
            0x00, 0x0B, // Property size is 11 bytes
            0x01,       // Data component identifier
            0x00, 0x08, // Data component size is 8 bytes
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, // 0% oversteering

            0x04,       // Property identifier for Gas pedal position
            0x00, 0x0B, // Property size is 11 bytes
            0x01,       // Data component identifier
            0x00, 0x08, // Data component size is 8 bytes
            0x3F, 0xEF, 0x5C, 0x28, 0xF5, 0xC2, 0x8F, 0x5C, // At 98%

            0x05,       // Property identifier for Steering angle
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Data component size is 1 bytes
            0x0A,       // Steering is 10° right

            0x06,       // Property identifier for Brake pressure
            0x00, 0x07, // Property size is 7 bytes
            0x01,       // Data component identifier
            0x00, 0x04, // Data component size is 4 bytes
            0x41, 0xA0, 0x00, 0x00, // 20.0 bar

            0x07,       // Property identifier for Yaw rate
            0x00, 0x07, // Property size is 7 bytes
            0x01,       // Data component identifier
            0x00, 0x04, // Data component size is 4 bytes
            0x40, 0xD5, 0x1E, 0xB8, // 6.66 °/s

            0x08,       // Property identifier for Rear suspension steering
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Data component size is 1 bytes
            0x03,       // Steering is +3°

            0x09,       // Property identifier for Electronic stability program
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Data component size is 1 bytes
            0x01,       // ESP intervention active

            0x0A,       // Property identifier for Brake torque vectorings
            0x00, 0x05, // Property size is 5 bytes
            0x01,       // Data component identifier
            0x00, 0x02, // Data component size is 2 bytes
            0x01,       // Rear axle
            0x01,       // Active

            0x0A,       // Property identifier for Brake torque vectorings
            0x00, 0x05, // Property size is 5 bytes
            0x01,       // Data component identifier
            0x00, 0x02, // Data component size is 2 bytes
            0x00,       // Front axle
            0x00,       // Inactive

            0x0B,       // Property identifier for Gear mode
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Data component size is 1 bytes
            0x04,       // Gear in mode "Drive"

            0x0C,       // Property identifier for Selected gear
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Data component size is 1 bytes
            0x04,       // 4th gear selected

            0x0D,       // Property identifier for Brake pedal position
            0x00, 0x0B, // Property size is 11 bytes
            0x01,       // Data component identifier
            0x00, 0x08, // Data component size is 8 bytes
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, // 0%, no brakes

            0x0E,       // Property identifier for Brake pedal switch
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Data component size is 1 bytes
            0x01,       // Brake pedal switch active, brake lights active

            0x0F,       // Property identifier for Clutch pedal switch
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Data component size is 1 bytes
            0x01,       // Clutch pedal switch active, clutch fully depressed

            0x10,       // Property identifier for Accelerator pedal idle switch
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Data component size is 1 bytes
            0x01,       // Accelerator pedal idle switch active, pedal fully released

            0x11,       // Property identifier for Accelerator pedal kickdown switch
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Data component size is 1 bytes
            0x01,       // Accelerator pedal switch active, pedal fully depressed

            0x12,       // Property identifier for Vehicle moving
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Data component size is 1 bytes
            0x01        // Vehicle is moving
        ]

        guard let race = AAAutoAPI.parseBinary(bytes) as? AARace else {
            return XCTFail("Parsed value is not AARace")
        }

        XCTAssertEqual(race.understeering?.value, 0.19)
        XCTAssertEqual(race.oversteering?.value, 0.0)
        XCTAssertEqual(race.gasPedalPosition?.value, 0.98)
        XCTAssertEqual(race.steeringAngle?.value, 10)
        XCTAssertEqual(race.brakePressure?.value, 20.0)
        XCTAssertEqual(race.yawRate?.value, 6.66)
        XCTAssertEqual(race.rearSuspensionSteering?.value, 3)
        XCTAssertEqual(race.espState?.value, .active)
        XCTAssertEqual(race.gearMode?.value, .drive)
        XCTAssertEqual(race.selectedGear?.value, 4)
        XCTAssertEqual(race.brakePedalPosition?.value, 0.0)
        XCTAssertEqual(race.brakePedalSwitchState?.value, .active)
        XCTAssertEqual(race.clutchPedalSwitchState?.value, .active)
        XCTAssertEqual(race.acceleratorPedalIdleSwitchState?.value, .active)
        XCTAssertEqual(race.acceleratorPedalKickdownSwitchState?.value, .active)
        XCTAssertEqual(race.vehicleMoving?.value, .moving)

        // Accelerations
        let accelerations = race.accelerations

        XCTAssertEqual(accelerations?.count, 2)

        if let longitudinalAcceleration = accelerations?.first(where: { $0.value?.type == .longitudinal }) {
            XCTAssertEqual(longitudinalAcceleration.value?.value, 0.864)
        }
        else {
            XCTFail("Accelerations doesn't contain Longitudinal Acceleration")
        }

        if let lateralAcceleration = accelerations?.first(where: { $0.value?.type == .lateral }) {
            XCTAssertEqual(lateralAcceleration.value?.value, -0.753)
        }
        else {
            XCTFail("Accelerations doesn't contain Lateral Acceleration")
        }

        // Brake Torque Vectorings
        let BTVs = race.brakeTorqueVectorings

        XCTAssertEqual(BTVs?.count, 2)

        if let btv = BTVs?.first(where: { $0.value?.axle == .rear }) {
            XCTAssertEqual(btv.value?.state, .active)
        }
        else {
            XCTFail("Brake Torque Vectorings doesn't contain Rear Axle")
        }

        if let btv = BTVs?.first(where: { $0.value?.axle == .front }) {
            XCTAssertEqual(btv.value?.state, .inactive)
        }
        else {
            XCTFail("Brake Torque Vectorings doesn't contain Front Axle")
        }
    }
}
