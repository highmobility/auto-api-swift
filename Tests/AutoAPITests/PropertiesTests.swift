//
// AutoAPITests
// Copyright (C) 2018 High-Mobility GmbH
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
//  PropertiesTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 24/04/2018.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import AutoAPI
import XCTest


class PropertiesTests: XCTestCase {

    static var allTests = [("testCarSignature", testCarSignature),
                           ("testNonce", testNonce),
                           ("testTimestamp", testTimestamp)]
    

    // MARK: XCTestCase

    func testCarSignature() {
        let bytes: [UInt8] = [
            0x00, 0x20, // MSB, LSB Message Identifier for Door Locks
            0x01,       // Message Type for Lock State

            0x01,       // Property Identifier for Door
            0x00, 0x03, // Property size 3 byte
            0x00,       // Front Left door
            0x01,       // Door open
            0x00,       // Door unlocked

            0xA1,       // Property Identifier for Car Signature
            0x00, 0x40, // Property size 64 bytes
            0x4D, 0x2C, 0x6A, 0xDC, 0xEF, 0x2D, 0xC5, 0x63,
            0x1E, 0x63, 0xA1, 0x78, 0xBF, 0x5C, 0x9F, 0xDD,
            0x8F, 0x53, 0x75, 0xFB, 0x6A, 0x5B, 0xC0, 0x54,
            0x32, 0x87, 0x7D, 0x6A, 0x00, 0xA1, 0x8F, 0x6C,
            0x74, 0x9B, 0x1D, 0x3C, 0x3C, 0x85, 0xB6, 0x52,
            0x45, 0x63, 0xAC, 0x3A, 0xB9, 0xD8, 0x32, 0xAF,
            0xF0, 0xDB, 0x20, 0x82, 0x8C, 0x1C, 0x8A, 0xB8,
            0xC7, 0xF7, 0xD7, 0x9A, 0x32, 0x20, 0x99, 0xE6  // Car signature
        ]

        guard let propertiesCapable = AAAutoAPI.parseBinary(bytes) as? AAPropertiesCapable else {
            return XCTFail("Parsed value is not PropertiesCapable")
        }

        let carSignature: [UInt8] = [0x4D, 0x2C, 0x6A, 0xDC, 0xEF, 0x2D, 0xC5, 0x63,
                                     0x1E, 0x63, 0xA1, 0x78, 0xBF, 0x5C, 0x9F, 0xDD,
                                     0x8F, 0x53, 0x75, 0xFB, 0x6A, 0x5B, 0xC0, 0x54,
                                     0x32, 0x87, 0x7D, 0x6A, 0x00, 0xA1, 0x8F, 0x6C,
                                     0x74, 0x9B, 0x1D, 0x3C, 0x3C, 0x85, 0xB6, 0x52,
                                     0x45, 0x63, 0xAC, 0x3A, 0xB9, 0xD8, 0x32, 0xAF,
                                     0xF0, 0xDB, 0x20, 0x82, 0x8C, 0x1C, 0x8A, 0xB8,
                                     0xC7, 0xF7, 0xD7, 0x9A, 0x32, 0x20, 0x99, 0xE6]

        XCTAssertEqual(propertiesCapable.carSignature, carSignature)
    }

    func testNonce() {
        let bytes: [UInt8] = [
            0x00, 0x20, // MSB, LSB Message Identifier for Door Locks
            0x01,       // Message Type for Lock State

            0x01,       // Property Identifier for Door
            0x00, 0x03, // Property size 3 byte
            0x00,       // Front Left door
            0x01,       // Door open
            0x00,       // Door unlocked

            0xA0,       // Property Identifier for Car Signature
            0x00, 0x09, // Property size 9 bytes
            0x32, 0x42, 0x44, 0x43, 0x37, 0x43, 0x48, 0x34, 0x36    // Nonce
        ]

        guard let propertiesCapable = AAAutoAPI.parseBinary(bytes) as? AAPropertiesCapable else {
            return XCTFail("Parsed value is not PropertiesCapable")
        }

        let nonce: [UInt8] = [0x32, 0x42, 0x44, 0x43, 0x37, 0x43, 0x48, 0x34, 0x36]

        XCTAssertEqual(propertiesCapable.nonce, nonce)
    }

    func testTimestamp() {
        let bytes: [UInt8] = [
            0x00, 0x20, // MSB, LSB Message Identifier for Door Locks
            0x01,       // Message Type for Lock State

            0x01,       // Property Identifier for Door
            0x00, 0x03, // Property size 3 byte
            0x00,       // Front Left door
            0x01,       // Door open
            0x00,       // Door unlocked

            0xA2,       // Property Identifier for Timestamp
            0x00, 0x08, // Property size 8 bytes
            0x11,       // 2017
            0x01,       // January
            0x0A,       // the 10th
            0x11,       // at 17h
            0x22,       // 34min
            0x00,       // 0sec
            0x00, 0x00  // 0min UTF time offset
        ]

        guard let propertiesCapable = AAAutoAPI.parseBinary(bytes) as? AAPropertiesCapable else {
            return XCTFail("Parsed value is not PropertiesCapable")
        }

        XCTAssertEqual(propertiesCapable.timestamp?.year, 2017)
        XCTAssertEqual(propertiesCapable.timestamp?.month, 1)
        XCTAssertEqual(propertiesCapable.timestamp?.day, 10)
        XCTAssertEqual(propertiesCapable.timestamp?.hour, 17)
        XCTAssertEqual(propertiesCapable.timestamp?.minute, 34)
        XCTAssertEqual(propertiesCapable.timestamp?.second, 0)
        XCTAssertEqual(propertiesCapable.timestamp?.offset, 0)
    }
}
