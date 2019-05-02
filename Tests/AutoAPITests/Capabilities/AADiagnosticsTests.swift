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
//  AADiagnosticsTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 28/11/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import AutoAPI
import XCTest


class AADiagnosticsTests: XCTestCase {

    static var allTests = [("testGetState", testGetState),
                           ("testState", testState)]


    // MARK: XCTestCase

    func testGetState() {
        let bytes: [UInt8] = [
            0x00, 0x33, // MSB, LSB Message Identifier for Diagnostics
            0x00        // Message Type for Get Diagnostics State
        ]

        XCTAssertEqual(AADiagnostics.getDiagnosticsState.bytes, bytes)
    }

    func testState() {
        let bytes: [UInt8] = [
            0x00, 0x33, // MSB, LSB Message Identifier for Diagnostics
            0x01,       // Message Type for Diagnostics State

            0x01,       // Property identifier for Mileage
            0x00, 0x07, // Property size is 7 bytes
            0x01,       // Data component identifier
            0x00, 0x04, // Data component size is 4 bytes
            0x00, 0x02, 0x49, 0xF0, // Odometer is 150'000 km

            0x02,       // Property identifier for Engine oil temperature
            0x00, 0x05, // Property size is 5 bytes
            0x01,       // Data component identifier
            0x00, 0x02, // Data component size is 2 bytes
            0x00, 0x63, // Engine oil temperature is 99 degrees Celsius

            0x03,       // Property identifier for Speed
            0x00, 0x05, // Property size is 5 bytes
            0x01,       // Data component identifier
            0x00, 0x02, // Data component size is 2 bytes
            0x00, 0x3C, // Car vehicle speed is 60km/h

            0x04,       // Property identifier for Engine rpm
            0x00, 0x05, // Property size is 5 bytes
            0x01,       // Data component identifier
            0x00, 0x02, // Data component size is 2 bytes
            0x09, 0xC4, // RPM is 2500

            0x05,       // Property identifier for Fuel level
            0x00, 0x0B, // Property size is 11 bytes
            0x01,       // Data component identifier
            0x00, 0x08, // Data component size is 8 bytes
            0x3F, 0xEC, 0xCC, 0xCC, 0xCC, 0xCC, 0xCC, 0xCD, // 90% fuel level

            0x06,       // Property identifier for Estimated range
            0x00, 0x05, // Property size is 5 bytes
            0x01,       // Data component identifier
            0x00, 0x02, // Data component size is 2 bytes
            0x01, 0x09, // Estimated range 265 km

            0x09,       // Property identifier for Washer fluid level
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Data component size is 1 bytes
            0x01,       // Washer fluid filled

            0x0B,       // Property identifier for Battery voltage
            0x00, 0x07, // Property size is 7 bytes
            0x01,       // Data component identifier
            0x00, 0x04, // Data component size is 4 bytes
            0x41, 0x40, 0x00, 0x00, // Battery voltage 12V

            0x0C,       // Property identifier for Adblue level
            0x00, 0x07, // Property size is 7 bytes
            0x01,       // Data component identifier
            0x00, 0x04, // Data component size is 4 bytes
            0x3F, 0x00, 0x00, 0x00, // AdBlue level 0.5 liters

            0x0D,       // Property identifier for Distance since reset
            0x00, 0x05, // Property size is 5 bytes
            0x01,       // Data component identifier
            0x00, 0x02, // Data component size is 2 bytes
            0x05, 0xDC, // 1'500 km driven since reset

            0x0E,       // Property identifier for Distance since start
            0x00, 0x05, // Property size is 5 bytes
            0x01,       // Data component identifier
            0x00, 0x02, // Data component size is 2 bytes
            0x00, 0x0A, // 10 km driven since engine start

            0x0F,       // Property identifier for Fuel volume
            0x00, 0x07, // Property size is 7 bytes
            0x01,       // Data component identifier
            0x00, 0x04, // Data component size is 4 bytes
            0x42, 0x0E, 0x00, 0x00, // 35,5 liters of fuel left

            0x10,       // Property identifier for Anti lock braking
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Data component size is 1 bytes
            0x01,       // ABS active

            0x11,       // Property identifier for Engine coolant temperature
            0x00, 0x05, // Property size is 5 bytes
            0x01,       // Data component identifier
            0x00, 0x02, // Data component size is 2 bytes
            0x00, 0x14, // Engine coolant temperature is 20 degrees Celsius

            0x12,       // Property identifier for Engine total operating hours
            0x00, 0x07, // Property size is 7 bytes
            0x01,       // Data component identifier
            0x00, 0x04, // Data component size is 4 bytes
            0x44, 0xBB, 0x94, 0xCD, // The engine has been operating in a total of 1500.65 hours

            0x13,       // Property identifier for Engine total fuel consumption
            0x00, 0x07, // Property size is 7 bytes
            0x01,       // Data component identifier
            0x00, 0x04, // Data component size is 4 bytes
            0x46, 0xD7, 0x86, 0x00, // The engine total fuel consumption over its lifespan is 27587.0 liters

            0x14,       // Property identifier for Brake fluid level
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Data component size is 1 bytes
            0x00,       // Brake fluid low

            0x15,       // Property identifier for Engine torque
            0x00, 0x0B, // Property size is 11 bytes
            0x01,       // Data component identifier
            0x00, 0x08, // Data component size is 8 bytes
            0x3F, 0xC9, 0x99, 0x99, 0x99, 0x99, 0x99, 0x9A, // Current engine torque is at 20% of full torque

            0x16,       // Property identifier for Engine load
            0x00, 0x0B, // Property size is 11 bytes
            0x01,       // Data component identifier
            0x00, 0x08, // Data component size is 8 bytes
            0x3F, 0xB9, 0x99, 0x99, 0x99, 0x99, 0x99, 0x9A, // Current engine load is at 10% of full capacity

            0x17,       // Property identifier for Wheel based speed
            0x00, 0x05, // Property size is 5 bytes
            0x01,       // Data component identifier
            0x00, 0x02, // Data component size is 2 bytes
            0x00, 0x41, // The wheel base speed is 65km/h

            0x18,       // Property identifier for Battery level
            0x00, 0x0B, // Property size is 11 bytes
            0x01,       // Data component identifier
            0x00, 0x08, // Data component size is 8 bytes
            0x3F, 0xE1, 0xEB, 0x85, 0x1E, 0xB8, 0x51, 0xEC, // The 12V battery level is 56%

            0x19,       // Property identifier for Check control messages
            0x00, 0x1D, // Property size is 29 bytes
            0x01,       // Data component identifier
            0x00, 0x1A, // Data component size is 26 bytes
            0x00, 0x01,                         // The id is 1
            0x00, 0x01, 0x9C, 0x78,             // The remaining time is 105 592 minutes
            0x00, 0x0C,                         // The following text size is 12 bytes
            0x43, 0x68, 0x65, 0x63, 0x6B, 0x20,
            0x65, 0x6E, 0x67, 0x69, 0x6E, 0x65, // Check engine
            0x05,                               // Size of the status is 5 bytes
            0x41, 0x6C, 0x65, 0x72, 0x74,       // Alert

            0x1A,       // Property identifier for Tire pressures
            0x00, 0x08, // Property size is 8 bytes
            0x01,       // Data component identifier
            0x00, 0x05, // Data component size is 5 bytes
            0x00,                   // Front Left tire
            0x40, 0x13, 0xD7, 0x0A, // Pressure is 2.31 BAR

            0x1A,       // Property identifier for Tire pressures
            0x00, 0x08, // Property size is 8 bytes
            0x01,       // Data component identifier
            0x00, 0x05, // Data component size is 5 bytes
            0x01,                   // Front Right tire
            0x40, 0x13, 0xD7, 0x0A, // Pressure is 2.31 BAR

            0x1A,       // Property identifier for Tire pressures
            0x00, 0x08, // Property size is 8 bytes
            0x01,       // Data component identifier
            0x00, 0x05, // Data component size is 5 bytes
            0x02,                   // Rear Right tire
            0x40, 0x13, 0xD7, 0x0A, // Pressure is 2.31 BAR

            0x1A,       // Property identifier for Tire pressures
            0x00, 0x08, // Property size is 8 bytes
            0x01,       // Data component identifier
            0x00, 0x05, // Data component size is 5 bytes
            0x03,                   // Rear Left tire
            0x40, 0x13, 0xD7, 0x0A, // Pressure is 2.31 BAR

            0x1B,       // Property identifier for Tire temperatures
            0x00, 0x08, // Property size is 8 bytes
            0x01,       // Data component identifier
            0x00, 0x05, // Data component size is 5 bytes
            0x00,                   // Front Left tire
            0x42, 0x20, 0x00, 0x00, // Temperature 40C degrees

            0x1B,       // Property identifier for Tire temperatures
            0x00, 0x08, // Property size is 8 bytes
            0x01,       // Data component identifier
            0x00, 0x05, // Data component size is 5 bytes
            0x01,                   // Front Right tire
            0x42, 0x20, 0x00, 0x00, // Temperature 40C degrees

            0x1B,       // Property identifier for Tire temperatures
            0x00, 0x08, // Property size is 8 bytes
            0x01,       // Data component identifier
            0x00, 0x05, // Data component size is 5 bytes
            0x02,                   // Rear Right tire
            0x42, 0x20, 0x00, 0x00, // Temperature 40C degrees

            0x1B,       // Property identifier for Tire temperatures
            0x00, 0x08, // Property size is 8 bytes
            0x01,       // Data component identifier
            0x00, 0x05, // Data component size is 5 bytes
            0x03,                   // Rear Left tire
            0x42, 0x20, 0x00, 0x00, // Temperature 40C degrees

            0x1C,       // Property identifier for Wheel rpms
            0x00, 0x06, // Property size is 6 bytes
            0x01,       // Data component identifier
            0x00, 0x03, // Data component size is 3 bytes
            0x00,       // Front Left tire
            0x02, 0xEA, // Wheel RPM 746

            0x1C,       // Property identifier for Wheel rpms
            0x00, 0x06, // Property size is 6 bytes
            0x01,       // Data component identifier
            0x00, 0x03, // Data component size is 3 bytes
            0x01,       // Front Right tire
            0x02, 0xEA, // Wheel RPM 746

            0x1C,       // Property identifier for Wheel rpms
            0x00, 0x06, // Property size is 6 bytes
            0x01,       // Data component identifier
            0x00, 0x03, // Data component size is 3 bytes
            0x02,       // Rear Right tire
            0x02, 0xEA, // Wheel RPM 746

            0x1C,       // Property identifier for Wheel rpms
            0x00, 0x06, // Property size is 6 bytes
            0x01,       // Data component identifier
            0x00, 0x03, // Data component size is 3 bytes
            0x03,       // Rear Left tire
            0x02, 0xEA, // Wheel RPM 746

            0x1D,       // Property identifier for Trouble codes
            0x00, 0x1E, // Property size is 30 bytes
            0x01,       // Data component identifier
            0x00, 0x1B, // Data component size is 27 bytes
            0x02,                                                   // Occured twice
            0x07,                                                   // ID size is 7 bytes
            0x43, 0x31, 0x31, 0x31, 0x36, 0x46, 0x41,               // ID is "C1116FA"
            0x09,                                                   // ECU ID size is 9 bytes
            0x52, 0x44, 0x55, 0x5F, 0x32, 0x31, 0x32, 0x46, 0x52,   // ECU ID is "RDU_212FR"
            0x07,                                                   // Status size is 7 bytes
            0x50, 0x45, 0x4E, 0x44, 0x49, 0x4E, 0x47,               // Status is "PENDING"

            0x1D,       // Property identifier for Trouble codes
            0x00, 0x1B, // Property size is 27 bytes
            0x01,       // Data component identifier
            0x00, 0x18, // Data component size is 24 bytes
            0x02,                                       // Occured twice
            0x07,                                       // ID size is 7 bytes
            0x43, 0x31, 0x36, 0x33, 0x41, 0x46, 0x41,   // ID is "C163AFA"
            0x06,                                       // ECU ID size is 6 bytes
            0x44, 0x54, 0x52, 0x32, 0x31, 0x32,         // ECU ID is "DTR212"
            0x07,                                       // Status size is 7 bytes
            0x50, 0x45, 0x4E, 0x44, 0x49, 0x4E, 0x47,   // Status is "PENDING"

            0x1E,       // Property identifier for Mileage meters
            0x00, 0x07, // Property size is 7 bytes
            0x01,       // Data component identifier
            0x00, 0x04, // Data component size is 4 bytes
            0x00, 0x02, 0x49, 0xF0  // Odometer is 150'000 meters
        ]

        var diagnostics: AADiagnostics!

        measure {
            guard let parsed = AAAutoAPI.parseBinary(bytes) as? AADiagnostics else {
                return XCTFail("Parsed value is not AADiagnostics")
            }

            diagnostics = parsed
        }

        XCTAssertEqual(diagnostics.mileage?.value, 150_000)
        XCTAssertEqual(diagnostics.engineOilTemperature?.value, 99)
        XCTAssertEqual(diagnostics.speed?.value, 60)
        XCTAssertEqual(diagnostics.engineRPM?.value, 2500)
        XCTAssertEqual(diagnostics.fuelLevel?.value, 0.9)
        XCTAssertEqual(diagnostics.estimatedRange?.value, 265)
        XCTAssertEqual(diagnostics.washerFluidLevel?.value, .filled)
        XCTAssertEqual(diagnostics.batteryVoltage?.value, 12.0)
        XCTAssertEqual(diagnostics.adBlueLevel?.value, 0.5)
        XCTAssertEqual(diagnostics.dieselExhaustFluid?.value, 0.5)
        XCTAssertEqual(diagnostics.distanceSinceReset?.value, 1_500)
        XCTAssertEqual(diagnostics.distanceSinceStart?.value, 10)
        XCTAssertEqual(diagnostics.fuelVolume?.value, 35.5)
        XCTAssertEqual(diagnostics.absState?.value, .active)
        XCTAssertEqual(diagnostics.engineCoolantTemperature?.value, 20)
        XCTAssertEqual(diagnostics.engineTotalOperatingHours?.value, 1500.65)
        XCTAssertEqual(diagnostics.engineTotalFuelConsumption?.value, 27587.0)
        XCTAssertEqual(diagnostics.brakeFluidLevel?.value, .low)
        XCTAssertEqual(diagnostics.engineTorque?.value, 0.2)
        XCTAssertEqual(diagnostics.engineLoad?.value, 0.1)
        XCTAssertEqual(diagnostics.wheelBasedSpeed?.value, 65)
        XCTAssertEqual(diagnostics.batteryLevel?.value, 0.56)
        XCTAssertEqual(diagnostics.mileageMeters?.value, 150_000)

        // Check Control Messages
        if let checkControlMessage = diagnostics.checkControlMessages?.first(where: { $0.value?.id == 1 }) {
            XCTAssertEqual(checkControlMessage.value?.text, "Check engine")
            XCTAssertEqual(checkControlMessage.value?.status, "Alert")
        }
        else {
            XCTFail("Check Control Messages doesn't contain ID#1 CCM")
        }

        // Tire Pressures
        let tirePressures = diagnostics.tirePressures

        XCTAssertEqual(tirePressures?.count, 4)

        if let frontLeftTire = tirePressures?.first(where: { $0.value?.location == .frontLeft }) {
            XCTAssertEqual(frontLeftTire.value?.pressure, 2.31)
        }
        else {
            XCTFail("Tire Pressures doesn't contain Front Left Tire")
        }

        if let frontRightTire = tirePressures?.first(where: { $0.value?.location == .frontRight }) {
            XCTAssertEqual(frontRightTire.value?.pressure, 2.31)
        }
        else {
            XCTFail("Tire Pressures doesn't contain Front Right Tire")
        }

        if let rearRightTire = tirePressures?.first(where: { $0.value?.location == .rearRight }) {
            XCTAssertEqual(rearRightTire.value?.pressure, 2.31)
        }
        else {
            XCTFail("Tire Pressures doesn't contain Rear Right Tire")
        }

        if let rearLeftTire = tirePressures?.first(where: { $0.value?.location == .rearLeft }) {
            XCTAssertEqual(rearLeftTire.value?.pressure, 2.31)
        }
        else {
            XCTFail("Tire Pressures doesn't contain Front Left Tire")
        }

        // Tire Temperatures
        let tireTemps = diagnostics.tireTemperatures

        XCTAssertEqual(tireTemps?.count, 4)

        if let frontLeftTire = tireTemps?.first(where: { $0.value?.location == .frontLeft }) {
            XCTAssertEqual(frontLeftTire.value?.temperature, 40)
        }
        else {
            XCTFail("Tire Temperatures doesn't contain Front Left Tire")
        }

        if let frontRightTire = tireTemps?.first(where: { $0.value?.location == .frontRight }) {
            XCTAssertEqual(frontRightTire.value?.temperature, 40)
        }
        else {
            XCTFail("Tire Temperatures doesn't contain Front Right Tire")
        }

        if let rearRightTire = tireTemps?.first(where: { $0.value?.location == .rearRight }) {
            XCTAssertEqual(rearRightTire.value?.temperature, 40)
        }
        else {
            XCTFail("Tire Temperatures doesn't contain Rear Right Tire")
        }

        if let rearLeftTire = tireTemps?.first(where: { $0.value?.location == .rearLeft }) {
            XCTAssertEqual(rearLeftTire.value?.temperature, 40)
        }
        else {
            XCTFail("Tire Temperatures doesn't contain Front Left Tire")
        }

        // Wheel RPMs
        let wheelRPMs = diagnostics.wheelRPMs

        XCTAssertEqual(wheelRPMs?.count, 4)

        if let frontLeftWheel = wheelRPMs?.first(where: { $0.value?.location == .frontLeft }) {
            XCTAssertEqual(frontLeftWheel.value?.rpm, 746)
        }
        else {
            XCTFail("Wheel RPMs doesn't contain Front Left Tire")
        }

        if let frontRightWheel = wheelRPMs?.first(where: { $0.value?.location == .frontRight }) {
            XCTAssertEqual(frontRightWheel.value?.rpm, 746)
        }
        else {
            XCTFail("Wheel RPMs doesn't contain Front Right Tire")
        }

        if let rearRightWheel = wheelRPMs?.first(where: { $0.value?.location == .rearRight }) {
            XCTAssertEqual(rearRightWheel.value?.rpm, 746)
        }
        else {
            XCTFail("Wheel RPMs doesn't contain Rear Right Tire")
        }

        if let rearLeftWheel = wheelRPMs?.first(where: { $0.value?.location == .rearLeft }) {
            XCTAssertEqual(rearLeftWheel.value?.rpm, 746)
        }
        else {
            XCTFail("Wheel RPMs doesn't contain Front Left Tire")
        }

        // Trouble Codes
        let troubleCodes = diagnostics.troubleCodes

        XCTAssertEqual(troubleCodes?.count, 2)

        if let troubleCode = troubleCodes?.first(where: { $0.value?.id == "C1116FA" }) {
            XCTAssertEqual(troubleCode.value?.occurences, 2)
            XCTAssertEqual(troubleCode.value?.ecuID, "RDU_212FR")
            XCTAssertEqual(troubleCode.value?.status, "PENDING")
        }
        else {
            XCTFail("Trouble Codes doesn't contain ID \"C1116FA\" Trouble Code")
        }

        if let troubleCode = troubleCodes?.first(where: { $0.value?.id == "C163AFA" }) {
            XCTAssertEqual(troubleCode.value?.occurences, 2)
            XCTAssertEqual(troubleCode.value?.ecuID, "DTR212")
            XCTAssertEqual(troubleCode.value?.status, "PENDING")
        }
        else {
            XCTFail("Trouble Codes doesn't contain ID \"C163AFA\" Trouble Code")
        }
    }
}
