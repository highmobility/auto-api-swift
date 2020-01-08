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
//  AANaviDestinationTest.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import AutoAPI
import XCTest


class AANaviDestinationTest: XCTestCase {

    // MARK: State Properties

    func testDistanceToDestination() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x31, 0x01, 0x06, 0x00, 0x05, 0x01, 0x00, 0x02, 0x05, 0x39]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AANaviDestination else {
            return XCTFail("Could not parse bytes as AANaviDestination")
        }
    
        XCTAssertEqual(capability.distanceToDestination?.value, 1337)
    }

    func testDestinationName() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x31, 0x01, 0x02, 0x00, 0x09, 0x01, 0x00, 0x06, 0x42, 0x65, 0x72, 0x6c, 0x69, 0x6e]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AANaviDestination else {
            return XCTFail("Could not parse bytes as AANaviDestination")
        }
    
        XCTAssertEqual(capability.destinationName?.value, "Berlin")
    }

    func testCoordinates() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x31, 0x01, 0x01, 0x00, 0x13, 0x01, 0x00, 0x10, 0x40, 0x4a, 0x42, 0x8f, 0x9f, 0x44, 0xd4, 0x45, 0x40, 0x2a, 0xcf, 0x56, 0x21, 0x74, 0xc4, 0xce]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AANaviDestination else {
            return XCTFail("Could not parse bytes as AANaviDestination")
        }
    
        XCTAssertEqual(capability.coordinates?.value, AACoordinates(latitude: 52.520008, longitude: 13.404954))
    }

    func testDataSlotsFree() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x31, 0x01, 0x03, 0x00, 0x04, 0x01, 0x00, 0x01, 0x0e]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AANaviDestination else {
            return XCTFail("Could not parse bytes as AANaviDestination")
        }
    
        XCTAssertEqual(capability.dataSlotsFree?.value, 14)
    }

    func testDataSlotsMax() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x31, 0x01, 0x04, 0x00, 0x04, 0x01, 0x00, 0x01, 0x1e]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AANaviDestination else {
            return XCTFail("Could not parse bytes as AANaviDestination")
        }
    
        XCTAssertEqual(capability.dataSlotsMax?.value, 30)
    }

    func testArrivalDuration() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x31, 0x01, 0x05, 0x00, 0x05, 0x01, 0x00, 0x02, 0x02, 0x20]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AANaviDestination else {
            return XCTFail("Could not parse bytes as AANaviDestination")
        }
    
        XCTAssertEqual(capability.arrivalDuration?.value, AATime(hour: 2, minute: 32))
    }

    
    // MARK: Getters

    func testGetNaviDestination() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x31, 0x00]
    
        XCTAssertEqual(bytes, AANaviDestination.getNaviDestination())
    }
    
    func testGetNaviDestinationProperties() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x31, 0x00, 0x06]
        let getterBytes = AANaviDestination.getNaviDestinationProperties(propertyIDs: .distanceToDestination)
    
        XCTAssertEqual(bytes, getterBytes)
    }

    
    // MARK: Setters

    func testSetNaviDestination() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x31, 0x01] + [0x01, 0x00, 0x13, 0x01, 0x00, 0x10, 0x40, 0x4a, 0x42, 0x8f, 0x9f, 0x44, 0xd4, 0x45, 0x40, 0x2a, 0xcf, 0x56, 0x21, 0x74, 0xc4, 0xce, 0x02, 0x00, 0x09, 0x01, 0x00, 0x06, 0x42, 0x65, 0x72, 0x6c, 0x69, 0x6e]
        let setterBytes = AANaviDestination.setNaviDestination(coordinates: AACoordinates(latitude: 52.520008, longitude: 13.404954), destinationName: "Berlin")
    
        XCTAssertEqual(bytes, setterBytes)
    }
}