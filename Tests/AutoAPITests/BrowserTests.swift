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
//  BrowserTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 13/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
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

        XCTAssertEqual(AABrowser.loadURL(url), bytes)
    }
}
