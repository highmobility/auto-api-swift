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
//  AAVehicleStatusTests.swift
//  AutoAPI
//
//  Generated by AutoAPIGenerator for Swift.
//  Copyright © 2021 High-Mobility GmbH. All rights reserved.
//

import Foundation
import HMUtilities
import XCTest
@testable import AutoAPI


final class AAVehicleStatusTests: XCTestCase {

    // MARK: State Properties
    
    func testStates() {
        let bytes: [UInt8] = [0x0d, 0x00, 0x11, 0x01, 0x99, 0x00, 0x2c, 0x01, 0x00, 0x29, 0x0d, 0x00, 0x20, 0x01, 0x06, 0x00, 0x04, 0x01, 0x00, 0x01, 0x00, 0x04, 0x00, 0x05, 0x01, 0x00, 0x02, 0x00, 0x01, 0x04, 0x00, 0x05, 0x01, 0x00, 0x02, 0x02, 0x01, 0xa2, 0x00, 0x0b, 0x01, 0x00, 0x08, 0x00, 0x00, 0x01, 0x59, 0x89, 0x38, 0xe7, 0x88, 0x99, 0x00, 0x43, 0x01, 0x00, 0x40, 0x0d, 0x00, 0x23, 0x01, 0x0b, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01, 0x0c, 0x00, 0x04, 0x01, 0x00, 0x01, 0x00, 0x18, 0x00, 0x0d, 0x01, 0x00, 0x0a, 0x14, 0x02, 0x40, 0x41, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1c, 0x00, 0x0d, 0x01, 0x00, 0x0a, 0x12, 0x04, 0x40, 0x81, 0x58, 0x00, 0x00, 0x00, 0x00, 0x00, 0xa2, 0x00, 0x0b, 0x01, 0x00, 0x08, 0x00, 0x00, 0x01, 0x59, 0x89, 0x38, 0xe7, 0x88]
        
        guard let capability = try? AAAutoAPI.parseBytes(bytes) as? AAVehicleStatus else {
            return XCTFail("Could not parse bytes as `AAVehicleStatus`")
        }
        
        guard let states = capability.states?.compactMap({ $0.value }) else {
            return XCTFail("Could not get `.states` values from `AAVehicleStatus` capability")
        }
        
        XCTAssertNotNil(AADoors(bytes: [0x0d, 0x00, 0x20, 0x01, 0x06, 0x00, 0x04, 0x01, 0x00, 0x01, 0x00, 0x04, 0x00, 0x05, 0x01, 0x00, 0x02, 0x00, 0x01, 0x04, 0x00, 0x05, 0x01, 0x00, 0x02, 0x02, 0x01, 0xa2, 0x00, 0x0b, 0x01, 0x00, 0x08, 0x00, 0x00, 0x01, 0x59, 0x89, 0x38, 0xe7, 0x88]))
        XCTAssertTrue(states.contains { $0.bytes == AADoors(bytes: [0x0d, 0x00, 0x20, 0x01, 0x06, 0x00, 0x04, 0x01, 0x00, 0x01, 0x00, 0x04, 0x00, 0x05, 0x01, 0x00, 0x02, 0x00, 0x01, 0x04, 0x00, 0x05, 0x01, 0x00, 0x02, 0x02, 0x01, 0xa2, 0x00, 0x0b, 0x01, 0x00, 0x08, 0x00, 0x00, 0x01, 0x59, 0x89, 0x38, 0xe7, 0x88])?.bytes })
        XCTAssertNotNil(AACharging(bytes: [0x0d, 0x00, 0x23, 0x01, 0x0b, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01, 0x0c, 0x00, 0x04, 0x01, 0x00, 0x01, 0x00, 0x18, 0x00, 0x0d, 0x01, 0x00, 0x0a, 0x14, 0x02, 0x40, 0x41, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1c, 0x00, 0x0d, 0x01, 0x00, 0x0a, 0x12, 0x04, 0x40, 0x81, 0x58, 0x00, 0x00, 0x00, 0x00, 0x00, 0xa2, 0x00, 0x0b, 0x01, 0x00, 0x08, 0x00, 0x00, 0x01, 0x59, 0x89, 0x38, 0xe7, 0x88]))
        XCTAssertTrue(states.contains { $0.bytes == AACharging(bytes: [0x0d, 0x00, 0x23, 0x01, 0x0b, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01, 0x0c, 0x00, 0x04, 0x01, 0x00, 0x01, 0x00, 0x18, 0x00, 0x0d, 0x01, 0x00, 0x0a, 0x14, 0x02, 0x40, 0x41, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1c, 0x00, 0x0d, 0x01, 0x00, 0x0a, 0x12, 0x04, 0x40, 0x81, 0x58, 0x00, 0x00, 0x00, 0x00, 0x00, 0xa2, 0x00, 0x0b, 0x01, 0x00, 0x08, 0x00, 0x00, 0x01, 0x59, 0x89, 0x38, 0xe7, 0x88])?.bytes })
    }


    // MARK: Getters
    
    func testGetVehicleStatus() {
        let bytes: [UInt8] = [0x0d, 0x00, 0x11, 0x00]
        
        XCTAssertEqual(bytes, AAVehicleStatus.getVehicleStatus())
    }


    // MARK: Identifiers
    
    func testCapabilityIdentifier() {
        XCTAssertEqual(AAVehicleStatus.identifier, 0x0011)
    }
    
    func testPropeertyIdentifiers() {
        XCTAssertEqual(AAVehicleStatus.PropertyIdentifier.states.rawValue, 0x99)
    }
}
