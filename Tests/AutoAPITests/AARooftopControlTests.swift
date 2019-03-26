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
//  AARooftopControlTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 01/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import AutoAPI
import XCTest


class AARooftopControlTests: XCTestCase {

    static var allTests = [("testGetState", testGetState),
                           ("testControlRooftop", testControlRooftop),
                           ("testState", testState)]


    // MARK: XCTestCase

    func testGetState() {
        let bytes: [UInt8] = [
            0x00, 0x25, // MSB, LSB Message Identifier for Rooftop Control
            0x00        // Message Type for Get Rooftop State
        ]

        XCTAssertEqual(AARooftopControl.getRooftopState.bytes, bytes)
    }

    func testControlRooftop() {
        let bytes: [UInt8] = [
            0x00, 0x25, // MSB, LSB Message Identifier for Rooftop Control
            0x12,       // Message Type for Control Rooftop

            0x01,       // Property Identifier for Dimming
            0x00, 0x0B, // Property size is 11 bytes
            0x01,       // Data component identifier
            0x00, 0x08, // Data component size is 8 bytes
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, // Make rooftop transparent

            0x02,       // Property Identifier for Position
            0x00, 0x0B, // Property size is 11 bytes
            0x01,       // Data component identifier
            0x00, 0x08, // Data component size is 8 bytes
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, // Close Rooftop

            0x03,       // Property Identifier for Convertible roof state
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Data component size is 1 bytes
            0x00,       // Close Convertible

            0x04,       // Property Identifier for Sunroof roof state
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Data component size is 1 bytes
            0x01        // Tilt Sunroof
        ]

        let control = AARooftopControl.controlRooftop(dimming: 0.0, open: 0.0, convertibleRoof: .closed, sunroofTilt: .tilted, sunroofState: nil)

        XCTAssertEqual(control.bytes, bytes)
    }

    func testState() {
        let bytes: [UInt8] = [
            0x00, 0x25, // MSB, LSB Message Identifier for Rooftop Control
            0x01,       // Message Type for Rooftop State

            0x01,       // Property identifier for Dimming
            0x00, 0x0B, // Property size is 11 bytes
            0x01,       // Data component identifier
            0x00, 0x08, // Data component size is 8 bytes
            0x3F, 0xF0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, // Rooftop is opaque (100%)

            0x02,       // Property identifier for Position
            0x00, 0x0B, // Property size is 11 bytes
            0x01,       // Data component identifier
            0x00, 0x08, // Data component size is 8 bytes
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, // Rooftop is fully closed (0%)

            0x03,       // Property identifier for Convertible roof state
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Data component size is 1 bytes
            0x01,       // Convertible roof is open

            0x04,       // Property identifier for Sunroof tilt state
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Data component size is 1 bytes
            0x02,       // Sunroof is half-tilted

            0x05,       // Property identifier for Sunroof state
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Data component size is 1 bytes
            0x01        // Sunroof is open
        ]

        guard let rooftopControl = AAAutoAPI.parseBinary(bytes) as? AARooftopControl else {
            return XCTFail("Parsed value is not AARooftopControl")
        }

        XCTAssertEqual(rooftopControl.dimming?.value, 1.0)
        XCTAssertEqual(rooftopControl.position?.value, 0.0)
        XCTAssertEqual(rooftopControl.convertibleRoofState?.value, .open)
        XCTAssertEqual(rooftopControl.sunroofTiltState?.value, .halfTilted)
        XCTAssertEqual(rooftopControl.sunroofState?.value, .open)
    }
}
