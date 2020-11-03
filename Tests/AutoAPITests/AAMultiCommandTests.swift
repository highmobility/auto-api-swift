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
//  AAMultiCommandTest.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import AutoAPI
import XCTest


class AAMultiCommandTest: XCTestCase {

    // MARK: State Properties

    func testMultiStates() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x13, 0x01, 0x01, 0x00, 0x16, 0x01, 0x00, 0x13, 0x0b, 0x00, 0x20, 0x01, 0x06, 0x00, 0x04, 0x01, 0x00, 0x01, 0x00, 0x04, 0x00, 0x05, 0x01, 0x00, 0x02, 0x00, 0x01, 0x01, 0x00, 0x18, 0x01, 0x00, 0x15, 0x0b, 0x00, 0x23, 0x01, 0x0a, 0x00, 0x07, 0x01, 0x00, 0x04, 0x40, 0x60, 0x00, 0x00, 0x0b, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAMultiCommand else {
            return XCTFail("Could not parse bytes as AAMultiCommand")
        }
    
        guard let multiStates = capability.multiStates?.compactMap({ $0.value }) else {
            return XCTFail("Could not extract .multiStates values")
        }
    
        XCTAssertTrue(multiStates.contains { $0 is AADoors })
        XCTAssertTrue(multiStates.contains { $0 is AACharging })
    }

    
    // MARK: Non-state Properties

    func testMultiCommands() {
        // Not sure how to auto-generate these for more useful tests
        XCTAssertNotNil(AADoors(bytes: [0x0b, 0x00, 0x20, 0x01, 0x05, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]))
        XCTAssertNotNil(AAIgnition(bytes: [0x0b, 0x00, 0x35, 0x01, 0x01, 0x00, 0x04, 0x01, 0x00, 0x01, 0x00]))
    }

    
    // MARK: Setters

    func testMultiCommand() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x13, 0x01] + [0x02, 0x00, 0x0e, 0x01, 0x00, 0x0b, 0x0b, 0x00, 0x20, 0x01, 0x05, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
        let setterBytes = AAMultiCommand.multiCommand(multiCommands: [[0x0b, 0x00, 0x20, 0x01, 0x05, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]])
    
        XCTAssertEqual(bytes, setterBytes)
    }
}
