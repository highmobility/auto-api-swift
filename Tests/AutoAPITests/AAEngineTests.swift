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
//  AAEngineTest.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import AutoAPI
import XCTest


class AAEngineTest: XCTestCase {

    // MARK: State Properties

    func testStatus() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x69, 0x01, 0x01, 0x00, 0x04, 0x01, 0x00, 0x01, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAEngine else {
            return XCTFail("Could not parse bytes as AAEngine")
        }
    
        XCTAssertEqual(capability.status?.value, .off)
    }

    
    // MARK: Getters

    func testGetEngineState() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x69, 0x00]
    
        XCTAssertEqual(bytes, AAEngine.getEngineState())
    }

    
    // MARK: Setters

    func testTurnEngineOnOff() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x69, 0x01] + [0x01, 0x00, 0x04, 0x01, 0x00, 0x01, 0x00]
        let setterBytes = AAEngine.turnEngineOnOff(status: .off)
    
        XCTAssertEqual(bytes, setterBytes)
    }
}