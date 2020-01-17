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
//  AAWindscreenTest.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import AutoAPI
import XCTest


class AAWindscreenTest: XCTestCase {

    // MARK: State Properties

    func testWindscreenDamageConfidence() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x42, 0x01, 0x07, 0x00, 0x0b, 0x01, 0x00, 0x08, 0x3f, 0xee, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAWindscreen else {
            return XCTFail("Could not parse bytes as AAWindscreen")
        }
    
        XCTAssertEqual(capability.windscreenDamageConfidence?.value, 0.95)
    }

    func testWindscreenNeedsReplacement() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x42, 0x01, 0x06, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAWindscreen else {
            return XCTFail("Could not parse bytes as AAWindscreen")
        }
    
        XCTAssertEqual(capability.windscreenNeedsReplacement?.value, .noReplacementNeeded)
    }

    func testWindscreenDamageDetectionTime() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x42, 0x01, 0x08, 0x00, 0x0b, 0x01, 0x00, 0x08, 0x00, 0x00, 0x01, 0x59, 0x89, 0x38, 0xe7, 0x88]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAWindscreen else {
            return XCTFail("Could not parse bytes as AAWindscreen")
        }
    
        XCTAssertEqual(capability.windscreenDamageDetectionTime?.value, DateFormatter.hmFormatter.date(from: "2017-01-10T16:32:05.000Z")!)
    }

    func testWindscreenDamageZone() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x42, 0x01, 0x05, 0x00, 0x05, 0x01, 0x00, 0x02, 0x01, 0x02]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAWindscreen else {
            return XCTFail("Could not parse bytes as AAWindscreen")
        }
    
        XCTAssertEqual(capability.windscreenDamageZone?.value, AAZone(horizontal: 1, vertical: 2))
    }

    func testWindscreenZoneMatrix() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x42, 0x01, 0x04, 0x00, 0x05, 0x01, 0x00, 0x02, 0x04, 0x03]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAWindscreen else {
            return XCTFail("Could not parse bytes as AAWindscreen")
        }
    
        XCTAssertEqual(capability.windscreenZoneMatrix?.value, AAZone(horizontal: 4, vertical: 3))
    }

    func testWipersStatus() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x42, 0x01, 0x01, 0x00, 0x04, 0x01, 0x00, 0x01, 0x02]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAWindscreen else {
            return XCTFail("Could not parse bytes as AAWindscreen")
        }
    
        XCTAssertEqual(capability.wipersStatus?.value, .automatic)
    }

    func testWipersIntensity() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x42, 0x01, 0x02, 0x00, 0x04, 0x01, 0x00, 0x01, 0x03]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAWindscreen else {
            return XCTFail("Could not parse bytes as AAWindscreen")
        }
    
        XCTAssertEqual(capability.wipersIntensity?.value, .level3)
    }

    func testWindscreenDamage() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x42, 0x01, 0x03, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAWindscreen else {
            return XCTFail("Could not parse bytes as AAWindscreen")
        }
    
        XCTAssertEqual(capability.windscreenDamage?.value, .impactButNoDamageDetected)
    }

    
    // MARK: Getters

    func testGetWindscreenState() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x42, 0x00]
    
        XCTAssertEqual(bytes, AAWindscreen.getWindscreenState())
    }
    
    func testGetWindscreenProperties() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x42, 0x00, 0x08]
        let getterBytes = AAWindscreen.getWindscreenProperties(propertyIDs: .windscreenDamageDetectionTime)
    
        XCTAssertEqual(bytes, getterBytes)
    }

    
    // MARK: Setters

    func testSetWindscreenDamage() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x42, 0x01] + [0x03, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01, 0x05, 0x00, 0x05, 0x01, 0x00, 0x02, 0x01, 0x02]
        let setterBytes = AAWindscreen.setWindscreenDamage(windscreenDamage: .impactButNoDamageDetected, windscreenDamageZone: AAZone(horizontal: 1, vertical: 2))
    
        XCTAssertEqual(bytes, setterBytes)
    }

    func testSetWindscreenReplacementNeeded() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x42, 0x01] + [0x06, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
        let setterBytes = AAWindscreen.setWindscreenReplacementNeeded(windscreenNeedsReplacement: .noReplacementNeeded)
    
        XCTAssertEqual(bytes, setterBytes)
    }

    func testControlWipers() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x42, 0x01] + [0x01, 0x00, 0x04, 0x01, 0x00, 0x01, 0x02, 0x02, 0x00, 0x04, 0x01, 0x00, 0x01, 0x03]
        let setterBytes = AAWindscreen.controlWipers(wipersStatus: .automatic, wipersIntensity: .level3)
    
        XCTAssertEqual(bytes, setterBytes)
    }
}