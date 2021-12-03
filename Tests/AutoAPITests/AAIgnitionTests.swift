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
//  AAIgnitionTests.swift
//  AutoAPI
//
//  Generated by AutoAPIGenerator for Swift.
//  Copyright © 2021 High-Mobility GmbH. All rights reserved.
//

import Foundation
import HMUtilities
import XCTest
@testable import AutoAPI


final class AAIgnitionTests: XCTestCase {

    // MARK: State Properties
    
    func testState() {
        let bytes: [UInt8] = [0x0d, 0x00, 0x35, 0x01, 0x03, 0x00, 0x04, 0x01, 0x00, 0x01, 0x02]
        
        guard let capability = try? AAAutoAPI.parseBytes(bytes) as? AAIgnition else {
            return XCTFail("Could not parse bytes as `AAIgnition`")
        }
        
        XCTAssertEqual(capability.state?.value, AAIgnitionState.accessory)
    }


    // MARK: Non-state or Deprecated Properties
    
    func testStatus() {
        let bytes: [UInt8] = [0x01, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
        
        guard let property: AAProperty<AAIgnitionState> = AAOpaqueProperty(bytes: bytes)?.property() else {
            return XCTFail("Could not create a property for `.status`")
        }
        
        XCTAssertEqual(property.value, AAIgnitionState.off)
    }
    
    func testAccessoriesStatus() {
        let bytes: [UInt8] = [0x02, 0x00, 0x04, 0x01, 0x00, 0x01, 0x03]
        
        guard let property: AAProperty<AAIgnitionState> = AAOpaqueProperty(bytes: bytes)?.property() else {
            return XCTFail("Could not create a property for `.accessoriesStatus`")
        }
        
        XCTAssertEqual(property.value, AAIgnitionState.on)
    }


    // MARK: Getters
    
    func testGetIgnitionState() {
        let bytes: [UInt8] = [0x0d, 0x00, 0x35, 0x00]
        
        XCTAssertEqual(bytes, AAIgnition.getIgnitionState())
    }
    
    func testGetIgnitionStateAvailability() {
        let bytes: [UInt8] = [0x0d, 0x00, 0x35, 0x02]
        
        XCTAssertEqual(bytes, AAIgnition.getIgnitionStateAvailability())
    }


    // MARK: Setters
    
    func testTurnIgnitionOnOff() {
        let bytes: [UInt8] = [0x0d, 0x00, 0x35, 0x01, 0x03, 0x00, 0x04, 0x01, 0x00, 0x01, 0x02]
        let setterBytes = AAIgnition.turnIgnitionOnOff(state: AAIgnitionState.accessory)
        
        XCTAssertEqual(bytes, setterBytes)
    }


    // MARK: Identifiers
    
    func testCapabilityIdentifier() {
        XCTAssertEqual(AAIgnition.identifier, 0x0035)
    }
    
    func testPropeertyIdentifiers() {
        XCTAssertEqual(AAIgnition.PropertyIdentifier.state.rawValue, 0x03)
    }
}