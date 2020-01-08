//
// AutoAPI
// Copyright (C) 2020 High-Mobility GmbH
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
//  AATextInputTest.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import AutoAPI
import XCTest


class AATextInputTest: XCTestCase {

    
    // MARK: Non-state Properties

    func testText() {
        let bytes: Array<UInt8> = [0x01, 0x00, 0x17, 0x01, 0x00, 0x14, 0x52, 0x65, 0x6e, 0x64, 0x65, 0x7a, 0x76, 0x6f, 0x75, 0x73, 0x20, 0x77, 0x69, 0x74, 0x68, 0x20, 0x52, 0x61, 0x6d, 0x61]
    
        guard let property: AAProperty<String> = AAOpaqueProperty(bytes: bytes)?.property() else {
            return XCTFail("Could not create a property for .text")
        }
    
        XCTAssertEqual(property.value, "Rendezvous with Rama")
    }

    
    // MARK: Setters

    func testTextInput() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x44, 0x01] + [0x01, 0x00, 0x17, 0x01, 0x00, 0x14, 0x52, 0x65, 0x6e, 0x64, 0x65, 0x7a, 0x76, 0x6f, 0x75, 0x73, 0x20, 0x77, 0x69, 0x74, 0x68, 0x20, 0x52, 0x61, 0x6d, 0x61]
        let setterBytes = AATextInput.textInput(text: "Rendezvous with Rama")
    
        XCTAssertEqual(bytes, setterBytes)
    }
}