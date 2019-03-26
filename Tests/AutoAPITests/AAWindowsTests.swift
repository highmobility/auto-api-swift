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
//  AAWindowsTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 01/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import AutoAPI
import XCTest


class AAWindowsTests: XCTestCase {

    static var allTests = [("testGetState", testGetState),
                           ("testOpenClose", testOpenClose),
                           ("testState", testState)]


    // MARK: XCTestCase

    func testGetState() {
        let bytes: [UInt8] = [
            0x00, 0x45, // MSB, LSB Message Identifier for Windows
            0x00        // Message Type for Get Windows State
        ]

        XCTAssertEqual(AAWindows.getWindowsState.bytes, bytes)
    }

    func testOpenClose() {
        let bytes1: [UInt8] = [
            0x00, 0x45, // MSB, LSB Message Identifier for Windows
            0x12,       // Message Type for Control Windows

            0x01,       // Property identifier for Windows open percentages
            0x00, 0x0C, // Property size is 12 bytes
            0x01,       // Data component identifier
            0x00, 0x09, // Data component size is 9 bytes
            0x02,                                           // Rear right window
            0x3F, 0xE1, 0xEB, 0x85, 0x1E, 0xB8, 0x51, 0xEC, // Window 56% open

            0x01,       // Property identifier for Windows open percentages
            0x00, 0x0C, // Property size is 12 bytes
            0x01,       // Data component identifier
            0x00, 0x09, // Data component size is 9 bytes
            0x03,                                           // Rear left window
            0x3F, 0xC7, 0x0A, 0x3D, 0x70, 0xA3, 0xD7, 0x0A, // Window 18% open
        ]

        let bytes2: [UInt8] = [
            0x00, 0x45, // MSB, LSB Message Identifier for Windows
            0x12,       // Message Type for Control Windows

            0x02,       // Property Identifier for Window positions
            0x00, 0x05, // Property size is 5 bytes
            0x01,       // Data component identifier
            0x00, 0x02, // Data component size is 2 bytes0x00, 0x02, // Property size 2 bytes
            0x00,       // Front left window
            0x01,       // To be opened

            0x02,       // Property Identifier for Window positions
            0x00, 0x05, // Property size is 5 bytes
            0x01,       // Data component identifier
            0x00, 0x02, // Data component size is 2 bytes
            0x01,       // Front right window
            0x01        // To be opened
        ]

        let open1 = AAWindowOpenPercentage(location: .rearRight, percentage: 0.56)
        let open2 = AAWindowOpenPercentage(location: .rearLeft, percentage: 0.18)
        let position1 = AAWindowPosition(location: .frontLeft, position: .open)
        let position2 = AAWindowPosition(location: .frontRight, position: .open)

        XCTAssertEqual(AAWindows.controlWindows(openPercentages: [open1, open2], positions: nil).bytes, bytes1)
        XCTAssertEqual(AAWindows.controlWindows(openPercentages: nil, positions: [position1, position2]).bytes, bytes2)
    }

    func testState() {
        let bytes: [UInt8] = [
            0x00, 0x45, // MSB, LSB Message Identifier for Windows
            0x01,       // Message Type for Windows State

            0x02,       // Property identifier for Windows open percentages
            0x00, 0x0C, // Property size is 12 bytes
            0x01,       // Data component identifier
            0x00, 0x09, // Data component size is 9 bytes
            0x02,                                           // Rear right window
            0x3F, 0xE1, 0xEB, 0x85, 0x1E, 0xB8, 0x51, 0xEC, // Window 56% open

            0x02,       // Property identifier for Windows open percentages
            0x00, 0x0C, // Property size is 12 bytes
            0x01,       // Data component identifier
            0x00, 0x09, // Data component size is 9 bytes
            0x03,                                           // Rear left window
            0x3F, 0xC7, 0x0A, 0x3D, 0x70, 0xA3, 0xD7, 0x0A, // Window 18% open

            0x03,       // Property identifier for Windows positions
            0x00, 0x05, // Property size is 5 bytes
            0x01,       // Data component identifier
            0x00, 0x02, // Data component size is 2 bytes
            0x02,       // Rear right window
            0x01,       // Window open

            0x03,       // Property identifier for Windows positions
            0x00, 0x05, // Property size is 5 bytes
            0x01,       // Data component identifier
            0x00, 0x02, // Data component size is 2 bytes
            0x03,       // Rear left window
            0x00        // Window closed
        ]

        guard let windows = AAAutoAPI.parseBinary(bytes) as? AAWindows else {
            return XCTFail("Parsed value is not AAWindows")
        }

        // Open Percentages
        XCTAssertEqual(windows.openPercentages?.count, 2)

        if let window = windows.openPercentages?.first(where: { $0.value?.location == .rearRight }) {
            XCTAssertEqual(window.value?.percentage, 0.56)
        }
        else {
            XCTFail("Open Percentages doesn't contain Rear Right window")
        }

        if let window = windows.openPercentages?.first(where: { $0.value?.location == .rearLeft }) {
            XCTAssertEqual(window.value?.percentage, 0.18)
        }
        else {
            XCTFail("Open Percentages doesn't contain Rear Left window")
        }

        // Positions
        XCTAssertEqual(windows.positions?.count, 2)

        if let window = windows.positions?.first(where: { $0.value?.location == .rearRight }) {
            XCTAssertEqual(window.value?.position, .open)
        }
        else {
            XCTFail("Positions doesn't contain Rear Right window")
        }

        if let window = windows.positions?.first(where: { $0.value?.location == .rearLeft }) {
            XCTAssertEqual(window.value?.position, .closed)
        }
        else {
            XCTFail("Positions doesn't contain Rear Left window")
        }
    }
}
