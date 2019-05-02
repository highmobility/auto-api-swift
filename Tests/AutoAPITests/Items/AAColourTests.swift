//
// AutoAPITests
// Copyright (C) 2019 High-Mobility GmbH
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
//  AAColourTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 03/04/2019.
//  Copyright © 2019 High Mobility GmbH. All rights reserved.
//

@testable import AutoAPI
import XCTest


class AAColourTests: XCTestCase {

    static var allTests = [("testBytes", testBytes),
                           ("testInit", testInit)]


    // MARK: XCTestCase

    func testBytes() {
        let bytes: [UInt8] = [
            0x30,   // Red is 48.0 / 255.0
            0x40,   // Green is 64.0 / 255.0
            0x50    // Blue is 80.0 / 255.0
        ]

        XCTAssertEqual(AAColour(red: 48.0 / 255.0, green: 64.0 / 255.0, blue: 80.0 / 255.0).bytes, bytes)
    }

    func testInit() {
        // Successful
        let bytes1: [UInt8] = [
            0x30,   // Red is 48.0 / 255.0
            0x40,   // Blue is 64.0 / 255.0
            0x50    // Green is 80.0 / 255.0
        ]

        if let colour = AAColour(bytes: bytes1) {
            XCTAssertEqual(colour.red, 48.0 / 255.0)
            XCTAssertEqual(colour.green, 64.0 / 255.0)
            XCTAssertEqual(colour.blue, 80.0 / 255.0)
        }
        else {
            XCTFail("Failed to initialise AAColour")
        }

        // Fail#1
        let bytes2: [UInt8] = [
            0x01    // Invalid bytes count
        ]

        XCTAssertNil(AAColour(bytes: bytes2))
    }

    #if os(macOS)
    func testNSColour() {
        let bytes: [UInt8] = [
            0x30,   // Red is 48.0 / 255.0
            0x40,   // Green is 64.0 / 255.0
            0x50    // Blue is 80.0 / 255.0
        ]

        let nsColour = NSColor(red: 48.0 / 255.0, green: 64.0 / 255.0, blue: 80.0 / 255.0, alpha: 1.0)

        guard let colour = AAColour(bytes: bytes) else {
            return XCTFail("Failed to initialise AAColour")
        }

        XCTAssertEqual(colour.nsColor, nsColour)
    }
    #elseif os(iOS) || os(tvOS)
    func testNSColour() {
        let bytes: [UInt8] = [
            0x30,   // Red is 48.0 / 255.0
            0x40,   // Green is 64.0 / 255.0
            0x50    // Blue is 80.0 / 255.0
        ]

        let uiColour = UIColor(red: 48.0 / 255.0, green: 64.0 / 255.0, blue: 80.0 / 255.0, alpha: 1.0)

        guard let colour = AAColour(bytes: bytes) else {
            return XCTFail("Failed to initialise AAColour")
        }

        XCTAssertEqual(colour.uiColor, uiColour)
    }
    #endif
}
