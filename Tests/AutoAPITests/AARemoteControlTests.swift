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
//  AARemoteControlTest.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/01/2020.
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