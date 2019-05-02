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
//  AAVehicleStatusTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 27/11/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import AutoAPI
import XCTest


class AAVehicleStatusTests: XCTestCase {

    static var allTests = [("testGetStatus", testGetStatus),
                           ("testState", testState)]


    // MARK: XCTestCase

    func testGetStatus() {
        let bytes: [UInt8] = [
            0x00, 0x11, // MSB, LSB Message Identifier for Vehicle Status
            0x00        // Message Type for Get Vehicle Status
        ]

        XCTAssertEqual(AAVehicleStatus.getVehicleStatus.bytes, bytes)
    }

    func testSpeed() {
        let base64Str = "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"

        guard let data = Data(base64Encoded: base64Str) else {
            return XCTFail("Failed to generate Data from Base64String")
        }

        measure {
            guard let _ = AAAutoAPI.parseBinary(data) as? AAVehicleStatus else {
                return XCTFail("Parsed value is not AAVehicleStatus")
            }
        }
    }

    func testState() {
        let bytes: [UInt8] = [
            0x00, 0x11, // MSB, LSB Message Identifier for Vehicle Status
            0x01,       // Message Type for Vehicle Status

            0x01,       // Property Identifier for VIN
            0x00, 0x14, // Property size 20 bytes
            0x01,       // Data component identifier
            0x00, 0x11, // Component size 17 bytes
            0x4a, 0x46, 0x32, 0x53, 0x48, 0x42, //
            0x44, 0x43, 0x37, 0x43, 0x48, 0x34, //
            0x35, 0x31, 0x38, 0x36, 0x39,       // "JF2SHBDC7CH451869"

            0x02,       // Property Identifier for Powertrain
            0x00, 0x04, // Property size 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Component size 1 byte
            0x01,       // All-electric powertrain

            0x03,       // Property Identifier for Model name
            0x00, 0x09, // Property size 9 bytes
            0x01,       // Data component identifier
            0x00, 0x06, // Component size 6 bytes
            0x54, 0x79, 0x70, 0x65, 0x20, 0x58, // "Type X"

            0x04,       // Property Identifier for name
            0x00, 0x09, // Property size 9 bytes
            0x01,       // Data component identifier
            0x00, 0x06, // Component size 6 bytes
            0x4d, 0x79, 0x20, 0x43, 0x61, 0x72, // "My Car"

            0x05,       // Property Identifier for License plate
            0x00, 0x09, // Property size 9 bytes
            0x01,       // Data component identifier
            0x00, 0x06, // Component size 6 bytes
            0x41, 0x42, 0x43, 0x31, 0x32, 0x33, // "ABC123"

            0x06,       // Property Identifier for Sales designation
            0x00, 0x0B, // Property size 11 bytes
            0x01,       // Data component identifier
            0x00, 0x08, // Component size 8 bytes
            0x50, 0x61, 0x63, 0x6B, //
            0x61, 0x67, 0x65, 0x2B, // "Package+"

            0x07,       // Property Identifier for Model year
            0x00, 0x05, // Property size 5 bytes
            0x01,       // Data component identifier
            0x00, 0x02, // Component size 2 bytes
            0x07, 0xE1, // 2017

            0x08,       // Property Identifier for Color name
            0x00, 0x0F, // Property size 15 bytes
            0x01,       // Data component identifier
            0x00, 0x0C, // Component size 12 bytes
            0x45, 0x73, 0x74, 0x6f, 0x72, 0x69,
            0x6c, 0x20, 0x42, 0x6c, 0x61, 0x75, // "Estoril Blau"

            0x09,       // Property Identifier for Power in kw
            0x00, 0x05, // Property size 5 bytes
            0x01,       // Data component identifier
            0x00, 0x02, // Component size 2 bytes
            0x00, 0xDC, // 220kw

            0x0A,       // Property Identifier for Number of doors
            0x00, 0x04, // Property size 4 bytes
            0x01,       // Data component identifier
            0x0, 0x001, // Component size 1 byte
            0x05,       // 5 doors

            0x0B,       // Property Identifier for Number of seats
            0x00, 0x04, // Property size 4 byte
            0x01,       // Data component identifier
            0x00, 0x01, // Component size 1 byte
            0x05,       // 5 seats

            0x0C,       // Property Identifier for Engine volume
            0x00, 0x07, // Property size 7 bytes
            0x01,       // Data component identifier
            0x00, 0x04, // Component size 4 bytes
            0x40, 0x20, 0x00, 0x00, // Engine volume is 2.5 liters

            0x0D,       // Property Identifier for Engine maximum torque
            0x00, 0x05, // Property size 5 bytes
            0x01,       // Data component identifier
            0x00, 0x02, // Component size 2 bytes
            0x00, 0xF5, // Engine torque is 245 Nm

            0x0E,       // Property Identifier for Gearbox
            0x00, 0x04, // Property size 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Component size 1 byte
            0x01,       // Automatic gearbox

            0x99,       // Property Identifier for State
            0x00, 0x14, // Property size 20 bytes
            0x01,       // Data component identifier
            0x00, 0x11, // Component size 17 bytes
            0x00, 0x21, // Trunk Access Identifier
            0x01,       // Message Type for Trunk State
            0x01,       // Property Identifier for Trunk Lock
            0x00, 0x04, // Property size 4 byte
            0x01,       // Data component identifier
            0x00, 0x01, // Component size 1 byte
            0x00,       // Trunk Unlocked
            0x02,       // Property Identifier for Trunk Position
            0x00, 0x04, // Property size 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Component size 1 byte
            0x01,       // Trunk Open

            0x99,       // Property Identifier for State
            0x00, 0x0D, // Property size 13 bytes
            0x01,       // Data component identifier
            0x00, 0x0A, // Component size 10 bytes
            0x00, 0x27, // Remote Control Identifier
            0x01,       // Message Type for Control Mode
            0x01,       // Property Identifier for Control Mode
            0x00, 0x04, // Property size 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Component size 1 byte
            0x02        // Remote Control Started
        ]

        var vehicleStatus: AAVehicleStatus!

        measure {
            guard let parsed = AAAutoAPI.parseBinary(bytes) as? AAVehicleStatus else {
                return XCTFail("Parsed value is not AAVehicleStatus")
            }

            vehicleStatus = parsed
        }

        XCTAssertEqual(vehicleStatus.vin?.value, "JF2SHBDC7CH451869")
        XCTAssertEqual(vehicleStatus.powerTrain?.value, .allElectric)
        XCTAssertEqual(vehicleStatus.modelName?.value, "Type X")
        XCTAssertEqual(vehicleStatus.name?.value, "My Car")
        XCTAssertEqual(vehicleStatus.licensePlate?.value, "ABC123")
        XCTAssertEqual(vehicleStatus.salesDesignation?.value, "Package+")
        XCTAssertEqual(vehicleStatus.modelYear?.value, 2017)
        XCTAssertEqual(vehicleStatus.colourName?.value, "Estoril Blau")
        XCTAssertEqual(vehicleStatus.powerKW?.value, 220)
        XCTAssertEqual(vehicleStatus.numberOfDoors?.value, 5)
        XCTAssertEqual(vehicleStatus.numberOfSeats?.value, 5)
        XCTAssertEqual(vehicleStatus.engineVolume?.value, 2.5)
        XCTAssertEqual(vehicleStatus.engineMaxTorque?.value, 245)
        XCTAssertEqual(vehicleStatus.gearbox?.value, .automatic)

        // States
        XCTAssertEqual(vehicleStatus.states?.count, 2)

        if let trunkAccess = vehicleStatus.states?.first(where: { $0 is AATrunkAccess }) as? AATrunkAccess {
            XCTAssertEqual(trunkAccess.lock?.value, .unlocked)
            XCTAssertEqual(trunkAccess.position?.value, .open)
        }
        else {
            XCTFail("States doesn't contain AATrunkAccess")
        }

        if let remoteControl = vehicleStatus.states?.first(where: { $0 is AARemoteControl }) as? AARemoteControl {
            XCTAssertEqual(remoteControl.controlMode?.value, .started)
        }
        else {
            XCTFail("States doesn't contain AARemoteControl")
        }
    }
}
