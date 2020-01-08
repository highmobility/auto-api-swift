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
//  AACapabilitiesTest.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import AutoAPI
import XCTest


class AACapabilitiesTest: XCTestCase {

    // MARK: State Properties

    func testCapabilities() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x10, 0x01, 0x01, 0x00, 0x0c, 0x01, 0x00, 0x09, 0x00, 0x20, 0x00, 0x05, 0x02, 0x03, 0x04, 0x05, 0x06, 0x01, 0x00, 0x0a, 0x01, 0x00, 0x07, 0x00, 0x23, 0x00, 0x03, 0x02, 0x08, 0x11]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AACapabilities else {
            return XCTFail("Could not parse bytes as AACapabilities")
        }
    
        guard let capabilities = capability.capabilities?.compactMap({ $0.value }) else {
            return XCTFail("Could not extract .capabilities values")
        }
    
        XCTAssertTrue(capabilities.contains { $0 == AASupportedCapability(capabilityID: 0x0020, supportedPropertyIDs: [0x02, 0x03, 0x04, 0x05, 0x06]) })
        XCTAssertTrue(capabilities.contains { $0 == AASupportedCapability(capabilityID: 0x0023, supportedPropertyIDs: [0x02, 0x08, 0x11]) })
    }

    
    // MARK: Getters

    func testGetCapabilities() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x10, 0x00]
    
        XCTAssertEqual(bytes, AACapabilities.getCapabilities())
    }
}