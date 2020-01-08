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
//  AALightsTest.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import AutoAPI
import XCTest


class AALightsTest: XCTestCase {

    // MARK: State Properties

    func testAmbientLightColour() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x36, 0x01, 0x04, 0x00, 0x06, 0x01, 0x00, 0x03, 0xff, 0x00, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AALights else {
            return XCTFail("Could not parse bytes as AALights")
        }
    
        XCTAssertEqual(capability.ambientLightColour?.value, AARGBColour(red: 255, green: 0, blue: 0))
    }

    func testInteriorLights() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x36, 0x01, 0x09, 0x00, 0x05, 0x01, 0x00, 0x02, 0x00, 0x00, 0x09, 0x00, 0x05, 0x01, 0x00, 0x02, 0x01, 0x01]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AALights else {
            return XCTFail("Could not parse bytes as AALights")
        }
    
        guard let interiorLights = capability.interiorLights?.compactMap({ $0.value }) else {
            return XCTFail("Could not extract .interiorLights values")
        }
    
        XCTAssertTrue(interiorLights.contains { $0 == AALight(location: .front, state: .inactive) })
        XCTAssertTrue(interiorLights.contains { $0 == AALight(location: .rear, state: .active) })
    }

    func testFrontExteriorLight() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x36, 0x01, 0x01, 0x00, 0x04, 0x01, 0x00, 0x01, 0x02]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AALights else {
            return XCTFail("Could not parse bytes as AALights")
        }
    
        XCTAssertEqual(capability.frontExteriorLight?.value, .activeWithFullBeam)
    }

    func testReverseLight() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x36, 0x01, 0x05, 0x00, 0x04, 0x01, 0x00, 0x01, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AALights else {
            return XCTFail("Could not parse bytes as AALights")
        }
    
        XCTAssertEqual(capability.reverseLight?.value, .inactive)
    }

    func testFogLights() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x36, 0x01, 0x07, 0x00, 0x05, 0x01, 0x00, 0x02, 0x00, 0x00, 0x07, 0x00, 0x05, 0x01, 0x00, 0x02, 0x01, 0x01]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AALights else {
            return XCTFail("Could not parse bytes as AALights")
        }
    
        guard let fogLights = capability.fogLights?.compactMap({ $0.value }) else {
            return XCTFail("Could not extract .fogLights values")
        }
    
        XCTAssertTrue(fogLights.contains { $0 == AALight(location: .front, state: .inactive) })
        XCTAssertTrue(fogLights.contains { $0 == AALight(location: .rear, state: .active) })
    }

    func testEmergencyBrakeLight() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x36, 0x01, 0x06, 0x00, 0x04, 0x01, 0x00, 0x01, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AALights else {
            return XCTFail("Could not parse bytes as AALights")
        }
    
        XCTAssertEqual(capability.emergencyBrakeLight?.value, .inactive)
    }

    func testRearExteriorLight() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x36, 0x01, 0x02, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AALights else {
            return XCTFail("Could not parse bytes as AALights")
        }
    
        XCTAssertEqual(capability.rearExteriorLight?.value, .active)
    }

    func testReadingLamps() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x36, 0x01, 0x08, 0x00, 0x05, 0x01, 0x00, 0x02, 0x00, 0x01, 0x08, 0x00, 0x05, 0x01, 0x00, 0x02, 0x01, 0x01, 0x08, 0x00, 0x05, 0x01, 0x00, 0x02, 0x02, 0x00, 0x08, 0x00, 0x05, 0x01, 0x00, 0x02, 0x03, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AALights else {
            return XCTFail("Could not parse bytes as AALights")
        }
    
        guard let readingLamps = capability.readingLamps?.compactMap({ $0.value }) else {
            return XCTFail("Could not extract .readingLamps values")
        }
    
        XCTAssertTrue(readingLamps.contains { $0 == AAReadingLamp(location: .frontLeft, state: .active) })
        XCTAssertTrue(readingLamps.contains { $0 == AAReadingLamp(location: .frontRight, state: .active) })
        XCTAssertTrue(readingLamps.contains { $0 == AAReadingLamp(location: .rearRight, state: .inactive) })
        XCTAssertTrue(readingLamps.contains { $0 == AAReadingLamp(location: .rearLeft, state: .inactive) })
    }

    
    // MARK: Getters

    func testGetLightsState() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x36, 0x00]
    
        XCTAssertEqual(bytes, AALights.getLightsState())
    }
    
    func testGetLightsProperties() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x36, 0x00, 0x09]
        let getterBytes = AALights.getLightsProperties(propertyIDs: .interiorLights)
    
        XCTAssertEqual(bytes, getterBytes)
    }

    
    // MARK: Setters

    func testControlLights() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x36, 0x01] + [0x01, 0x00, 0x04, 0x01, 0x00, 0x01, 0x02, 0x02, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01, 0x04, 0x00, 0x06, 0x01, 0x00, 0x03, 0xff, 0x00, 0x00, 0x07, 0x00, 0x05, 0x01, 0x00, 0x02, 0x00, 0x00, 0x08, 0x00, 0x05, 0x01, 0x00, 0x02, 0x00, 0x01, 0x09, 0x00, 0x05, 0x01, 0x00, 0x02, 0x00, 0x00]
        let setterBytes = AALights.controlLights(frontExteriorLight: .activeWithFullBeam, rearExteriorLight: .active, ambientLightColour: AARGBColour(red: 255, green: 0, blue: 0), fogLights: [AALight(location: .front, state: .inactive)], readingLamps: [AAReadingLamp(location: .frontLeft, state: .active)], interiorLights: [AALight(location: .front, state: .inactive)])
    
        XCTAssertEqual(bytes, setterBytes)
    }
}