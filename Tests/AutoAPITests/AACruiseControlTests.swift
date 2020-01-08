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
//  AACruiseControlTest.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import AutoAPI
import XCTest


class AACruiseControlTest: XCTestCase {

    // MARK: State Properties

    func testLimiter() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x62, 0x01, 0x02, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AACruiseControl else {
            return XCTFail("Could not parse bytes as AACruiseControl")
        }
    
        XCTAssertEqual(capability.limiter?.value, .higherSpeedRequested)
    }

    func testCruiseControl() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x62, 0x01, 0x01, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AACruiseControl else {
            return XCTFail("Could not parse bytes as AACruiseControl")
        }
    
        XCTAssertEqual(capability.cruiseControl?.value, .active)
    }

    func testAdaptiveCruiseControl() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x62, 0x01, 0x04, 0x00, 0x04, 0x01, 0x00, 0x01, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AACruiseControl else {
            return XCTFail("Could not parse bytes as AACruiseControl")
        }
    
        XCTAssertEqual(capability.adaptiveCruiseControl?.value, .inactive)
    }

    func testAccTargetSpeed() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x62, 0x01, 0x05, 0x00, 0x05, 0x01, 0x00, 0x02, 0x00, 0x43]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AACruiseControl else {
            return XCTFail("Could not parse bytes as AACruiseControl")
        }
    
        XCTAssertEqual(capability.accTargetSpeed?.value, 67)
    }

    func testTargetSpeed() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x62, 0x01, 0x03, 0x00, 0x05, 0x01, 0x00, 0x02, 0x00, 0x3d]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AACruiseControl else {
            return XCTFail("Could not parse bytes as AACruiseControl")
        }
    
        XCTAssertEqual(capability.targetSpeed?.value, 61)
    }

    
    // MARK: Getters

    func testGetCruiseControlState() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x62, 0x00]
    
        XCTAssertEqual(bytes, AACruiseControl.getCruiseControlState())
    }
    
    func testGetCruiseControlProperties() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x62, 0x00, 0x05]
        let getterBytes = AACruiseControl.getCruiseControlProperties(propertyIDs: .accTargetSpeed)
    
        XCTAssertEqual(bytes, getterBytes)
    }

    
    // MARK: Setters

    func testActivateDeactivateCruiseControl() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x62, 0x01] + [0x01, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01, 0x03, 0x00, 0x05, 0x01, 0x00, 0x02, 0x00, 0x3d]
        let setterBytes = AACruiseControl.activateDeactivateCruiseControl(cruiseControl: .active, targetSpeed: 61)
    
        XCTAssertEqual(bytes, setterBytes)
    }
}