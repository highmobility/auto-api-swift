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
//  AACapabilityClassTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 04/04/2019.
//  Copyright © 2019 High Mobility GmbH. All rights reserved.
//

@testable import AutoAPI
import XCTest


class AACapabilityClassTests: XCTestCase {

    static var allTests = [("testBytes", testBytes),
                           ("testInit", testInit),
                           ("testProperties", testProperties)]


    // MARK: XCTestCase

    func testBytes() {
        let propertyBytes: [UInt8] = [
            0xA1,       // Property Identifier for Car Signature
            0x00, 0x43, // Property size 67 bytes
            0x01,       // Data component identifier
            0x00, 0x40, // Component size 64 bytes
            0x4D, 0x2C, 0x6A, 0xDC, 0xEF, 0x2D, 0xC5, 0x63,
            0x1E, 0x63, 0xA1, 0x78, 0xBF, 0x5C, 0x9F, 0xDD,
            0x8F, 0x53, 0x75, 0xFB, 0x6A, 0x5B, 0xC0, 0x54,
            0x32, 0x87, 0x7D, 0x6A, 0x00, 0xA1, 0x8F, 0x6C,
            0x74, 0x9B, 0x1D, 0x3C, 0x3C, 0x85, 0xB6, 0x52,
            0x45, 0x63, 0xAC, 0x3A, 0xB9, 0xD8, 0x32, 0xAF,
            0xF0, 0xDB, 0x20, 0x82, 0x8C, 0x1C, 0x8A, 0xB8,
            0xC7, 0xF7, 0xD7, 0x9A, 0x32, 0x20, 0x99, 0xE6, // Car signature

            0xA0,       // Property Identifier for Nonce
            0x00, 0x0C, // Property size 12 bytes
            0x01,       // Data component identifier
            0x00, 0x09, // Component size 8 bytes
            0x32, 0x42, 0x44, 0x43, 0x37, 0x43, 0x48, 0x34, 0x36,   // Nonce

            0xA2,       // Property Identifier for Timestamp
            0x00, 0x0B, // Property size 11 bytes
            0x01,       // Data component identifier
            0x00, 0x08, // Component size 8 bytes
            0x00, 0x00, 0x01, 0x69, 0xE7, 0xC0, 0x18, 0xC0  // 4 April 2019 at 09:48:40 GMT
        ]

        let bytes: [UInt8] = [
            0x00, 0x23, // MSB, LSB Message Identifier for Charging
            0x01        // Message Type for Charge State
        ] + propertyBytes

        guard let properties = AAProperties(bytes: propertyBytes) else {
            return XCTFail("Parsed value is not AAProperties")
        }

        XCTAssertEqual(AACharging(properties: properties).bytes, bytes)

        // Fail#1
        XCTAssertEqual(AACapabilityClass(properties: properties).bytes, [])
    }

    func testInit() {
        // Successful
        let bytes1: [UInt8] = [
            0x00, 0x23, // MSB, LSB Message Identifier for Charging
            0x01        // Message Type for Charge State
        ]

        XCTAssertNotNil(AACharging(bytes: bytes1))

        // Fail#1
        let bytes2: [UInt8] = [
            0x01    // Invalid bytes count
        ]

        XCTAssertNil(AACharging(bytes: bytes2))

        // Fail#2
        let bytes3: [UInt8] = [
            0x00, 0x23, // MSB, LSB Message Identifier for Charging
            0xFF        // INVALID
        ]

        XCTAssertNil(AACharging(bytes: bytes3))

        // Fail#3
        let bytes4: [UInt8] = [
            0x00, 0x23, // MSB, LSB Message Identifier for Charging
            0x01        // Message Type for Charge State
        ]

        XCTAssertNil(AACapabilityClass(bytes: bytes4))
    }

    func testProperties() {
        let bytes: [UInt8] = [
            0x00, 0x23, // MSB, LSB Message Identifier for Charging
            0x01,       // Message Type for Charge State

            0xA1,       // Property Identifier for Car Signature
            0x00, 0x43, // Property size 67 bytes
            0x01,       // Data component identifier
            0x00, 0x40, // Component size 64 bytes
            0x4D, 0x2C, 0x6A, 0xDC, 0xEF, 0x2D, 0xC5, 0x63,
            0x1E, 0x63, 0xA1, 0x78, 0xBF, 0x5C, 0x9F, 0xDD,
            0x8F, 0x53, 0x75, 0xFB, 0x6A, 0x5B, 0xC0, 0x54,
            0x32, 0x87, 0x7D, 0x6A, 0x00, 0xA1, 0x8F, 0x6C,
            0x74, 0x9B, 0x1D, 0x3C, 0x3C, 0x85, 0xB6, 0x52,
            0x45, 0x63, 0xAC, 0x3A, 0xB9, 0xD8, 0x32, 0xAF,
            0xF0, 0xDB, 0x20, 0x82, 0x8C, 0x1C, 0x8A, 0xB8,
            0xC7, 0xF7, 0xD7, 0x9A, 0x32, 0x20, 0x99, 0xE6, // Car signature

            0xA0,       // Property Identifier for Car Signature
            0x00, 0x0C, // Property size 12 bytes
            0x01,       // Data component identifier
            0x00, 0x09, // Component size 8 bytes
            0x32, 0x42, 0x44, 0x43, 0x37, 0x43, 0x48, 0x34, 0x36,   // Nonce

            0xA2,       // Property Identifier for Timestamp
            0x00, 0x0B, // Property size 11 bytes
            0x01,       // Data component identifier
            0x00, 0x08, // Component size 8 bytes
            0x00, 0x00, 0x01, 0x69, 0xE7, 0xC0, 0x18, 0xC0  // 4 April 2019 at 09:48:40 GMT
        ]

        guard let capability = AACharging(bytes: bytes) else {
            return XCTFail("Parsed value is not AACapabilityClass")
        }

        let carSignature: [UInt8] = [
            0x4D, 0x2C, 0x6A, 0xDC, 0xEF, 0x2D, 0xC5, 0x63,
            0x1E, 0x63, 0xA1, 0x78, 0xBF, 0x5C, 0x9F, 0xDD,
            0x8F, 0x53, 0x75, 0xFB, 0x6A, 0x5B, 0xC0, 0x54,
            0x32, 0x87, 0x7D, 0x6A, 0x00, 0xA1, 0x8F, 0x6C,
            0x74, 0x9B, 0x1D, 0x3C, 0x3C, 0x85, 0xB6, 0x52,
            0x45, 0x63, 0xAC, 0x3A, 0xB9, 0xD8, 0x32, 0xAF,
            0xF0, 0xDB, 0x20, 0x82, 0x8C, 0x1C, 0x8A, 0xB8,
            0xC7, 0xF7, 0xD7, 0x9A, 0x32, 0x20, 0x99, 0xE6
        ]
        
        let nonce: [UInt8] = [
            0x32, 0x42, 0x44, 0x43, 0x37, 0x43, 0x48, 0x34, 0x36
        ]
        
        let timestamp = Date(timeIntervalSince1970: 1_554_371_320.0)

        XCTAssertEqual(capability.carSignature, carSignature)
        XCTAssertEqual(capability.nonce, nonce)
        XCTAssertEqual(capability.timestamp, timestamp)
    }
}
