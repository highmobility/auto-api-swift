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
//  WindscreenTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 05/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import AutoAPI
import XCTest


class WindscreenTests: XCTestCase {

    static var allTests = [("testGetState", testGetState),
                           ("testSetWindscreenDamage", testSetWindscreenDamage),
                           ("testState", testState)]


    // MARK: XCTestCase

    func testGetState() {
        let bytes: [UInt8] = [
            0x00, 0x42, // MSB, LSB Message Identifier for Windscreen
            0x00        // Message Type for Get Windscreen State
        ]

        XCTAssertEqual(AAWindscreen.getWindscreenState, bytes)
    }

    func testSetWindscreenDamage() {
        let bytes: [UInt8] = [
            0x00, 0x42, // MSB, LSB Message Identifier for Windscreen
            0x02,       // Message Type for Set Windscreen Damage

            0x03,       // Propery Identifier for Windscreen Damage
            0x00, 0x01, // Propery size is 1 byte
            0x01,       // Impact, but no damage detected

            0x05,       // Propery Identifier for Windscreen Damage Zone
            0x00, 0x01, // Propery size is 1 byte
            0x23,       // Damage is positioned 2 units from the left, 3 units from the top

            0x06,       // Propery Identifier for Windscreen Needs Replacement
            0x00, 0x01, // Propery size is 1 byte
            0x01        // No replacement needed
        ]

        XCTAssertEqual(AAWindscreen.setWindscreenDamage(.init(damage: .impactButNoDamageDetected, zone: .matrix(0x23), needsReplacement: .noReplacementNeeded)), bytes)
    }

    func testState() {
        let bytes: [UInt8] = [
            0x00, 0x42, // MSB, LSB Message Identifier for Windscreen
            0x01,       // Message Type for Windscreen State

            0x01,       // Property Identifier for Wipers
            0x00, 0x01, // Property size 1 byte
            0x02,       // Windscreen wipers are set to automatic

            0x02,       // Property Identifier for Wipers Intensity
            0x00, 0x01, // Property size 1 byte
            0x03,       // Wipers are on highest intensity, indicating heavy rain

            0x03,       // Property Identifier for Windscreen Damage
            0x00, 0x01, // Property size 1 byte
            0x02,       // Small windscreen damage detected

            0x04,       // Property Identifier for Windscreen Zone Matrix
            0x00, 0x01, // Property size 1 byte
            0x43,       // Zone matrix is 4x3, in total 12 zones

            0x05,       // Property Identifier for Windscreen Damage Zone
            0x00, 0x01, // Property size 1 byte
            0x12,       // Damage position in leftmost horizontal zone, vertically in the center

            0x06,       // Property Identifier for Windscreen Needs Replacement
            0x00, 0x01, // Property size 1 byte
            0x02,       // Windscreen needs replacement

            0x07,       // Property Identifier for Windscreen Damage Confidence
            0x00, 0x01, // Property size 1 byte
            0x5f,       // Damage detected with 95% confidence

            0x08,       // Property Identifier for Windscreen Damage Detection Time
            0x00, 0x08, // Property size 8 byte
            0x11,       // Damage impact in 2017
            0x01,       // January
            0x0a,       // the 10th
            0x10,       // at 16h
            0x20,       // 32min
            0x05,       // 5 seconds
            0x00, 0x78  // 0 min UTC time offset
        ]

        guard let windscreen = AutoAPI.parseBinary(bytes) as? AAWindscreen else {
            return XCTFail("Parsed value is not Windscreen")
        }

        XCTAssertEqual(windscreen.wipersState, .automatic)
        XCTAssertEqual(windscreen.wipersIntensity, .highest)
        XCTAssertEqual(windscreen.damage, .small)
        XCTAssertEqual(windscreen.needsReplacement, .yes)
        XCTAssertEqual(windscreen.damageConfidence, 95)

        XCTAssertEqual(windscreen.zoneMatrix?.horisontal, 4)
        XCTAssertEqual(windscreen.zoneMatrix?.vertical, 3)

        XCTAssertEqual(windscreen.damageZone?.horisontal, 1)
        XCTAssertEqual(windscreen.damageZone?.vertical, 2)

        XCTAssertEqual(windscreen.damageDetectionTime?.year, 2017)
        XCTAssertEqual(windscreen.damageDetectionTime?.month, 1)
        XCTAssertEqual(windscreen.damageDetectionTime?.day, 10)
        XCTAssertEqual(windscreen.damageDetectionTime?.hour, 16)
        XCTAssertEqual(windscreen.damageDetectionTime?.minute, 32)
        XCTAssertEqual(windscreen.damageDetectionTime?.second, 5)
        XCTAssertEqual(windscreen.damageDetectionTime?.offset, 120)
    }
}
