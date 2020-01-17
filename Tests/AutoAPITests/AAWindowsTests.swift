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
//  AAWindowsTest.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import AutoAPI
import XCTest


class AAWindowsTest: XCTestCase {

    // MARK: State Properties

    func testOpenPercentages() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x45, 0x01, 0x02, 0x00, 0x0c, 0x01, 0x00, 0x09, 0x00, 0x3f, 0xc9, 0x99, 0x99, 0x99, 0x99, 0x99, 0x9a, 0x02, 0x00, 0x0c, 0x01, 0x00, 0x09, 0x01, 0x3f, 0xe0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x0c, 0x01, 0x00, 0x09, 0x02, 0x3f, 0xe0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x0c, 0x01, 0x00, 0x09, 0x03, 0x3f, 0xb9, 0x99, 0x99, 0x99, 0x99, 0x99, 0x9a, 0x02, 0x00, 0x0c, 0x01, 0x00, 0x09, 0x04, 0x3f, 0xc7, 0x0a, 0x3d, 0x70, 0xa3, 0xd7, 0x0a]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAWindows else {
            return XCTFail("Could not parse bytes as AAWindows")
        }
    
        guard let openPercentages = capability.openPercentages?.compactMap({ $0.value }) else {
            return XCTFail("Could not extract .openPercentages values")
        }
    
        XCTAssertTrue(openPercentages.contains { $0 == AAWindowOpenPercentage(location: .frontLeft, openPercentage: 0.2) })
        XCTAssertTrue(openPercentages.contains { $0 == AAWindowOpenPercentage(location: .frontRight, openPercentage: 0.5) })
        XCTAssertTrue(openPercentages.contains { $0 == AAWindowOpenPercentage(location: .rearRight, openPercentage: 0.5) })
        XCTAssertTrue(openPercentages.contains { $0 == AAWindowOpenPercentage(location: .rearLeft, openPercentage: 0.1) })
        XCTAssertTrue(openPercentages.contains { $0 == AAWindowOpenPercentage(location: .hatch, openPercentage: 0.18) })
    }

    func testPositions() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x45, 0x01, 0x03, 0x00, 0x05, 0x01, 0x00, 0x02, 0x00, 0x01, 0x03, 0x00, 0x05, 0x01, 0x00, 0x02, 0x01, 0x01, 0x03, 0x00, 0x05, 0x01, 0x00, 0x02, 0x02, 0x00, 0x03, 0x00, 0x05, 0x01, 0x00, 0x02, 0x03, 0x01, 0x03, 0x00, 0x05, 0x01, 0x00, 0x02, 0x04, 0x01]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAWindows else {
            return XCTFail("Could not parse bytes as AAWindows")
        }
    
        guard let positions = capability.positions?.compactMap({ $0.value }) else {
            return XCTFail("Could not extract .positions values")
        }
    
        XCTAssertTrue(positions.contains { $0 == AAWindowPosition(location: .frontLeft, position: .open) })
        XCTAssertTrue(positions.contains { $0 == AAWindowPosition(location: .frontRight, position: .open) })
        XCTAssertTrue(positions.contains { $0 == AAWindowPosition(location: .rearRight, position: .closed) })
        XCTAssertTrue(positions.contains { $0 == AAWindowPosition(location: .rearLeft, position: .open) })
        XCTAssertTrue(positions.contains { $0 == AAWindowPosition(location: .hatch, position: .open) })
    }

    
    // MARK: Getters

    func testGetWindows() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x45, 0x00]
    
        XCTAssertEqual(bytes, AAWindows.getWindows())
    }
    
    func testGetWindowsProperties() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x45, 0x00, 0x03]
        let getterBytes = AAWindows.getWindowsProperties(propertyIDs: .positions)
    
        XCTAssertEqual(bytes, getterBytes)
    }

    
    // MARK: Setters

    func testControlWindows() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x45, 0x01] + [0x02, 0x00, 0x0c, 0x01, 0x00, 0x09, 0x00, 0x3f, 0xc9, 0x99, 0x99, 0x99, 0x99, 0x99, 0x9a, 0x03, 0x00, 0x05, 0x01, 0x00, 0x02, 0x00, 0x01]
        let setterBytes = AAWindows.controlWindows(openPercentages: [AAWindowOpenPercentage(location: .frontLeft, openPercentage: 0.2)], positions: [AAWindowPosition(location: .frontLeft, position: .open)])
    
        XCTAssertEqual(bytes, setterBytes)
    }
}