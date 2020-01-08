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
//  AAHonkHornFlashLightsTest.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import AutoAPI
import XCTest


class AAHonkHornFlashLightsTest: XCTestCase {

    // MARK: State Properties

    func testFlashers() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x26, 0x01, 0x01, 0x00, 0x04, 0x01, 0x00, 0x01, 0x02]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAHonkHornFlashLights else {
            return XCTFail("Could not parse bytes as AAHonkHornFlashLights")
        }
    
        XCTAssertEqual(capability.flashers?.value, .leftFlasherActive)
    }

    
    // MARK: Getters

    func testGetFlashersState() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x26, 0x00]
    
        XCTAssertEqual(bytes, AAHonkHornFlashLights.getFlashersState())
    }

    
    // MARK: Non-state Properties

    func testFlashTimes() {
        let bytes: Array<UInt8> = [0x03, 0x00, 0x04, 0x01, 0x00, 0x01, 0x05]
    
        guard let property: AAProperty<UInt8> = AAOpaqueProperty(bytes: bytes)?.property() else {
            return XCTFail("Could not create a property for .flashTimes")
        }
    
        XCTAssertEqual(property.value, 5)
    }

    func testHonkSeconds() {
        let bytes: Array<UInt8> = [0x02, 0x00, 0x04, 0x01, 0x00, 0x01, 0x03]
    
        guard let property: AAProperty<UInt8> = AAOpaqueProperty(bytes: bytes)?.property() else {
            return XCTFail("Could not create a property for .honkSeconds")
        }
    
        XCTAssertEqual(property.value, 3)
    }

    func testEmergencyFlashersState() {
        let bytes: Array<UInt8> = [0x04, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
    
        guard let property: AAProperty<AAActiveState> = AAOpaqueProperty(bytes: bytes)?.property() else {
            return XCTFail("Could not create a property for .emergencyFlashersState")
        }
    
        XCTAssertEqual(property.value, .active)
    }

    
    // MARK: Setters

    func testHonkFlash() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x26, 0x01] + [0x02, 0x00, 0x04, 0x01, 0x00, 0x01, 0x03, 0x03, 0x00, 0x04, 0x01, 0x00, 0x01, 0x05]
        let setterBytes = AAHonkHornFlashLights.honkFlash(honkSeconds: 3, flashTimes: 5)
    
        XCTAssertEqual(bytes, setterBytes)
    }

    func testActivateDeactivateEmergencyFlasher() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x26, 0x01] + [0x04, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
        let setterBytes = AAHonkHornFlashLights.activateDeactivateEmergencyFlasher(emergencyFlashersState: .active)
    
        XCTAssertEqual(bytes, setterBytes)
    }
}