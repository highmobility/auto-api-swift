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
//  AAPriceTariffTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 03/04/2019.
//  Copyright © 2019 High Mobility GmbH. All rights reserved.
//

@testable import AutoAPI
import XCTest


class AAPriceTariffTests: XCTestCase {

    static var allTests = [("testBytes", testBytes),
                           ("testInit", testInit)]


    // MARK: XCTestCase

    func testBytes() {
        let bytes: [UInt8] = [
            0x00,                   // Starting fee
            0x40, 0x90, 0x00, 0x00, // Price is 4.50
            0x03,                   // Currency string is 3 bytes
            0x45, 0x55, 0x52        // EUR
        ]

        XCTAssertEqual(AAPriceTariff(currency: "EUR", price: 4.5, type: .startingFee).bytes, bytes)
    }

    func testInit() {
        // Successful
        let bytes1: [UInt8] = [
            0x00,                   // Starting fee
            0x40, 0x90, 0x00, 0x00, // Price is 4.50
            0x03,                   // Currency string is 3 bytes
            0x45, 0x55, 0x52        // EUR
        ]

        if let tariff = AAPriceTariff(bytes: bytes1) {
            XCTAssertEqual(tariff.type, .startingFee)
            XCTAssertEqual(tariff.price, 4.5)
            XCTAssertEqual(tariff.currency, "EUR")
        }
        else {
            XCTFail("Failed to initialise AAPriceTariff")
        }

        // Fail#1
        let bytes2: [UInt8] = [
            0x01    // Invalid bytes count
        ]

        XCTAssertNil(AAPriceTariff(bytes: bytes2))

        // Fail#2
        let bytes3: [UInt8] = [
            0x00,                   // Starting fee
            0x40, 0x90, 0x00, 0x00, // Price is 4.50
            0x53,                   // Currency string is INVALID
            0x45, 0x55, 0x52        // EUR
        ]

        XCTAssertNil(AAPriceTariff(bytes: bytes3))

        // Fail#3
        let bytes4: [UInt8] = [
            0x0F,                   // INVALID
            0x40, 0x90, 0x00, 0x00, // Price is 4.50
            0x03,                   // Currency string is 3 bytes
            0x45, 0x55, 0x52        // EUR
        ]

        XCTAssertNil(AAPriceTariff(bytes: bytes4))
    }
}
