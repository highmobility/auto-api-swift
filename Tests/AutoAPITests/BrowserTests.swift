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
//  BrowserTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 13/12/2017.
//

import AutoAPI
import XCTest


class BrowserTests: XCTestCase {

    static var allTests = [("testLoadURL", testLoadURL)]


    // MARK: XCTestCase

    func testLoadURL() {
        let bytes: [UInt8] = [
            0x00, 0x49, // MSB, LSB Message Identifier for Browser
            0x00,       // Message Type for Load URL

            0x01,       // Property Identifier for URL
            0x00, 0x12, // Propery size is 18 bytes
            0x68, 0x74, 0x74, 0x70, 0x73, 0x3a, //
            0x2f, 0x2f, 0x67, 0x6f, 0x6f, 0x67, //
            0x6c, 0x65, 0x2e, 0x63, 0x6f, 0x6d  // https://google.com
        ]

        guard let url = URL(string: "https://google.com") else {
            return XCTFail("Failed to generate a URL")
        }

        XCTAssertEqual(Browser.loadURL(url), bytes)
    }
}
