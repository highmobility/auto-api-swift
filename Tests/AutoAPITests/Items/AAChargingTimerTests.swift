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
//  AAChargingTimerTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 26/03/2019.
//  Copyright © 2019 High Mobility GmbH. All rights reserved.
//

@testable import AutoAPI
import XCTest


class AAChargingTimerTests: XCTestCase {

    static var allTests = [("testBytes", testBytes),
                           ("testInit", testInit)]


    // MARK: XCTestCase

    func testBytes() {
        let bytes: [UInt8] = [
            0x02,                                           // Departure Date
            0x00, 0x00, 0x01, 0x6B, 0x08, 0xCE, 0x5F, 0x58  // 30 May 2019 at 12:54:31 GMT
        ]

        let date = Date(timeIntervalSince1970: 1_559_220_871.0)

        XCTAssertEqual(AAChargingTimer(type: .departureDate, time: date).bytes, bytes)
    }

    func testInit() {
        // Successful
        let bytes1: [UInt8] = [
            0x00,                                           // Preffered Start Time
            0x00, 0x00, 0x01, 0x6B, 0x08, 0xCE, 0x5F, 0x58  // 30 May 2019 at 12:54:31 GMT
        ]

        if let timer = AAChargingTimer(bytes: bytes1) {
            XCTAssertEqual(timer.type, .prefferedStartTime)
            XCTAssertEqual(timer.time, Date(timeIntervalSince1970: 1_559_220_871.0))
        }
        else {
            XCTFail("Failed to initialise AAChargingTimer")
        }

        // Fail#1
        let bytes2: [UInt8] = [
            0x01    // Invalid bytes count
        ]

        XCTAssertNil(AAChargingTimer(bytes: bytes2))

        // Fail#2
        let bytes3: [UInt8] = [
            0x05,                                           // Invalid Type
            0x00, 0x00, 0x01, 0x6B, 0x08, 0xCE, 0x5F, 0x58  // 30 May 2019 at 12:54:31 GMT
        ]

        XCTAssertNil(AAChargingTimer(bytes: bytes3))
    }
}
