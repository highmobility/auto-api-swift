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
//  AALightsTest.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import AutoAPI
import XCTest


class AALightsTest: XCTestCase {

    // MARK: State Properties

    func testReverseLight() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x36, 0x01, 0x05, 0x00, 0x04, 0x01, 0x00, 0x01, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AALights else {
            return XCTFail("Could not parse bytes as AALights")
        }
    
        XCTAssertEqual(capability.reverseLight?.value, .inactive)
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

    func testRearExteriorLight() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x36, 0x01, 0x02, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AALights else {
            return XCTFail("Could not parse bytes as AALights")
        }
    
        XCTAssertEqual(capability.rearExteriorLight?.value, .active)
    }

    func testFrontExteriorLight() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x36, 0x01, 0x01, 0x00, 0x04, 0x01, 0x00, 0x01, 0x02]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AALights else {
            return XCTFail("Could not parse bytes as AALights")
        }
    
        XCTAssertEqual(capability.frontExteriorLight?.value, .activeWithFullBeam)
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

    func testEmergencyBrakeLight() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x36, 0x01, 0x06, 0x00, 0x04, 0x01, 0x00, 0x01, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AALights else {
            return XCTFail("Could not parse bytes as AALights")
        }
    
        XCTAssertEqual(capability.emergencyBrakeLight?.value, .inactive)
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

    func testAmbientLightColour() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x36, 0x01, 0x04, 0x00, 0x06, 0x01, 0x00, 0x03, 0xff, 0x00, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AALights else {
            return XCTFail("Could not parse bytes as AALights")
        }
    
        XCTAssertEqual(capability.ambientLightColour?.value, AARGBColour(red: 255, green: 0, blue: 0))
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