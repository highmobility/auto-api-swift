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
//  AADashboardLightsTest.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import AutoAPI
import XCTest


class AADashboardLightsTest: XCTestCase {

    // MARK: State Properties

    func testDashboardLights() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x61, 0x01, 0x01, 0x00, 0x05, 0x01, 0x00, 0x02, 0x00, 0x00, 0x01, 0x00, 0x05, 0x01, 0x00, 0x02, 0x01, 0x00, 0x01, 0x00, 0x05, 0x01, 0x00, 0x02, 0x02, 0x01, 0x01, 0x00, 0x05, 0x01, 0x00, 0x02, 0x03, 0x00, 0x01, 0x00, 0x05, 0x01, 0x00, 0x02, 0x04, 0x00, 0x01, 0x00, 0x05, 0x01, 0x00, 0x02, 0x05, 0x00, 0x01, 0x00, 0x05, 0x01, 0x00, 0x02, 0x06, 0x00, 0x01, 0x00, 0x05, 0x01, 0x00, 0x02, 0x07, 0x00, 0x01, 0x00, 0x05, 0x01, 0x00, 0x02, 0x08, 0x00, 0x01, 0x00, 0x05, 0x01, 0x00, 0x02, 0x09, 0x00, 0x01, 0x00, 0x05, 0x01, 0x00, 0x02, 0x0a, 0x00, 0x01, 0x00, 0x05, 0x01, 0x00, 0x02, 0x0b, 0x00, 0x01, 0x00, 0x05, 0x01, 0x00, 0x02, 0x0c, 0x00, 0x01, 0x00, 0x05, 0x01, 0x00, 0x02, 0x0d, 0x00, 0x01, 0x00, 0x05, 0x01, 0x00, 0x02, 0x0e, 0x00, 0x01, 0x00, 0x05, 0x01, 0x00, 0x02, 0x0f, 0x03, 0x01, 0x00, 0x05, 0x01, 0x00, 0x02, 0x10, 0x00, 0x01, 0x00, 0x05, 0x01, 0x00, 0x02, 0x11, 0x00, 0x01, 0x00, 0x05, 0x01, 0x00, 0x02, 0x12, 0x00, 0x01, 0x00, 0x05, 0x01, 0x00, 0x02, 0x13, 0x00, 0x01, 0x00, 0x05, 0x01, 0x00, 0x02, 0x14, 0x00, 0x01, 0x00, 0x05, 0x01, 0x00, 0x02, 0x15, 0x02, 0x01, 0x00, 0x05, 0x01, 0x00, 0x02, 0x16, 0x00, 0x01, 0x00, 0x05, 0x01, 0x00, 0x02, 0x17, 0x00, 0x01, 0x00, 0x05, 0x01, 0x00, 0x02, 0x18, 0x00, 0x01, 0x00, 0x05, 0x01, 0x00, 0x02, 0x19, 0x00, 0x01, 0x00, 0x05, 0x01, 0x00, 0x02, 0x1a, 0x00, 0x01, 0x00, 0x05, 0x01, 0x00, 0x02, 0x1b, 0x00, 0x01, 0x00, 0x05, 0x01, 0x00, 0x02, 0x1c, 0x00, 0x01, 0x00, 0x05, 0x01, 0x00, 0x02, 0x1d, 0x00, 0x01, 0x00, 0x05, 0x01, 0x00, 0x02, 0x1e, 0x00, 0x01, 0x00, 0x05, 0x01, 0x00, 0x02, 0x1f, 0x00, 0x01, 0x00, 0x05, 0x01, 0x00, 0x02, 0x20, 0x00, 0x01, 0x00, 0x05, 0x01, 0x00, 0x02, 0x21, 0x00, 0x01, 0x00, 0x05, 0x01, 0x00, 0x02, 0x22, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AADashboardLights else {
            return XCTFail("Could not parse bytes as AADashboardLights")
        }
    
        guard let dashboardLights = capability.dashboardLights?.compactMap({ $0.value }) else {
            return XCTFail("Could not extract .dashboardLights values")
        }
    
