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
//  AAMultiCommandTest.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import AutoAPI
import XCTest


class AAMultiCommandTest: XCTestCase {

    // MARK: State Properties

    func testMultiStates() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x13, 0x01, 0x01, 0x00, 0x16, 0x01, 0x00, 0x13, 0x0b, 0x00, 0x20, 0x01, 0x06, 0x00, 0x04, 0x01, 0x00, 0x01, 0x00, 0x04, 0x00, 0x05, 0x01, 0x00, 0x02, 0x00, 0x01, 0x01, 0x00, 0x18, 0x01, 0x00, 0x15, 0x0b, 0x00, 0x23, 0x01, 0x0a, 0x00, 0x07, 0x01, 0x00, 0x04, 0x40, 0x60, 0x00, 0x00, 0x0b, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAMultiCommand else {
            return XCTFail("Could not parse bytes as AAMultiCommand")
        }
    
        guard let multiStates = capability.multiStates?.compactMap({ $0.value }) else {
            return XCTFail("Could not extract .multiStates values")
        }
    
        XCTAssertTrue(multiStates.contains { $0 is AADoors })
        XCTAssertTrue(multiStates.contains { $0 is AACharging })
    }

    
    // MARK: Non-state Properties

    func testMultiCommands() {
        // Not sure how to auto-generate these for more useful tests
        XCTAssertNotNil(AADoors(bytes: [0x0b, 0x00, 0x20, 0x01, 0x05, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]))
        XCTAssertNotNil(AAIgnition(bytes: [0x0b, 0x00, 0x35, 0x01, 0x01, 0x00, 0x04, 0x01, 0x00, 0x01, 0x00]))
    }

    
    // MARK: Setters

    func testMultiCommand() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x13, 0x01] + [0x02, 0x00, 0x0e, 0x01, 0x00, 0x0b, 0x0b, 0x00, 0x20, 0x01, 0x05, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
        let setterBytes = AAMultiCommand.multiCommand(multiCommands: [[0x0b, 0x00, 0x20, 0x01, 0x05, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]])
    
        XCTAssertEqual(bytes, setterBytes)
    }
}