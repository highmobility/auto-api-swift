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
//  AARemoteControlTest.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import AutoAPI
import XCTest


class AARemoteControlTest: XCTestCase {

    // MARK: State Properties

    func testAngle() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x27, 0x01, 0x02, 0x00, 0x05, 0x01, 0x00, 0x02, 0x00, 0x32]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AARemoteControl else {
            return XCTFail("Could not parse bytes as AARemoteControl")
        }
    
        XCTAssertEqual(capability.angle?.value, 50)
    }

    func testControlMode() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x27, 0x01, 0x01, 0x00, 0x04, 0x01, 0x00, 0x01, 0x02]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AARemoteControl else {
            return XCTFail("Could not parse bytes as AARemoteControl")
        }
    
        XCTAssertEqual(capability.controlMode?.value, .started)
    }

    
    // MARK: Getters

    func testGetControlState() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x27, 0x00]
    
        XCTAssertEqual(bytes, AARemoteControl.getControlState())
    }

    
    // MARK: Non-state Properties

    func testSpeed() {
        let bytes: Array<UInt8> = [0x03, 0x00, 0x04, 0x01, 0x00, 0x01, 0x05]
    
        guard let property: AAProperty<Int8> = AAOpaqueProperty(bytes: bytes)?.property() else {
            return XCTFail("Could not create a property for .speed")
        }
    
        XCTAssertEqual(property.value, 5)
    }

    
    // MARK: Setters

    func testControlCommand() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x27, 0x01] + [0x02, 0x00, 0x05, 0x01, 0x00, 0x02, 0x00, 0x32, 0x03, 0x00, 0x04, 0x01, 0x00, 0x01, 0x05]
        let setterBytes = AARemoteControl.controlCommand(angle: 50, speed: 5)
    
        XCTAssertEqual(bytes, setterBytes)
    }

    func testStartControl() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x27, 0x01] + [0x01, 0x00, 0x04, 0x01, 0x00, 0x01, 0x02]
        let setterBytes = AARemoteControl.startControl()
    
        XCTAssertEqual(bytes, setterBytes)
    }

    func testStopControl() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x27, 0x01] + [0x01, 0x00, 0x04, 0x01, 0x00, 0x01, 0x05]
        let setterBytes = AARemoteControl.stopControl()
    
        XCTAssertEqual(bytes, setterBytes)
    }
}