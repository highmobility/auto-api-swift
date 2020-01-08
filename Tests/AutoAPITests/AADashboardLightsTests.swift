//
// AutoAPI
// Copyright (C) 2020 High-Mobility GmbH
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
//  AADashboardLightsTest.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
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