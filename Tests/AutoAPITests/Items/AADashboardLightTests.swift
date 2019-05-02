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
//  AADashboardLightTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 03/04/2019.
//  Copyright © 2019 High Mobility GmbH. All rights reserved.
//

@testable import AutoAPI
import XCTest


class AADashboardLightTests: XCTestCase {

    static var allTests = [("testBytes", testBytes),
                           ("testInit", testInit)]


    // MARK: XCTestCase

    func testBytes() {
        let bytes: [UInt8] = [
            0x0F,   // Transmission fluid temperature
            0x03    // Red
        ]

        XCTAssertEqual(AADashboardLight(name: .transmissionFluidTemperature, state: .red).bytes, bytes)
    }

    func testInit() {
        // Successful
        let bytes1: [UInt8] = [
            0x0F,   // Transmission fluid temperature
            0x03    // Red
        ]

        if let light = AADashboardLight(bytes: bytes1) {
            XCTAssertEqual(light.name, .transmissionFluidTemperature)
            XCTAssertEqual(light.state, .red)
        }
        else {
            XCTFail("Failed to initialise AADashboardLight")
        }

        // Fail#1
        let bytes2: [UInt8] = [
            0x01    // Invalid bytes count
        ]

        XCTAssertNil(AADashboardLight(bytes: bytes2))

        // Fail#2
        let bytes3: [UInt8] = [
            0x0F,   // Transmission fluid temperature
            0xF3    // INVALID
        ]

        XCTAssertNil(AADashboardLight(bytes: bytes3))
    }
}
