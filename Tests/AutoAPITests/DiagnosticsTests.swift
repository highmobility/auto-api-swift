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
//  DiagnosticsTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 28/11/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import AutoAPI
import XCTest


class DiagnosticsTests: XCTestCase {

    static var allTests = [("testGetState", testGetState),
                           ("testState", testState)]


    // MARK: XCTestCase

    func testGetState() {
        let bytes: [UInt8] = [
            0x00, 0x33, // MSB, LSB Message Identifier for Diagnostics
            0x00        // Message Type for Get Diagnostics State
        ]

        XCTAssertEqual(Diagnostics.getDiagnosticsState, bytes)
    }

    func testState() {
        let bytes: [UInt8] = [
            0x00, 0x33, // MSB, LSB Message Identifier for Diagnostics
            0x01,       // Message Type for Diagnostics State

            0x01,               // Property Identifier for Mileage
            0x00, 0x03,         // Property size 3 bytes
            0x02, 0x49, 0xF0,   // Odometer is 150'000 km

            0x02,       // Property Identifier for Engine oil temperature
            0x00, 0x02, // Property size 2 bytes
            0x00, 0x63, // Engine oil temperature is 99C

            0x03,       // Property Identifier for Speed
            0x00, 0x02, // Property size 2 bytes
            0x00, 0x3C, // Car speed is 60km/h

            0x04,       // Property Identifier for Engine RPM
            0x00, 0x02, // Property size 2 bytes
            0x09, 0xC4, // RPM is 2500

            0x05,       // Property Identifier for Fuel level
            0x00, 0x01, // Property size 1 byte
            0x5A,       // 90% fuel level

            0x06,       // Property Identifier for Estimated range
            0x00, 0x02, // Property size 2 bytes
            0x01, 0x09, // Estimated range 265 km

            0x07,                   // Property Identifier for Current fuel consumption
            0x00, 0x04,             // Property size 4 bytes
            0x41, 0x0c, 0x00, 0x00, // Current fuel consumption 8,75 liters per 100 km

            0x08,                   // Property Identifier for Average fuel consumption for trip
            0x00, 0x04,             // Property size 4 bytes
            0x40, 0xc6, 0x66, 0x66, // Trip fuel consumption 6,2 liters per 100 km

            0x09,       // Property Identifier for Washer fluid level
            0x00, 0x01, // Property size 1 byte
            0x01,       // Washer fluid filled

            0x0A,                   // Property Identifier for Tire
            0x00, 0x0B,             // Property size 11 bytes
            0x00,                   // Front Left tire
            0x40, 0x13, 0xd7, 0x0a, // pressure is 2.31 BAR
            0x42, 0x20, 0x00, 0x00, // temperature 40C degrees
            0x02, 0xEA,             // wheel RPM 746

            0x0A,                   // Property Identifier for Tire
            0x00, 0x0B,             // Property size 11 bytes
            0x01,                   // Front Right tire
            0x40, 0x13, 0xd7, 0x0a, // pressure is 2.31 BAR
            0x42, 0x20, 0x00, 0x00, // temperature 40C degrees
            0x02, 0xEA,             // wheel RPM 746

            0x0A,                   // Property Identifier for Tire
            0x00, 0x0B,             // Property size 11 bytes
            0x02,                   // Rear Right tire
            0x40, 0x13, 0xd7, 0x0a, // pressure is 2.31 BAR
            0x42, 0x20, 0x00, 0x00, // temperature 40C degrees
            0x02, 0xEA,             // wheel RPM 746

            0x0A,                   // Property Identifier for Tire
            0x00, 0x0B,             // Property size 11 bytes
            0x03,                   // Rear Left tire
            0x40, 0x13, 0xd7, 0x0a, // pressure is 2.31 BAR
            0x42, 0x20, 0x00, 0x00, // temperature 40C degrees
            0x02, 0xEA,             // wheel RPM 746

            0x0B,                   // Property Identifier for Battery Voltage
            0x00, 0x04,             // Property size 4 bytes
            0x41, 0x40, 0x00, 0x00, // Battery voltage 12V

            0x0C,                   // Property Identifier for AdBlue level
            0x00, 0x04,             // Property size 4 bytes
            0x3F, 0x00, 0x00, 0x00, // AdBlue level 0.5 liters

            0x0D,       // Property Identifier for Distance since reset
            0x00, 0x02, // Property size 2 bytes
            0x05, 0xDC, // 1'500 km driven since reset

            0x0E,       // Property Identifier for Distance since start
            0x00, 0x02, // Property size 2 bytes
            0x00, 0x0A, // 10 km driven since engine start

            0x0F,                   // Property identifier for Fuel volume
            0x00, 0x04,             // Property size is 4 bytes
            0x42, 0x0E, 0x00, 0x00,  // 35,5 liters of fuel left

            0x10,       // Property identifier for Anti lock braking
            0x00, 0x01, // Property size is 1 bytes
            0x01,       // ABS active

            0x11,       // Property identifier for Engine coolant temperature
            0x00, 0x02, // Property size is 2 bytes
            0x00, 0x14, // Engine coolant temperature is 20 degrees Celsius

            0x12,                   // Property identifier for Engine total operating hours
            0x00, 0x04,             // Property size is 4 bytes
            0x44, 0xbb, 0x94, 0xcd, // The engine has been operating in a total of 1500.65 hours

            0x13,                   // Property identifier for Engine total fuel consumption
            0x00, 0x04,             // Property size is 4 bytes
            0x46, 0xd7, 0x86, 0x00, // The engine total fuel consumption over its lifespan is 27587.0 liters

            0x14,       // Property identifier for Brake fluid level
            0x00, 0x01, // Property size is 1 bytes
            0x00,       // Brake fluid low

            0x15,       // Property identifier for Engine torque
            0x00, 0x01, // Property size is 1 bytes
            0x14,       // Current engine torque is at 20% of full torque

            0x16,       // Property identifier for Engine load
            0x00, 0x01, // Property size is 1 bytes
            0x0A,       // Current engine load is at 10% of full capacity

            0x17,       // Property identifier for Wheel based speed
            0x00, 0x02, // Property size is 2 bytes
            0x00, 0x41  // The wheel base speed is 65km/h
        ]

        guard let diagnostics = AutoAPI.parseBinary(bytes) as? Diagnostics else {
            return XCTFail("Parsed value is not Diagnostics")
        }

        XCTAssertEqual(diagnostics.mileage, 150_000)
        XCTAssertEqual(diagnostics.engineOilTemperature, 99)
        XCTAssertEqual(diagnostics.speed, 60)
        XCTAssertEqual(diagnostics.engineRPM, 2500)
        XCTAssertEqual(diagnostics.fuelLevel, 90)
        XCTAssertEqual(diagnostics.estimatedRange, 265)
        XCTAssertEqual(diagnostics.currentFuelConsumption, 8.75)
        XCTAssertEqual(diagnostics.averageFuelConsumption, 6.2)
        XCTAssertEqual(diagnostics.washerFluidLevel, .filled)
        XCTAssertEqual(diagnostics.batteryVoltage, 12.0)
        XCTAssertEqual(diagnostics.adBlueLevel, 0.5)
        XCTAssertEqual(diagnostics.distanceSinceReset, 1_500)
        XCTAssertEqual(diagnostics.distanceSinceStart, 10)
        XCTAssertEqual(diagnostics.fuelVolume, 35.5)
        XCTAssertEqual(diagnostics.isABSActive, true)
        XCTAssertEqual(diagnostics.engineCoolantTemperature, 20)
        XCTAssertEqual(diagnostics.engineTotalOperatingHours, 1500.65)
        XCTAssertEqual(diagnostics.engineTotalFuelConsumption, 27587.0)
        XCTAssertEqual(diagnostics.brakeFluidLevel, .low)
        XCTAssertEqual(diagnostics.engineTorque, 20)
        XCTAssertEqual(diagnostics.engineLoad, 10)
        XCTAssertEqual(diagnostics.wheelBasedSpeed, 65)

        let tires = diagnostics.tires

        XCTAssertEqual(tires?.count, 4)

        if let frontLeftTire = tires?.first(where: { $0.position == .frontLeft }) {
            XCTAssertEqual(frontLeftTire.pressure, 2.31)
            XCTAssertEqual(frontLeftTire.temperature, 40)
            XCTAssertEqual(frontLeftTire.wheelRPM, 746)
        }
        else {
            XCTFail("Tires doesn't contain Front Left Tire")
        }

        if let frontRightTire = tires?.first(where: { $0.position == .frontRight }) {
            XCTAssertEqual(frontRightTire.pressure, 2.31)
            XCTAssertEqual(frontRightTire.temperature, 40)
            XCTAssertEqual(frontRightTire.wheelRPM, 746)
        }
        else {
            XCTFail("Tires doesn't contain Front Right Tire")
        }

        if let rearRightTire = tires?.first(where: { $0.position == .rearRight }) {
            XCTAssertEqual(rearRightTire.pressure, 2.31)
            XCTAssertEqual(rearRightTire.temperature, 40)
            XCTAssertEqual(rearRightTire.wheelRPM, 746)
        }
        else {
            XCTFail("Tires doesn't contain Rear Right Tire")
        }

        if let rearLeftTire = tires?.first(where: { $0.position == .rearLeft }) {
            XCTAssertEqual(rearLeftTire.pressure, 2.31)
            XCTAssertEqual(rearLeftTire.temperature, 40)
            XCTAssertEqual(rearLeftTire.wheelRPM, 746)
        }
        else {
            XCTFail("Tires doesn't contain Front Left Tire")
        }
    }
}
