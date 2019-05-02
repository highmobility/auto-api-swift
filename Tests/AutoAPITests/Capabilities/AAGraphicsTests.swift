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
//  AAGraphicsTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 13/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import AutoAPI
import XCTest


class AAGraphicsTests: XCTestCase {

    static var allTests = [("testDisplayImage", testDisplayImage)]


    // MARK: XCTestCase

    func testDisplayImage() {
        let bytes: [UInt8] = [
            0x00, 0x51, // MSB, LSB Message Identifier for Graphics
            0x00,       // Message Type for Display Image

            0x01,       // Property Identifier for Image URL
            0x00, 0x18, // Property size is 24 bytes
            0x01,       // Data component
            0x00, 0x15, // Data component size is 21 bytes
            0x68, 0x74, 0x74, 0x70, 0x73, 0x3a, 0x2f,   //
            0x2f, 0x67, 0x6f, 0x6f, 0x2e, 0x67, 0x6c,   //
            0x2f, 0x56, 0x79, 0x55, 0x31, 0x69, 0x70    // https://goo.gl/VyU1ip
        ]

        guard let url = URL(string: "https://goo.gl/VyU1ip") else {
            return XCTFail("Failed to generate a URL")
        }

        XCTAssertEqual(AAGraphics.displayImage(url).bytes, bytes)
    }
}
