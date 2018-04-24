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
//  DashboardLightsTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 24/04/2018.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import AutoAPI
import XCTest


class DashboardLightsTests: XCTestCase {

    static var allTests = [("testGetState", testGetState),
                           ("testLights", testLights)]
    

    // MARK: XCTestCase

    func testGetState() {
        let bytes: [UInt8] = [
            0x00, 0x61, // MSB, LSB Message Identifier for Dashboard Lights
            0x00        // Message Type for Get Dashboard Lights
        ]

        XCTAssertEqual(DashboardLights.getDashboardLights, bytes)
    }

    func testLights() {
        let bytes: [UInt8] = [
            0x00, 0x61, // MSB, LSB Message Identifier for Dashboard Lights
            0x01,       // Message Type for Dashboard Lights

            0x01,       // Property identifier for Dashboard light
            0x00, 0x02, // Property size is 2 bytes
            0x00,       // High beam, main beam
            0x00,       // Inactive

            0x01,       // Property identifier for Dashboard light
            0x00, 0x02, // Property size is 2 bytes
            0x02,       // Hazard warning
            0x01,       // Info

            0x01,       // Property identifier for Dashboard light
            0x00, 0x02, // Property size is 2 bytes
            0x0F,       // Transmission fluid temperature
            0x03,       // Red

            0x01,       // Property identifier for Dashboard light
            0x00, 0x02, // Property size is 2 bytes
            0x15,       // Engine oil level
            0x00        // Inactive
        ]

        guard let dashboardLights = AutoAPI.parseBinary(bytes) as? DashboardLights else {
            return XCTFail("Parsed value is not DashboardLights")
        }

        XCTAssertEqual(dashboardLights.lights?.count, 4)

        if let theLight = dashboardLights.lights?.first(where: { $0.name == .highMainBeam }) {
            XCTAssertEqual(theLight.state, .inactive)
        }
        else {
            XCTFail("Lights doesn't contain High Beam, Main Beam")
        }

        if let theLight = dashboardLights.lights?.first(where: { $0.name == .hazardWarning }) {
            XCTAssertEqual(theLight.state, .info)
        }
        else {
            XCTFail("Lights doesn't contain Hazard Warning")
        }

        if let theLight = dashboardLights.lights?.first(where: { $0.name == .transmissionFluidTemperature }) {
            XCTAssertEqual(theLight.state, .red)
        }
        else {
            XCTFail("Lights doesn't contain Transmission Fluid Temperature")
        }

        if let theLight = dashboardLights.lights?.first(where: { $0.name == .engineOilLevel }) {
            XCTAssertEqual(theLight.state, .inactive)
        }
        else {
            XCTFail("Lights doesn't contain Engine Oil Level")
        }
    }
}
