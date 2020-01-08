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
//  AAVideoHandoverTest.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import AutoAPI
import XCTest


class AAVideoHandoverTest: XCTestCase {

    
    // MARK: Non-state Properties

    func testUrl() {
        let bytes: Array<UInt8> = [0x01, 0x00, 0x19, 0x01, 0x00, 0x16, 0x68, 0x74, 0x74, 0x70, 0x73, 0x3a, 0x2f, 0x2f, 0x62, 0x69, 0x74, 0x2e, 0x6c, 0x79, 0x2f, 0x32, 0x6f, 0x62, 0x59, 0x37, 0x47, 0x35]
    
        guard let property: AAProperty<String> = AAOpaqueProperty(bytes: bytes)?.property() else {
            return XCTFail("Could not create a property for .url")
        }
    
        XCTAssertEqual(property.value, "https://bit.ly/2obY7G5")
    }

    func testScreen() {
        let bytes: Array<UInt8> = [0x03, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
    
        guard let property: AAProperty<AAVideoHandover.Screen> = AAOpaqueProperty(bytes: bytes)?.property() else {
            return XCTFail("Could not create a property for .screen")
        }
    
        XCTAssertEqual(property.value, .rear)
    }

    func testStartingSecond() {
        let bytes: Array<UInt8> = [0x02, 0x00, 0x05, 0x01, 0x00, 0x02, 0x00, 0x03]
    
        guard let property: AAProperty<UInt16> = AAOpaqueProperty(bytes: bytes)?.property() else {
            return XCTFail("Could not create a property for .startingSecond")
        }
    
        XCTAssertEqual(property.value, 3)
    }

    
    // MARK: Setters

    func testVideoHandover() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x43, 0x01] + [0x01, 0x00, 0x19, 0x01, 0x00, 0x16, 0x68, 0x74, 0x74, 0x70, 0x73, 0x3a, 0x2f, 0x2f, 0x62, 0x69, 0x74, 0x2e, 0x6c, 0x79, 0x2f, 0x32, 0x6f, 0x62, 0x59, 0x37, 0x47, 0x35, 0x02, 0x00, 0x05, 0x01, 0x00, 0x02, 0x00, 0x03, 0x03, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
        let setterBytes = AAVideoHandover.videoHandover(url: "https://bit.ly/2obY7G5", startingSecond: 3, screen: .rear)
    
        XCTAssertEqual(bytes, setterBytes)
    }
}