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
//  AAHonkHornFlashLightsTest.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/01/2020.
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

    func testFlashTimes() {
        let bytes: Array<UInt8> = [0x03, 0x00, 0x04, 0x01, 0x00, 0x01, 0x05]
    
        guard let property: AAProperty<UInt8> = AAOpaqueProperty(bytes: bytes)?.property() else {
            return XCTFail("Could not create a property for .flashTimes")
        }
    
        XCTAssertEqual(property.value, 5)
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