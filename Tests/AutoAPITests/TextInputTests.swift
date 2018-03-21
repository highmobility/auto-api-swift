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
//  TextInputTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 13/12/2017.
//  Copyright © 2017 High Mobility. All rights reserved.
//

import AutoAPI
import XCTest


class TextInputTests: XCTestCase {

    static var allTests = [("testTextInput", testTextInput)]


    // MARK: XCTestCase

    func testTextInput() {
        let bytes: [UInt8] = [
            0x00, 0x44, // MSB, LSB Message Identifier for Text Input
            0x00,       // Message Type for Text Input

            0x01,               // Property Identifier for Text
            0x00, 0x03,         // Property size is 3 bytes
            0x79, 0x65, 0x73    // "yes"
        ]

        XCTAssertEqual(TextInput.textInput("yes"), bytes)
    }
}