        XCTAssertTrue(dashboardLights.contains { $0 == AADashboardLight(name: .highBeam, state: .inactive) })
        XCTAssertTrue(dashboardLights.contains { $0 == AADashboardLight(name: .lowBeam, state: .inactive) })
        XCTAssertTrue(dashboardLights.contains { $0 == AADashboardLight(name: .hazardWarning, state: .info) })
        XCTAssertTrue(dashboardLights.contains { $0 == AADashboardLight(name: .brakeFailure, state: .inactive) })
        XCTAssertTrue(dashboardLights.contains { $0 == AADashboardLight(name: .hatchOpen, state: .inactive) })
        XCTAssertTrue(dashboardLights.contains { $0 == AADashboardLight(name: .fuelLevel, state: .inactive) })
        XCTAssertTrue(dashboardLights.contains { $0 == AADashboardLight(name: .engineCoolantTemperature, state: .inactive) })
        XCTAssertTrue(dashboardLights.contains { $0 == AADashboardLight(name: .batteryChargingCondition, state: .inactive) })
        XCTAssertTrue(dashboardLights.contains { $0 == AADashboardLight(name: .engineOil, state: .inactive) })
        XCTAssertTrue(dashboardLights.contains { $0 == AADashboardLight(name: .positionLights, state: .inactive) })
        XCTAssertTrue(dashboardLights.contains { $0 == AADashboardLight(name: .frontFogLight, state: .inactive) })
        XCTAssertTrue(dashboardLights.contains { $0 == AADashboardLight(name: .rearFogLight, state: .inactive) })
        XCTAssertTrue(dashboardLights.contains { $0 == AADashboardLight(name: .parkHeating, state: .inactive) })
        XCTAssertTrue(dashboardLights.contains { $0 == AADashboardLight(name: .engineIndicator, state: .inactive) })
        XCTAssertTrue(dashboardLights.contains { $0 == AADashboardLight(name: .serviceCall, state: .inactive) })
        XCTAssertTrue(dashboardLights.contains { $0 == AADashboardLight(name: .transmissionFluidTemperature, state: .red) })
        XCTAssertTrue(dashboardLights.contains { $0 == AADashboardLight(name: .transmissionFailure, state: .inactive) })
        XCTAssertTrue(dashboardLights.contains { $0 == AADashboardLight(name: .antiLockBrakeFailure, state: .inactive) })
        XCTAssertTrue(dashboardLights.contains { $0 == AADashboardLight(name: .wornBrakeLinings, state: .inactive) })
        XCTAssertTrue(dashboardLights.contains { $0 == AADashboardLight(name: .windscreenWasherFluid, state: .inactive) })
        XCTAssertTrue(dashboardLights.contains { $0 == AADashboardLight(name: .tireFailure, state: .inactive) })
        XCTAssertTrue(dashboardLights.contains { $0 == AADashboardLight(name: .engineOilLevel, state: .yellow) })
        XCTAssertTrue(dashboardLights.contains { $0 == AADashboardLight(name: .engineCoolantLevel, state: .inactive) })
        XCTAssertTrue(dashboardLights.contains { $0 == AADashboardLight(name: .steeringFailure, state: .inactive) })
        XCTAssertTrue(dashboardLights.contains { $0 == AADashboardLight(name: .escIndication, state: .inactive) })
        XCTAssertTrue(dashboardLights.contains { $0 == AADashboardLight(name: .brakeLights, state: .inactive) })
        XCTAssertTrue(dashboardLights.contains { $0 == AADashboardLight(name: .adblueLevel, state: .inactive) })
        XCTAssertTrue(dashboardLights.contains { $0 == AADashboardLight(name: .fuelFilterDiffPressure, state: .inactive) })
        XCTAssertTrue(dashboardLights.contains { $0 == AADashboardLight(name: .seatBelt, state: .inactive) })
        XCTAssertTrue(dashboardLights.contains { $0 == AADashboardLight(name: .advancedBraking, state: .inactive) })
        XCTAssertTrue(dashboardLights.contains { $0 == AADashboardLight(name: .acc, state: .inactive) })
        XCTAssertTrue(dashboardLights.contains { $0 == AADashboardLight(name: .trailerConnected, state: .inactive) })
        XCTAssertTrue(dashboardLights.contains { $0 == AADashboardLight(name: .airbag, state: .inactive) })
        XCTAssertTrue(dashboardLights.contains { $0 == AADashboardLight(name: .escSwitchedOff, state: .inactive) })
        XCTAssertTrue(dashboardLights.contains { $0 == AADashboardLight(name: .laneDepartureWarningOff, state: .inactive) })
    }

    
    // MARK: Getters

    func testGetDashboardLights() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x61, 0x00]
    
        XCTAssertEqual(bytes, AADashboardLights.getDashboardLights())
    }
}