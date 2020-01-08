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
//  AAIgnitionTest.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import AutoAPI
import XCTest


class AAIgnitionTest: XCTestCase {

    // MARK: State Properties

    func testStatus() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x35, 0x01, 0x01, 0x00, 0x04, 0x01, 0x00, 0x01, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAIgnition else {
            return XCTFail("Could not parse bytes as AAIgnition")
        }
    
        XCTAssertEqual(capability.status?.value, .off)
    }

    func testAccessoriesStatus() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x35, 0x01, 0x02, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAIgnition else {
            return XCTFail("Could not parse bytes as AAIgnition")
        }
    
        XCTAssertEqual(capability.accessoriesStatus?.value, .on)
    }

    
    // MARK: Getters

    func testGetIgnitionState() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x35, 0x00]
    
        XCTAssertEqual(bytes, AAIgnition.getIgnitionState())
    }
    
    func testGetIgnitionProperties() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x35, 0x00, 0x02]
        let getterBytes = AAIgnition.getIgnitionProperties(propertyIDs: .accessoriesStatus)
    
        XCTAssertEqual(bytes, getterBytes)
    }

    
    // MARK: Setters

    func testTurnIgnitionOnOff() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x35, 0x01] + [0x01, 0x00, 0x04, 0x01, 0x00, 0x01, 0x00]
        let setterBytes = AAIgnition.turnIgnitionOnOff(status: .off)
    
        XCTAssertEqual(bytes, setterBytes)
    }
}