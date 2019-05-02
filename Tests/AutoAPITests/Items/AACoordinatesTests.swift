//
// AutoAPITests
// Copyright (C) 2019 High-Mobility GmbH
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
//  AACoordinatesTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 03/04/2019.
//  Copyright © 2019 High Mobility GmbH. All rights reserved.
//

@testable import AutoAPI
import XCTest


class AACoordinatesTests: XCTestCase {

    static var allTests = [("testBytes", testBytes),
                           ("testInit", testInit)]


    // MARK: XCTestCase

    func testBytes() {
        let bytes: [UInt8] = [
            0x40, 0x4A, 0x42, 0x8F, 0x9F, 0x44, 0xD4, 0x45, // 52.520008 Latitude in IEE 754 format
            0x40, 0x2A, 0xCF, 0x56, 0x21, 0x74, 0xC4, 0xCE  // 13.404954 Longitude in IEE 754 format
        ]

        XCTAssertEqual(AACoordinates(latitude: 52.520008, longitude: 13.404954).bytes, bytes)
    }

    func testInit() {
        // Successful
        let bytes1: [UInt8] = [
            0x40, 0x4A, 0x42, 0x8F, 0x9F, 0x44, 0xD4, 0x45, // 52.520008 Latitude in IEE 754 format
            0x40, 0x2A, 0xCF, 0x56, 0x21, 0x74, 0xC4, 0xCE  // 13.404954 Longitude in IEE 754 format
        ]

        if let coordiantes = AACoordinates(bytes: bytes1) {
            XCTAssertEqual(coordiantes.latitude, 52.520008)
            XCTAssertEqual(coordiantes.longitude, 13.404954)
        }
        else {
            XCTFail("Failed to initialise AACoordinates")
        }

        // Fail#1
        let bytes2: [UInt8] = [
            0x01    // Invalid bytes count
        ]

        XCTAssertNil(AACoordinates(bytes: bytes2))

        // Fail#2
        let bytes3: [UInt8] = [
            0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, // INVALID Latitude
            0x40, 0x2A, 0xCF, 0x56, 0x21, 0x74, 0xC4, 0xCE  // 13.404954 Longitude in IEE 754 format
        ]

        XCTAssertNil(AACoordinates(bytes: bytes3))
    }
}
