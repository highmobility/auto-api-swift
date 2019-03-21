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
//  AAUsageTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 21/03/2019.
//  Copyright © 2019 High Mobility GmbH. All rights reserved.
//

import AutoAPI
import XCTest


class AAUsageTests: XCTestCase {

    static var allTests = [("testGetState", testGetState),
                           ("testState", testState)]


    // MARK: XCTestCase

    func testGetState() {
        let bytes: [UInt8] = [
            0x00, 0x68, // MSB, LSB Message Identifier for Usage
            0x00        // Message Type for Get Usage
        ]

        XCTAssertEqual(AAUsage.getUsage.bytes, bytes)
    }

    func testState() {
        let bytes: [UInt8] = [
            0x00, 0x68, // MSB, LSB Message Identifier for Usage
            0x01,       // Message Type for Usage

            0x01,       // Property identifier for Average weekly distance
            0x00, 0x05, // Property size is 5 bytes
            0x01,       // Data component identifier
            0x00, 0x02, // Data component size is 2 bytes
            0x02, 0x9A, // Avg. weekly distance is 666km

            0x02,       // Property identifier for Average weekly distance long run
            0x00, 0x05, // Property size is 5 bytes
            0x01,       // Data component identifier
            0x00, 0x02, // Data component size is 2 bytes
            0x02, 0x9A, // Avg. weekly distance, long term, is 666km

            0x03,       // Property identifier for Acceleration evaluation
            0x00, 0x0B, // Property size is 11 bytes
            0x01,       // Data component identifier
            0x00, 0x08, // Data component size is 8 bytes
            0x3F, 0xE6, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, // Acceleration evaluation is 70%

            0x04,       // Property identifier for Driving style evaluation
            0x00, 0x0B, // Property size is 11 bytes
            0x01,       // Data component identifier
            0x00, 0x08, // Data component size is 8 bytes
            0x3F, 0xE6, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, // Driving style evaluation is 70%

            0x05,       // Property identifier for Driving modes activation periods
            0x00, 0x0C, // Property size is 12 bytes
            0x01,       // Data component identifier
            0x00, 0x09, // Data component size is 9 bytes
            0x01,                                           // ECO driving mode
            0x3F, 0xE3, 0x33, 0x33, 0x33, 0x33, 0x33, 0x33, // 60% of the time

            0x05,       // Property identifier for Driving modes activation periods
            0x00, 0x0C, // Property size is 12 bytes
            0x01,       // Data component identifier
            0x00, 0x09, // Data component size is 9 bytes
            0x00,                                           // Regular driving mode
            0x3F, 0xD9, 0x99, 0x99, 0x99, 0x99, 0x99, 0x9A, // 40% of the time

            0x06,       // Property identifier for Driving mode energy consumption
            0x00, 0x08, // Property size is 8 bytes
            0x01,       // Data component identifier
            0x00, 0x05, // Data component size is 5 bytes
            0x01,                   // ECO driving mode
            0x42, 0x04, 0xCC, 0xCD, // Consumed 33.2 kWh

            0x06,       // Property identifier for Driving mode energy consumption
            0x00, 0x08, // Property size is 8 bytes
            0x01,       // Data component identifier
            0x00, 0x05, // Data component size is 5 bytes
            0x00,                   // Regular driving mode
            0x42, 0x5D, 0x99, 0x9A, // Consumed 55.4 kWh

            0x07,       // Property identifier for Last trip energy consumption
            0x00, 0x07, // Property size is 7 bytes
            0x01,       // Data component identifier
            0x00, 0x04, // Data component size is 4 bytes
            0x42, 0xCA, 0x99, 0x9A, // 101.3 kWh

            0x08,       // Property identifier for Last trip fuel consumption
            0x00, 0x07, // Property size is 7 bytes
            0x01,       // Data component identifier
            0x00, 0x04, // Data component size is 4 bytes
            0x41, 0xB4, 0x00, 0x00, // Consumed 22.5 l

            0x09,       // Property identifier for Mileage after last trip
            0x00, 0x07, // Property size is 7 bytes
            0x01,       // Data component identifier
            0x00, 0x04, // Data component size is 4 bytes
            0x47, 0xBA, 0xC8, 0x5A, // Mileage is 95 632.7 km

            0x0A,       // Property identifier for Last trip electric portion
            0x00, 0x0B, // Property size is 11 bytes
            0x01,       // Data component identifier
            0x00, 0x08, // Data component size is 8 bytes
            0x3F, 0xE6, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, // Electric portion was 70%

            0x0B,       // Property identifier for Last trip average energy recuperation
            0x00, 0x07, // Property size is 7 bytes
            0x01,       // Data component identifier
            0x00, 0x04, // Data component size is 4 bytes
            0x40, 0xB5, 0xC2, 0x8F, // Recuperated 5.68 kWh / 100km

            0x0C,       // Property identifier for Last trip battery remaining
            0x00, 0x0B, // Property size is 11 bytes
            0x01,       // Data component identifier
            0x00, 0x08, // Data component size is 8 bytes
            0x3F, 0xE0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, // Battery was 50% after last trip

            0x0D,       // Property identifier for Last trip date
            0x00, 0x0B, // Property size is 11 bytes
            0x01,       // Data component identifier
            0x00, 0x08, // Data component size is 8 bytes
            0x00, 0x00, 0x01, 0x66, 0x82, 0x05, 0x9D, 0x50, // 17 October 2018 at 12:34:58 UTC

            0x0E,       // Property identifier for Average fuel consumption
            0x00, 0x07, // Property size is 7 bytes
            0x01,       // Data component identifier
            0x00, 0x04, // Data component size is 4 bytes
            0x40, 0xD0, 0x00, 0x00, // Avg. fuel consumption is 6.5l / 100km

            0x0F,       // Property identifier for Current fuel consumption
            0x00, 0x07, // Property size is 7 bytes
            0x01,       // Data component identifier
            0x00, 0x04, // Data component size is 4 bytes
            0x40, 0xF0, 0x00, 0x00  // Current fuel consumption is 7.5l / 100km
        ]

        guard let usage = AutoAPI.parseBinary(bytes) as? AAUsage else {
            return XCTFail("Parsed value is not AAUsage")
        }

        XCTAssertEqual(usage.averageWeeklyDistance?.value, 666)
        XCTAssertEqual(usage.averageWeeklyDistanceLongTerm?.value, 666)
        XCTAssertEqual(usage.accelerationEvalution?.value, 0.7)
        XCTAssertEqual(usage.drivingStyleEvalution?.value, 0.7)
        XCTAssertEqual(usage.lastTripEnergyConsumption?.value, 101.3)
        XCTAssertEqual(usage.lastTripFuelConsumption?.value, 22.5)
        XCTAssertEqual(usage.lastTripElectricPortion?.value, 0.7)
        XCTAssertEqual(usage.lastTripAverageEnergyRecuperation?.value, 5.68)
        XCTAssertEqual(usage.lastTripBatteryRemaining?.value, 0.5)
        XCTAssertEqual(usage.lastTripDate?.value, Date(timeIntervalSince1970: 1_539_779_698.0))
        XCTAssertEqual(usage.averageFuelConsumption?.value, 6.5)
        XCTAssertEqual(usage.currentFuelConsumption?.value, 7.5)

        // Driving Modes Activation Periods
        let DMAPs = usage.drivingModeActivationPeriods

        XCTAssertEqual(DMAPs?.count, 2)

        if let activationPeriod = DMAPs?.first(where: { $0.value?.mode == .eco }) {
            XCTAssertEqual(activationPeriod.value?.period, 0.60)
        }
        else {
            XCTFail("Driving Modes Activation Periods doesn't contain ECO")
        }

        if let activationPeriod = DMAPs?.first(where: { $0.value?.mode == .regular }) {
            XCTAssertEqual(activationPeriod.value?.period, 0.40)
        }
        else {
            XCTFail("Driving Modes Activation Periods doesn't contain Regular")
        }

        // Driving Mode Energy Consumptions
        let DMECs = usage.drivingModeEnergyConsumptions

        XCTAssertEqual(DMECs?.count, 2)

        if let energyConsumption = DMECs?.first(where: { $0.value?.mode == .eco }) {
            XCTAssertEqual(energyConsumption.value?.consumption, 33.2)
        }
        else {
            XCTFail("Driving Mode Energy Consumptions doesn't contain ECO")
        }

        if let energyConsumption = DMECs?.first(where: { $0.value?.mode == .regular }) {
            XCTAssertEqual(energyConsumption.value?.consumption, 55.4)
        }
        else {
            XCTFail("Driving Mode Energy Consumptions doesn't contain Regular")
        }
    }
}
