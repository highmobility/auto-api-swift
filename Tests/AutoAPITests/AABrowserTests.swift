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
//  AABrowserTest.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import AutoAPI
import XCTest


class AABrowserTest: XCTestCase {

    
    // MARK: Non-state Properties

    func testUrl() {
        let bytes: Array<UInt8> = [0x01, 0x00, 0x22, 0x01, 0x00, 0x1f, 0x68, 0x74, 0x74, 0x70, 0x73, 0x3a, 0x2f, 0x2f, 0x61, 0x62, 0x6f, 0x75, 0x74, 0x2e, 0x68, 0x69, 0x67, 0x68, 0x2d, 0x6d, 0x6f, 0x62, 0x69, 0x6c, 0x69, 0x74, 0x79, 0x2e, 0x63, 0x6f, 0x6d]
    
        guard let property: AAProperty<String> = AAOpaqueProperty(bytes: bytes)?.property() else {
            return XCTFail("Could not create a property for .url")
        }
    
        XCTAssertEqual(property.value, "https://about.high-mobility.com")
    }

    
    // MARK: Setters

    func testLoadUrl() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x49, 0x01] + [0x01, 0x00, 0x22, 0x01, 0x00, 0x1f, 0x68, 0x74, 0x74, 0x70, 0x73, 0x3a, 0x2f, 0x2f, 0x61, 0x62, 0x6f, 0x75, 0x74, 0x2e, 0x68, 0x69, 0x67, 0x68, 0x2d, 0x6d, 0x6f, 0x62, 0x69, 0x6c, 0x69, 0x74, 0x79, 0x2e, 0x63, 0x6f, 0x6d]
        let setterBytes = AABrowser.loadUrl(url: "https://about.high-mobility.com")
    
        XCTAssertEqual(bytes, setterBytes)
    }
}