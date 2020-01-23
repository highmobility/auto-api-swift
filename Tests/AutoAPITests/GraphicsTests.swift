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
//  GraphicsTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 13/12/2017.
//

import AutoAPI
import XCTest


class GraphicsTests: XCTestCase {

    static var allTests = [("testDisplayImage", testDisplayImage)]


    // MARK: XCTestCase

    func testDisplayImage() {
        let bytes: [UInt8] = [
            0x00, 0x51, // MSB, LSB Message Identifier for Graphics
            0x00,       // Message Type for Display Image

            0x01,       // Property Identifier for Image URL
            0x00, 0x15, // Property size is 21 bytes
            0x68, 0x74, 0x74, 0x70, 0x73, 0x3a, 0x2f,   //
            0x2f, 0x67, 0x6f, 0x6f, 0x2e, 0x67, 0x6c,   //
            0x2f, 0x56, 0x79, 0x55, 0x31, 0x69, 0x70    // https://goo.gl/VyU1ip
        ]

        guard let url = URL(string: "https://goo.gl/VyU1ip") else {
            return XCTFail("Failed to generate a URL")
        }

        XCTAssertEqual(Graphics.displayImage(url), bytes)
    }
}
