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
//  AAWeatherConditionsTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 07/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import AutoAPI
import XCTest


class AAWeatherConditionsTests: XCTestCase {

    static var allTests = [("testGetState", testGetState),
                           ("testState", testState)]


    // MARK: XCTestCase

    func testGetState() {
        let bytes: [UInt8] = [
            0x00, 0x55, // MSB, LSB Message Identifier for Weather Conditions
            0x00        // Message Type for Get Weather Conditions
        ]

        XCTAssertEqual(AAWeatherConditions.getConditions.bytes, bytes)
    }

    func testState() {
        let bytes: [UInt8] = [
            0x00, 0x55, // MSB, LSB Message Identifier for Weather Conditions
            0x01,       // Message Type for Weather Conditions State

            0x01,       // Property Identifier for Rain intensity
            0x00, 0x0B, // Property size 11 bytes
            0x01,       // Data component
            0x00, 0x08, // Data component size 8 bytes
            0x3F, 0xF0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00  // 100% (maximum rain)
        ]

        guard let weatherConditions = AAAutoAPI.parseBinary(bytes) as? AAWeatherConditions else {
            return XCTFail("Parsed value is not AAWeatherConditions")
        }

        XCTAssertEqual(weatherConditions.rainIntensity?.value, 1.0)
    }
}
