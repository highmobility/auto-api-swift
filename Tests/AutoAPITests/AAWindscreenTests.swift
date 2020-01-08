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
//  AAWindscreenTest.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import AutoAPI
import XCTest


class AAWindscreenTest: XCTestCase {

    // MARK: State Properties

    func testWindscreenZoneMatrix() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x42, 0x01, 0x04, 0x00, 0x05, 0x01, 0x00, 0x02, 0x04, 0x03]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAWindscreen else {
            return XCTFail("Could not parse bytes as AAWindscreen")
        }
    
        XCTAssertEqual(capability.windscreenZoneMatrix?.value, AAZone(horizontal: 4, vertical: 3))
    }

    func testWindscreenDamageConfidence() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x42, 0x01, 0x07, 0x00, 0x0b, 0x01, 0x00, 0x08, 0x3f, 0xee, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAWindscreen else {
            return XCTFail("Could not parse bytes as AAWindscreen")
        }
    
        XCTAssertEqual(capability.windscreenDamageConfidence?.value, 0.95)
    }

    func testWipersIntensity() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x42, 0x01, 0x02, 0x00, 0x04, 0x01, 0x00, 0x01, 0x03]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAWindscreen else {
            return XCTFail("Could not parse bytes as AAWindscreen")
        }
    
        XCTAssertEqual(capability.wipersIntensity?.value, .level3)
    }

    func testWipersStatus() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x42, 0x01, 0x01, 0x00, 0x04, 0x01, 0x00, 0x01, 0x02]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAWindscreen else {
            return XCTFail("Could not parse bytes as AAWindscreen")
        }
    
        XCTAssertEqual(capability.wipersStatus?.value, .automatic)
    }

    func testWindscreenDamageZone() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x42, 0x01, 0x05, 0x00, 0x05, 0x01, 0x00, 0x02, 0x01, 0x02]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAWindscreen else {
            return XCTFail("Could not parse bytes as AAWindscreen")
        }
    
        XCTAssertEqual(capability.windscreenDamageZone?.value, AAZone(horizontal: 1, vertical: 2))
    }

    func testWindscreenDamageDetectionTime() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x42, 0x01, 0x08, 0x00, 0x0b, 0x01, 0x00, 0x08, 0x00, 0x00, 0x01, 0x59, 0x89, 0x38, 0xe7, 0x88]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAWindscreen else {
            return XCTFail("Could not parse bytes as AAWindscreen")
        }
    
        XCTAssertEqual(capability.windscreenDamageDetectionTime?.value, DateFormatter.hmFormatter.date(from: "2017-01-10T16:32:05.000Z")!)
    }

    func testWindscreenDamage() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x42, 0x01, 0x03, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAWindscreen else {
            return XCTFail("Could not parse bytes as AAWindscreen")
        }
    
        XCTAssertEqual(capability.windscreenDamage?.value, .impactButNoDamageDetected)
    }

    func testWindscreenNeedsReplacement() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x42, 0x01, 0x06, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAWindscreen else {
            return XCTFail("Could not parse bytes as AAWindscreen")
        }
    
        XCTAssertEqual(capability.windscreenNeedsReplacement?.value, .noReplacementNeeded)
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