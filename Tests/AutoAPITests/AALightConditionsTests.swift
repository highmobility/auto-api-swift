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
//  AALightConditionsTest.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import AutoAPI
import XCTest


class AALightConditionsTest: XCTestCase {

    // MARK: State Properties

    func testInsideLight() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x54, 0x01, 0x02, 0x00, 0x07, 0x01, 0x00, 0x04, 0x3e, 0x80, 0x00, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AALightConditions else {
            return XCTFail("Could not parse bytes as AALightConditions")
        }
    
        XCTAssertEqual(capability.insideLight?.value, 0.25)
    }

    func testOutsideLight() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x54, 0x01, 0x01, 0x00, 0x07, 0x01, 0x00, 0x04, 0x47, 0xd8, 0xcc, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AALightConditions else {
            return XCTFail("Could not parse bytes as AALightConditions")
        }
    
        XCTAssertEqual(capability.outsideLight?.value, 111000.0)
    }

    
    // MARK: Getters

    func testGetLightConditions() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x54, 0x00]
    
        XCTAssertEqual(bytes, AALightConditions.getLightConditions())
    }
    
    func testGetLightConditionsProperties() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x54, 0x00, 0x02]
        let getterBytes = AALightConditions.getLightConditionsProperties(propertyIDs: .insideLight)
    
        XCTAssertEqual(bytes, getterBytes)
    }
}