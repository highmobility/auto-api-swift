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
//  AAKeyfobPositionTest.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import AutoAPI
import XCTest


class AAKeyfobPositionTest: XCTestCase {

    // MARK: State Properties

    func testLocation() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x48, 0x01, 0x01, 0x00, 0x04, 0x01, 0x00, 0x01, 0x05]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAKeyfobPosition else {
            return XCTFail("Could not parse bytes as AAKeyfobPosition")
        }
    
        XCTAssertEqual(capability.location?.value, .insideCar)
    }

    
    // MARK: Getters

    func testGetKeyfobPosition() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x48, 0x00]
    
        XCTAssertEqual(bytes, AAKeyfobPosition.getKeyfobPosition())
    }
}