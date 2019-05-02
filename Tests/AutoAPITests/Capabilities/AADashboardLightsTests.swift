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
//  AADashboardLightsTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 24/04/2018.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import AutoAPI
import XCTest


class AADashboardLightsTests: XCTestCase {

    static var allTests = [("testGetState", testGetState),
                           ("testLights", testLights)]
    

    // MARK: XCTestCase

    func testGetState() {
        let bytes: [UInt8] = [
            0x00, 0x61, // MSB, LSB Message Identifier for Dashboard Lights
            0x00        // Message Type for Get Dashboard Lights
        ]

        XCTAssertEqual(AADashboardLights.getDashboardLights.bytes, bytes)
    }

    func testLights() {
        let bytes: [UInt8] = [
            0x00, 0x61, // MSB, LSB Message Identifier for Dashboard Lights
            0x01,       // Message Type for Dashboard Lights

            0x01,       // Property identifier for Dashboard light
            0x00, 0x05, // Property size is 5 bytes
            0x01,       // Data component
            0x00, 0x02, // Data component size is 2 bytes
            0x00,       // High beam, main beam
            0x00,       // Inactive

            0x01,       // Property identifier for Dashboard light
            0x00, 0x05, // Property size is 5 bytes
            0x01,       // Data component
            0x00, 0x02, // Data component size is 2 bytes
            0x02,       // Hazard warning
            0x01,       // Info

            0x01,       // Property identifier for Dashboard light
            0x00, 0x05, // Property size is 5 bytes
            0x01,       // Data component
            0x00, 0x02, // Data component size is 2 bytes
            0x0F,       // Transmission fluid temperature
            0x03,       // Red

            0x01,       // Property identifier for Dashboard light
            0x00, 0x05, // Property size is 5 bytes
            0x01,       // Data component
            0x00, 0x02, // Data component size is 2 bytes
            0x15,       // Engine oil level
            0x00        // Inactive
        ]

        guard let dashboardLights = AAAutoAPI.parseBinary(bytes) as? AADashboardLights else {
            return XCTFail("Parsed value is not AADashboardLights")
        }

        XCTAssertEqual(dashboardLights.lights?.count, 4)

        if let theLight = dashboardLights.lights?.first(where: { $0.value?.name == .highMainBeam }) {
            XCTAssertEqual(theLight.value?.state, .inactive)
        }
        else {
            XCTFail("Lights doesn't contain High Beam, Main Beam")
        }

        if let theLight = dashboardLights.lights?.first(where: { $0.value?.name == .hazardWarning }) {
            XCTAssertEqual(theLight.value?.state, .info)
        }
        else {
            XCTFail("Lights doesn't contain Hazard Warning")
        }

        if let theLight = dashboardLights.lights?.first(where: { $0.value?.name == .transmissionFluidTemperature }) {
            XCTAssertEqual(theLight.value?.state, .red)
        }
        else {
            XCTFail("Lights doesn't contain Transmission Fluid Temperature")
        }

        if let theLight = dashboardLights.lights?.first(where: { $0.value?.name == .engineOilLevel }) {
            XCTAssertEqual(theLight.value?.state, .inactive)
        }
        else {
            XCTFail("Lights doesn't contain Engine Oil Level")
        }
    }
}
