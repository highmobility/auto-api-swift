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
//  AARooftopControlTests.swift
//  AutoAPI
//
//  Generated by AutoAPIGenerator for Swift.
//  Copyright © 2021 High-Mobility GmbH. All rights reserved.
//

import Foundation
import HMUtilities
import XCTest
@testable import AutoAPI


final class AARooftopControlTests: XCTestCase {

    // MARK: State Properties
    
    func testDimming() {
        let bytes: [UInt8] = [0x0c, 0x00, 0x25, 0x01, 0x01, 0x00, 0x0b, 0x01, 0x00, 0x08, 0x3f, 0xf0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00]
        
        guard let capability = try? AAAutoAPI.parseBytes(bytes) as? AARooftopControl else {
            return XCTFail("Could not parse bytes as `AARooftopControl`")
        }
        
        XCTAssertEqual(capability.dimming?.value, 1.0)
    }
    
    func testPosition() {
        let bytes: [UInt8] = [0x0c, 0x00, 0x25, 0x01, 0x02, 0x00, 0x0b, 0x01, 0x00, 0x08, 0x3f, 0xe0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00]
        
        guard let capability = try? AAAutoAPI.parseBytes(bytes) as? AARooftopControl else {
            return XCTFail("Could not parse bytes as `AARooftopControl`")
        }
        
        XCTAssertEqual(capability.position?.value, 0.5)
    }
    
    func testConvertibleRoofState() {
        let bytes: [UInt8] = [0x0c, 0x00, 0x25, 0x01, 0x03, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
        
        guard let capability = try? AAAutoAPI.parseBytes(bytes) as? AARooftopControl else {
            return XCTFail("Could not parse bytes as `AARooftopControl`")
        }
        
        XCTAssertEqual(capability.convertibleRoofState?.value, AARooftopControl.ConvertibleRoofState.open)
    }
    
    func testSunroofTiltState() {
        let bytes: [UInt8] = [0x0c, 0x00, 0x25, 0x01, 0x04, 0x00, 0x04, 0x01, 0x00, 0x01, 0x02]
        
        guard let capability = try? AAAutoAPI.parseBytes(bytes) as? AARooftopControl else {
            return XCTFail("Could not parse bytes as `AARooftopControl`")
        }
        
        XCTAssertEqual(capability.sunroofTiltState?.value, AARooftopControl.SunroofTiltState.halfTilted)
    }
    
    func testSunroofState() {
        let bytes: [UInt8] = [0x0c, 0x00, 0x25, 0x01, 0x05, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
        
        guard let capability = try? AAAutoAPI.parseBytes(bytes) as? AARooftopControl else {
            return XCTFail("Could not parse bytes as `AARooftopControl`")
        }
        
        XCTAssertEqual(capability.sunroofState?.value, AARooftopControl.SunroofState.open)
    }
    
    func testSunroofRainEvent() {
        let bytes: [UInt8] = [0x0c, 0x00, 0x25, 0x01, 0x06, 0x00, 0x04, 0x01, 0x00, 0x01, 0x00]
        
        guard let capability = try? AAAutoAPI.parseBytes(bytes) as? AARooftopControl else {
            return XCTFail("Could not parse bytes as `AARooftopControl`")
        }
        
        XCTAssertEqual(capability.sunroofRainEvent?.value, AARooftopControl.SunroofRainEvent.noEvent)
    }


    // MARK: Getters
    
    func testGetRooftopState() {
        let bytes: [UInt8] = [0x0c, 0x00, 0x25, 0x00]
        
        XCTAssertEqual(bytes, AARooftopControl.getRooftopState())
    }
    
    func testGetRooftopStateAvailability() {
        let bytes: [UInt8] = [0x0c, 0x00, 0x25, 0x02]
        
        XCTAssertEqual(bytes, AARooftopControl.getRooftopStateAvailability())
    }
    
    func testGetRooftopStateProperties() {
        let bytes: [UInt8] = [0x0c, 0x00, 0x25, 0x00, 0x01]
        let getterBytes = AARooftopControl.getRooftopStateProperties(ids: .dimming)
        
        XCTAssertEqual(bytes, getterBytes)
    }
    
    func testGetRooftopStatePropertiesAvailability() {
        let bytes: [UInt8] = [0x0c, 0x00, 0x25, 0x02, 0x01]
        let getterBytes = AARooftopControl.getRooftopStatePropertiesAvailability(ids: .dimming)
        
        XCTAssertEqual(bytes, getterBytes)
    }


    // MARK: Setters
    
    func testControlRooftop() {
        let bytes: [UInt8] = [0x0c, 0x00, 0x25, 0x01, 0x01, 0x00, 0x0b, 0x01, 0x00, 0x08, 0x3f, 0xf0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x0b, 0x01, 0x00, 0x08, 0x3f, 0xe0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01, 0x04, 0x00, 0x04, 0x01, 0x00, 0x01, 0x02, 0x05, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
        let setterBytes = AARooftopControl.controlRooftop(convertibleRoofState: AARooftopControl.ConvertibleRoofState.open, dimming: 1.0, position: 0.5, sunroofState: AARooftopControl.SunroofState.open, sunroofTiltState: AARooftopControl.SunroofTiltState.halfTilted)
        
        XCTAssertEqual(bytes, setterBytes)
    }


    // MARK: Identifiers
    
    func testCapabilityIdentifier() {
        XCTAssertEqual(AARooftopControl.identifier, 0x0025)
    }
    
    func testPropeertyIdentifiers() {
        XCTAssertEqual(AARooftopControl.PropertyIdentifier.dimming.rawValue, 0x01)
        XCTAssertEqual(AARooftopControl.PropertyIdentifier.position.rawValue, 0x02)
        XCTAssertEqual(AARooftopControl.PropertyIdentifier.convertibleRoofState.rawValue, 0x03)
        XCTAssertEqual(AARooftopControl.PropertyIdentifier.sunroofTiltState.rawValue, 0x04)
        XCTAssertEqual(AARooftopControl.PropertyIdentifier.sunroofState.rawValue, 0x05)
        XCTAssertEqual(AARooftopControl.PropertyIdentifier.sunroofRainEvent.rawValue, 0x06)
    }
}