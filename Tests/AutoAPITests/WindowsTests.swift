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
//  WindowsTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 01/12/2017.
//

import AutoAPI
import XCTest


class WindowsTests: XCTestCase {

    static var allTests = [("testGetState", testGetState),
                           ("testOpenClose", testOpenClose),
                           ("testState", testState)]


    // MARK: XCTestCase

    func testGetState() {
        let bytes: [UInt8] = [
            0x00, 0x45, // MSB, LSB Message Identifier for Windows
            0x00        // Message Type for Get Windows State
        ]

        XCTAssertEqual(Windows.getWindowsState, bytes)
    }

    func testOpenClose() {
        let bytes: [UInt8] = [
            0x00, 0x45, // MSB, LSB Message Identifier for Windows
            0x02,       // Message Type for Open/Close Windows

            0x01,       // Property Identifier for Window
            0x00, 0x02, // Property size 2 bytes
            0x00,       // Front left window
            0x01,       // To be opened

            0x01,       // Property Identifier for Window
            0x00, 0x02, // Property size 2 bytes
            0x01,       // Front right window
            0x01        // To be opened
        ]

        let frontLeft = Window(openClosed: .opened, position: .frontLeft)
        let frontRight = Window(openClosed: .opened, position: .frontRight)

        XCTAssertEqual(Windows.openClose([frontLeft, frontRight]), bytes)
    }

    func testState() {
        let bytes: [UInt8] = [
            0x00, 0x45, // MSB, LSB Message Identifier for Windows
            0x01,       // Message Type for Windows State

            0x01,       // Property Identifier for Window
            0x00, 0x02, // Property size 2 bytes
            0x00,       // Front Left window
            0x01,       // Window open

            0x01,       // Property Identifier for Window
            0x00, 0x02, // Property size 2 bytes
            0x01,       // Front Right window
            0x00,       // Window closed

            0x01,       // Property Identifier for Window
            0x00, 0x02, // Property size 2 bytes
            0x02,       // Rear Right window
            0x00,       // Window closed

            0x01,       // Property Identifier for Window
            0x00, 0x02, // Property size 2 bytes
            0x03,       // Rear Left window
            0x00        // Window closed
        ]

        guard let windows = AutoAPI.parseBinary(bytes) as? Windows else {
            return XCTFail("Parsed value is not Windows")
        }

        XCTAssertEqual(windows.windows?.count, 4)

        if let frontLeftWindow = windows.windows?.first(where: { $0.position == .frontLeft }) {
            XCTAssertEqual(frontLeftWindow.openClosed, .open)
        }
        else {
            XCTFail("Windows doesn't contain Front Left Window")
        }

        if let frontRightWindow = windows.windows?.first(where: { $0.position == .frontRight }) {
            XCTAssertEqual(frontRightWindow.openClosed, .closed)
        }
        else {
            XCTFail("Windows doesn't contain Front Right Window")
        }

        if let rearRightWindow = windows.windows?.first(where: { $0.position == .rearRight }) {
            XCTAssertEqual(rearRightWindow.openClosed, .closed)
        }
        else {
            XCTFail("Windows doesn't contain Rear Right Window")
        }

        if let rearLeftWindow = windows.windows?.first(where: { $0.position == .rearLeft }) {
            XCTAssertEqual(rearLeftWindow.openClosed, .closed)
        }
        else {
            XCTFail("Windows doesn't contain Rear Left Window")
        }
    }
}
