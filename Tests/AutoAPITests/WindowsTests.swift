//
// AutoAPITests
// Copyright (C) 2018 High-Mobility GmbH
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program. If not, see http://www.gnu.org/licenses/.
//
// Please inquire about commercial licensing options at
// licensing@high-mobility.com
//
//
//  WindowsTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 01/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
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

        XCTAssertEqual(AAWindows.getWindowsState, bytes)
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

        let frontLeft = AAWindow(openClosed: .opened, position: .frontLeft)
        let frontRight = AAWindow(openClosed: .opened, position: .frontRight)

        XCTAssertEqual(AAWindows.openClose([frontLeft, frontRight]), bytes)
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

        guard let windows = AAAutoAPI.parseBinary(bytes) as? AAWindows else {
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
