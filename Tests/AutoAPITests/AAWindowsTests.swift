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
//  AAWindowsTest.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import AutoAPI
import XCTest


class AAWindowsTest: XCTestCase {

    // MARK: State Properties

    func testOpenPercentages() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x45, 0x01, 0x02, 0x00, 0x0c, 0x01, 0x00, 0x09, 0x00, 0x3f, 0xc9, 0x99, 0x99, 0x99, 0x99, 0x99, 0x9a, 0x02, 0x00, 0x0c, 0x01, 0x00, 0x09, 0x01, 0x3f, 0xe0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x0c, 0x01, 0x00, 0x09, 0x02, 0x3f, 0xe0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x0c, 0x01, 0x00, 0x09, 0x03, 0x3f, 0xb9, 0x99, 0x99, 0x99, 0x99, 0x99, 0x9a, 0x02, 0x00, 0x0c, 0x01, 0x00, 0x09, 0x04, 0x3f, 0xc7, 0x0a, 0x3d, 0x70, 0xa3, 0xd7, 0x0a]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAWindows else {
            return XCTFail("Could not parse bytes as AAWindows")
        }
    
        guard let openPercentages = capability.openPercentages?.compactMap({ $0.value }) else {
            return XCTFail("Could not extract .openPercentages values")
        }
    
        XCTAssertTrue(openPercentages.contains { $0 == AAWindowOpenPercentage(location: .frontLeft, openPercentage: 0.2) })
        XCTAssertTrue(openPercentages.contains { $0 == AAWindowOpenPercentage(location: .frontRight, openPercentage: 0.5) })
        XCTAssertTrue(openPercentages.contains { $0 == AAWindowOpenPercentage(location: .rearRight, openPercentage: 0.5) })
        XCTAssertTrue(openPercentages.contains { $0 == AAWindowOpenPercentage(location: .rearLeft, openPercentage: 0.1) })
        XCTAssertTrue(openPercentages.contains { $0 == AAWindowOpenPercentage(location: .hatch, openPercentage: 0.18) })
    }

    func testPositions() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x45, 0x01, 0x03, 0x00, 0x05, 0x01, 0x00, 0x02, 0x00, 0x01, 0x03, 0x00, 0x05, 0x01, 0x00, 0x02, 0x01, 0x01, 0x03, 0x00, 0x05, 0x01, 0x00, 0x02, 0x02, 0x00, 0x03, 0x00, 0x05, 0x01, 0x00, 0x02, 0x03, 0x01, 0x03, 0x00, 0x05, 0x01, 0x00, 0x02, 0x04, 0x01]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAWindows else {
            return XCTFail("Could not parse bytes as AAWindows")
        }
    
        guard let positions = capability.positions?.compactMap({ $0.value }) else {
            return XCTFail("Could not extract .positions values")
        }
    
        XCTAssertTrue(positions.contains { $0 == AAWindowPosition(location: .frontLeft, position: .open) })
        XCTAssertTrue(positions.contains { $0 == AAWindowPosition(location: .frontRight, position: .open) })
        XCTAssertTrue(positions.contains { $0 == AAWindowPosition(location: .rearRight, position: .closed) })
        XCTAssertTrue(positions.contains { $0 == AAWindowPosition(location: .rearLeft, position: .open) })
        XCTAssertTrue(positions.contains { $0 == AAWindowPosition(location: .hatch, position: .open) })
    }

    
    // MARK: Getters

    func testGetWindows() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x45, 0x00]
    
        XCTAssertEqual(bytes, AAWindows.getWindows())
    }
    
    func testGetWindowsProperties() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x45, 0x00, 0x03]
        let getterBytes = AAWindows.getWindowsProperties(propertyIDs: .positions)
    
        XCTAssertEqual(bytes, getterBytes)
    }

    
    // MARK: Setters

    func testControlWindows() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x45, 0x01] + [0x02, 0x00, 0x0c, 0x01, 0x00, 0x09, 0x00, 0x3f, 0xc9, 0x99, 0x99, 0x99, 0x99, 0x99, 0x9a, 0x03, 0x00, 0x05, 0x01, 0x00, 0x02, 0x00, 0x01]
        let setterBytes = AAWindows.controlWindows(openPercentages: [AAWindowOpenPercentage(location: .frontLeft, openPercentage: 0.2)], positions: [AAWindowPosition(location: .frontLeft, position: .open)])
    
        XCTAssertEqual(bytes, setterBytes)
    }
}