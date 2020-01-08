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
//  AAVehicleLocationTest.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import AutoAPI
import XCTest


class AAVehicleLocationTest: XCTestCase {

    // MARK: State Properties

    func testHeading() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x30, 0x01, 0x05, 0x00, 0x0b, 0x01, 0x00, 0x08, 0x40, 0x2a, 0xbd, 0x80, 0xc3, 0x08, 0xfe, 0xac]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAVehicleLocation else {
            return XCTFail("Could not parse bytes as AAVehicleLocation")
        }
    
        XCTAssertEqual(capability.heading?.value, 13.370123)
    }

    func testAltitude() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x30, 0x01, 0x06, 0x00, 0x0b, 0x01, 0x00, 0x08, 0x40, 0x60, 0xb0, 0x00, 0x00, 0x00, 0x00, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAVehicleLocation else {
            return XCTFail("Could not parse bytes as AAVehicleLocation")
        }
    
        XCTAssertEqual(capability.altitude?.value, 133.5)
    }

    func testCoordinates() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x30, 0x01, 0x04, 0x00, 0x13, 0x01, 0x00, 0x10, 0x40, 0x4a, 0x42, 0x8f, 0x9f, 0x44, 0xd4, 0x45, 0x40, 0x2a, 0xcf, 0x56, 0x21, 0x74, 0xc4, 0xce]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAVehicleLocation else {
            return XCTFail("Could not parse bytes as AAVehicleLocation")
        }
    
        XCTAssertEqual(capability.coordinates?.value, AACoordinates(latitude: 52.520008, longitude: 13.404954))
    }

    
    // MARK: Getters

    func testGetVehicleLocation() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x30, 0x00]
    
        XCTAssertEqual(bytes, AAVehicleLocation.getVehicleLocation())
    }
    
    func testGetVehicleLocationProperties() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x30, 0x00, 0x06]
        let getterBytes = AAVehicleLocation.getVehicleLocationProperties(propertyIDs: .altitude)
    
        XCTAssertEqual(bytes, getterBytes)
    }
}