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
//  AAWindscreenTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 05/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import AutoAPI
import XCTest


class AAWindscreenTests: XCTestCase {

    static var allTests = [("testGetState", testGetState),
                           ("testSetNeedsReplacement", testSetNeedsReplacement),
                           ("testSetWindscreenDamage", testSetWindscreenDamage),
                           ("testState", testState)]


    // MARK: XCTestCase

    func testControlWipers() {
        let bytes: [UInt8] = [
            0x00, 0x42, // MSB, LSB Message Identifier for Windscreen
            0x14,       // Message Type for Control Wipers

            0x01,       // Propery Identifier for Wipers state
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Data component size is 1 bytes
            0x01,       // Activate wipers

            0x02,       // Propery Identifier for Intensity
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Data component size is 1 bytes
            0x02        // Level 2 intensity
        ]

        XCTAssertEqual(AAWindscreen.controlWipers(.active, intensity: .level2).bytes, bytes)
    }

    func testGetState() {
        let bytes: [UInt8] = [
            0x00, 0x42, // MSB, LSB Message Identifier for Windscreen
            0x00        // Message Type for Get Windscreen State
        ]

        XCTAssertEqual(AAWindscreen.getWindscreenState.bytes, bytes)
    }

    func testSetNeedsReplacement() {
        let bytes: [UInt8] = [
            0x00, 0x42, // MSB, LSB Message Identifier for Windscreen
            0x13,       // Message Type for Set Windscreen Replacement Needed

            0x01,       // Propery Identifier for Replacement needed
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Data component size is 1 bytes
            0x01        // No replacement needed
        ]

        XCTAssertEqual(AAWindscreen.setNeedsReplacement(.no).bytes, bytes)
    }

    func testSetWindscreenDamage() {
        let bytes: [UInt8] = [
            0x00, 0x42, // MSB, LSB Message Identifier for Windscreen
            0x12,       // Message Type for Set Windscreen Damage

            0x01,       // Propery Identifier for Windscreen Damage
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Data component size is 1 bytes
            0x01,       // Impact, but no damage detected

            0x02,       // Propery Identifier for Windscreen Damage Zone
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Data component size is 1 bytes
            0x23        // Damage is positioned 2 units from the left, 3 units from the top
        ]

        XCTAssertEqual(AAWindscreen.setDamage(.impactButNoDamageDetected, in: AAZone(horisontal: 2, vertical: 3)).bytes, bytes)
    }

    func testState() {
        let bytes: [UInt8] = [
            0x00, 0x42, // MSB, LSB Message Identifier for Windscreen
            0x01,       // Message Type for Windscreen State

            0x01,       // Property identifier for Wipers
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Data component size is 1 bytes
            0x02,       // Windscreen wipers are set to automatic

            0x02,       // Property identifier for Wipers intensity
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Data component size is 1 bytes
            0x03,       // Wipers are on highest intensity, indicating heavy rain

            0x03,       // Property identifier for Windscreen damage
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Data component size is 1 bytes
            0x01,       // Impact, but no damage detected

            0x04,       // Property identifier for Windscreen zone matrix
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Data component size is 1 bytes
            0x43,       // Zone matrix is 4x3, in total 12 zones

            0x05,       // Property identifier for Windscreen damage zone
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Data component size is 1 bytes
            0x12,       // Damage position in horizontally leftmost zone, vertically in the center

            0x06,       // Property identifier for Windscreen needs replacement
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Data component size is 1 bytes
            0x02,       // Windscreen needs replacement

            0x07,       // Property identifier for Windscreen damage confidence
            0x00, 0x0B, // Property size is 11 bytes
            0x01,       // Data component identifier
            0x00, 0x08, // Data component size is 8 bytes
            0x3F, 0xEE, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, // Damage detected with 95% confidence

            0x08,       // Property identifier for Windscreen damage detection time
            0x00, 0x0B, // Property size is 11 bytes
            0x01,       // Data component identifier
            0x00, 0x08, // Data component size is 8 bytes
            0x00, 0x00, 0x01, 0x59, 0x89, 0x38, 0xE7, 0x88  // 10 January 2017 at 16:32:05 UTC
        ]

        guard let windscreen = AAAutoAPI.parseBinary(bytes) as? AAWindscreen else {
            return XCTFail("Parsed value is not AAWindscreen")
        }

        XCTAssertEqual(windscreen.wipersState?.value, .automatic)
        XCTAssertEqual(windscreen.wipersIntensity?.value, .highest)
        XCTAssertEqual(windscreen.damage?.value, .impactButNoDamageDetected)
        XCTAssertEqual(windscreen.zoneMatrix?.value, AAZone(horisontal: 4, vertical: 3))
        XCTAssertEqual(windscreen.damageZone?.value, AAZone(horisontal: 1, vertical: 2))
        XCTAssertEqual(windscreen.needsReplacement?.value, .yes)
        XCTAssertEqual(windscreen.damageConfidence?.value, 0.95)
        XCTAssertEqual(windscreen.damageDetectionTime?.value, Date(timeIntervalSince1970: 1_484_065_925.0))
    }
}
