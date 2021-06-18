//
//  The MIT License
//
//  Copyright (c) 2014- High-Mobility GmbH (https://high-mobility.com)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//
//
//  DashboardLightsTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 24/04/2018.
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

        guard let dashboardLights = AAAutoAPI.parseBinary(bytes) as? DashboardLights else {
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
