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
//  AAVideoHandoverTest.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import AutoAPI
import XCTest


class AAVideoHandoverTest: XCTestCase {

    
    // MARK: Non-state Properties

    func testScreen() {
        let bytes: Array<UInt8> = [0x03, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
    
        guard let property: AAProperty<AAVideoHandover.Screen> = AAOpaqueProperty(bytes: bytes)?.property() else {
            return XCTFail("Could not create a property for .screen")
        }
    
        XCTAssertEqual(property.value, .rear)
    }

    func testUrl() {
        let bytes: Array<UInt8> = [0x01, 0x00, 0x19, 0x01, 0x00, 0x16, 0x68, 0x74, 0x74, 0x70, 0x73, 0x3a, 0x2f, 0x2f, 0x62, 0x69, 0x74, 0x2e, 0x6c, 0x79, 0x2f, 0x32, 0x6f, 0x62, 0x59, 0x37, 0x47, 0x35]
    
        guard let property: AAProperty<String> = AAOpaqueProperty(bytes: bytes)?.property() else {
            return XCTFail("Could not create a property for .url")
        }
    
        XCTAssertEqual(property.value, "https://bit.ly/2obY7G5")
    }

    func testStartingSecond() {
        let bytes: Array<UInt8> = [0x02, 0x00, 0x05, 0x01, 0x00, 0x02, 0x00, 0x03]
    
        guard let property: AAProperty<UInt16> = AAOpaqueProperty(bytes: bytes)?.property() else {
            return XCTFail("Could not create a property for .startingSecond")
        }
    
        XCTAssertEqual(property.value, 3)
    }

    
    // MARK: Setters

    func testVideoHandover() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x43, 0x01] + [0x01, 0x00, 0x19, 0x01, 0x00, 0x16, 0x68, 0x74, 0x74, 0x70, 0x73, 0x3a, 0x2f, 0x2f, 0x62, 0x69, 0x74, 0x2e, 0x6c, 0x79, 0x2f, 0x32, 0x6f, 0x62, 0x59, 0x37, 0x47, 0x35, 0x02, 0x00, 0x05, 0x01, 0x00, 0x02, 0x00, 0x03, 0x03, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
        let setterBytes = AAVideoHandover.videoHandover(url: "https://bit.ly/2obY7G5", startingSecond: 3, screen: .rear)
    
        XCTAssertEqual(bytes, setterBytes)
    }
}