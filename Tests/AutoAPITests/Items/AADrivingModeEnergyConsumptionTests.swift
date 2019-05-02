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
//  AADrivingModeEnergyConsumptionTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 04/04/2019.
//  Copyright © 2019 High Mobility GmbH. All rights reserved.
//

@testable import AutoAPI
import XCTest


class AADrivingModeEnergyConsumptionTests: XCTestCase {

    static var allTests = [("testBytes", testBytes),
                           ("testInit", testInit)]


    // MARK: XCTestCase

    func testBytes() {
        let bytes: [UInt8] = [
            0x00,                   // Regular driving mode
            0x42, 0x5D, 0x99, 0x9A  // Consumed 55.4 kWh
        ]

        XCTAssertEqual(AADrivingModeEnergyConsumption(mode: .regular, consumption: 55.4).bytes, bytes)
    }

    func testInit() {
        // Successful
        let bytes1: [UInt8] = [
            0x00,                   // Regular driving mode
            0x42, 0x5D, 0x99, 0x9A  // Consumed 55.4 kWh
        ]

        if let consumption = AADrivingModeEnergyConsumption(bytes: bytes1) {
            XCTAssertEqual(consumption.mode, .regular)
            XCTAssertEqual(consumption.consumption, 55.4)
        }
        else {
            XCTFail("Failed to initialise AADrivingModeEnergyConsumption")
        }

        // Fail#1
        let bytes2: [UInt8] = [
            0x01    // Invalid bytes count
        ]

        XCTAssertNil(AADrivingModeEnergyConsumption(bytes: bytes2))

        // Fail#2
        let bytes3: [UInt8] = [
            0x55,                   // INVALID
            0x42, 0x5D, 0x99, 0x9A  // Consumed 55.4 kWh
        ]

        XCTAssertNil(AADrivingModeEnergyConsumption(bytes: bytes3))
    }
}
