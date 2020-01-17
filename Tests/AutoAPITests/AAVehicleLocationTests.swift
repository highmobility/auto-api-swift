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
//  AAVehicleLocationTest.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import AutoAPI
import XCTest


class AAVehicleLocationTest: XCTestCase {

    // MARK: State Properties

    func testCoordinates() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x30, 0x01, 0x04, 0x00, 0x13, 0x01, 0x00, 0x10, 0x40, 0x4a, 0x42, 0x8f, 0x9f, 0x44, 0xd4, 0x45, 0x40, 0x2a, 0xcf, 0x56, 0x21, 0x74, 0xc4, 0xce]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAVehicleLocation else {
            return XCTFail("Could not parse bytes as AAVehicleLocation")
        }
    
        XCTAssertEqual(capability.coordinates?.value, AACoordinates(latitude: 52.520008, longitude: 13.404954))
    }

    func testHeading() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x30, 0x01, 0x05, 0x00, 0x0b, 0x01, 0x00, 0x08, 0x40, 0x2a, 0xbd, 0x80, 0xc3, 0x08, 0xfe, 0xac]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAVehicleLocation else {
            return XCTFail("Could not parse bytes as AAVehicleLocation")
        }
    
        XCTAssertEqual(capability.heading?.value, 13.370123)
    }

    func testAltitude() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x30, 0x01, 0x06, 0x00, 0x0b, 0x01, 0x00, 0x08, 0x40, 0x60, 0xb0, 0x00, 0x00, 0x00, 0x00, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAVehicleLocation else {
            return XCTFail("Could not parse bytes as AAVehicleLocation")
        }
    
        XCTAssertEqual(capability.altitude?.value, 133.5)
    }

    
    // MARK: Getters

    func testGetVehicleLocation() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x30, 0x00]
    
        XCTAssertEqual(bytes, AAVehicleLocation.getVehicleLocation())
    }
    
    func testGetVehicleLocationProperties() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x30, 0x00, 0x06]
        let getterBytes = AAVehicleLocation.getVehicleLocationProperties(propertyIDs: .altitude)
    
        XCTAssertEqual(bytes, getterBytes)
    }
}