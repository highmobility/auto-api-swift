//
// AutoAPITests
// Copyright (C) 2017 High-Mobility GmbH
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
//  VehicleStatusTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 27/11/2017.
//  Copyright © 2017 High Mobility. All rights reserved.
//

import AutoAPI
import XCTest


class VehicleStatusTests: XCTestCase {

    static var allTests = [("testGetStatus", testGetStatus),
                           ("testState", testState)]


    // MARK: XCTestCase

    func testGetStatus() {
        let bytes: [UInt8] = [
            0x00, 0x11, // MSB, LSB Message Identifier for Vehicle Status
            0x00        // Message Type for Get Vehicle Status
        ]

        XCTAssertEqual(VehicleStatus.getVehicleStatus, bytes)
    }

    func testState() {
        let bytes: [UInt8] = [
            0x00, 0x11, // MSB, LSB Message Identifier for Vehicle Status
            0x01,       // Message Type for Vehicle Status

            0x01,                               // Property Identifier for VIN
            0x00, 0x11,                         // Property size 17 bytes
            0x4a, 0x46, 0x32, 0x53, 0x48, 0x42, //
            0x44, 0x43, 0x37, 0x43, 0x48, 0x34, //
            0x35, 0x31, 0x38, 0x36, 0x39,       // VIN

            0x02,                               // Property Identifier for Powertrain
            0x00, 0x01,                         // Property size 1 byte
            0x01,                               // All-electric powertrain

            0x03,                               // Property Identifier for Model name
            0x00, 0x06,                         // Property size 6 bytes
            0x54, 0x79, 0x70, 0x65, 0x20, 0x58, // "Type X"

            0x04,                               // Property Identifier for name
            0x00, 0x06,                         // Property size 6 bytes
            0x4d, 0x79, 0x20, 0x43, 0x61, 0x72, // "My Car"

            0x05,                               // Property Identifier for License plate
            0x00, 0x06,                         // Property size 6 bytes
            0x41, 0x42, 0x43, 0x31, 0x32, 0x33, // "ABC123"

            0x06,                   // Property Identifier for Sales designation
            0x00, 0x08,             // Property size 8 bytes
            0x50, 0x61, 0x63, 0x6B, //
            0x61, 0x67, 0x65, 0x2B, // "Package+"

            0x07,       // Property Identifier for Model year
            0x00, 0x02, // Property size 2 bytes
            0x07, 0xE1, // 2017

            0x08,                               // Property Identifier for Color name
            0x00, 0x0C,                         // Property size 12 bytes
            0x45, 0x73, 0x74, 0x6f, 0x72, 0x69, //
            0x6c, 0x20, 0x42, 0x6c, 0x61, 0x75, // "Estoril Blau"

            0x09,       // Property Identifier for Power in kw
            0x00, 0x02, // Property size 2 bytes
            0x00, 0xDC, // 220kw

            0x0A,       // Property Identifier for Number of doors
            0x00, 0x01, // Property size 1 byte
            0x05,       // 5 doors

            0x0B,       // Property Identifier for Number of seats
            0x00, 0x01, // Property size 1 byte
            0x05,       // 5 seats

            0x99,       // Property Identifier for State
            0x00, 0x0B, // Property size 11 bytes
            0x00, 0x21, // Trunk Access Identifier
            0x01,       // Message Type for Trunk State
            0x01,       // Property Identifier for Trunk Lock
            0x00, 0x01, // Property size 1 byte
            0x00,       // Trunk Unlocked
            0x02,       // Property Identifier for Trunk Position
            0x00, 0x01, // Property size 1 byte
            0x01,       // Trunk Open

            0x99,       // Property Identifier for State
            0x00, 0x07, // Property size 7 bytes
            0x00, 0x27, // Remote Control Identifier
            0x01,       // Message Type for Control Mode
            0x01,       // Property Identifier for Control Mode
            0x00, 0x01, // Property size 1 byte
            0x02        // Remote Control Started
        ]

        guard let vehicleStatus = AutoAPI.parseBinary(bytes) as? VehicleStatus else {
            return XCTFail("Parsed value is not VehicleStatus")
        }

        XCTAssertEqual(vehicleStatus.vin, "JF2SHBDC7CH451869")
        XCTAssertEqual(vehicleStatus.powerTrain, .allElectric)
        XCTAssertEqual(vehicleStatus.modelName, "Type X")
        XCTAssertEqual(vehicleStatus.name, "My Car")
        XCTAssertEqual(vehicleStatus.licensePlate, "ABC123")
        XCTAssertEqual(vehicleStatus.salesDesignation, "Package+")
        XCTAssertEqual(vehicleStatus.modelYear, 2017)
        XCTAssertEqual(vehicleStatus.colourName, "Estoril Blau")
        XCTAssertEqual(vehicleStatus.powerKW, 220)
        XCTAssertEqual(vehicleStatus.numberOfDoors, 5)
        XCTAssertEqual(vehicleStatus.numberOfSeats, 5)

        // Go through the STATES
        let states = vehicleStatus.states

        XCTAssertEqual(states?.count, 2)

        // TRUNK ACCESS
        if let trunkAccessState = states?.flatMapFirst({ $0 as? TrunkAccess }) {
            XCTAssertEqual(trunkAccessState.lock, .unlocked)
            XCTAssertEqual(trunkAccessState.position, .open)
        }
        else {
            XCTFail("States doesn't contain TrunkAccess")
        }

        // REMOTE CONTROL
        if let remoteControl = states?.flatMapFirst({ $0 as? RemoteControl }) {
            XCTAssertEqual(remoteControl.controlMode, .started)
        }
        else {
            XCTFail("States doesn't contain RemoteControl")
        }
    }
}
