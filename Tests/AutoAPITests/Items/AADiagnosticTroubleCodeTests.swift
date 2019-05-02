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
//  AADiagnosticTroubleCodeTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 03/04/2019.
//  Copyright © 2019 High Mobility GmbH. All rights reserved.
//

@testable import AutoAPI
import XCTest


class AADiagnosticTroubleCodeTests: XCTestCase {

    static var allTests = [("testBytes", testBytes),
                           ("testInit", testInit)]


    // MARK: XCTestCase

    func testBytes() {
        let bytes: [UInt8] = [
            0x02,                                                   // Occured twice
            0x07,                                                   // ID size is 7 bytes
            0x43, 0x31, 0x31, 0x31, 0x36, 0x46, 0x41,               // ID is "C1116FA"
            0x09,                                                   // ECU ID size is 9 bytes
            0x52, 0x44, 0x55, 0x5F, 0x32, 0x31, 0x32, 0x46, 0x52,   // ECU ID is "RDU_212FR"
            0x07,                                                   // Status size is 7 bytes
            0x50, 0x45, 0x4E, 0x44, 0x49, 0x4E, 0x47                // Status is "PENDING"
        ]

        XCTAssertEqual(AADiagnosticTroubleCode(ecuID: "RDU_212FR", id: "C1116FA", occurences: 2, status: "PENDING").bytes, bytes)
    }

    func testInit() {
        // Successful
        let bytes1: [UInt8] = [
            0x02,                                                   // Occured twice
            0x07,                                                   // ID size is 7 bytes
            0x43, 0x31, 0x31, 0x31, 0x36, 0x46, 0x41,               // ID is "C1116FA"
            0x09,                                                   // ECU ID size is 9 bytes
            0x52, 0x44, 0x55, 0x5F, 0x32, 0x31, 0x32, 0x46, 0x52,   // ECU ID is "RDU_212FR"
            0x07,                                                   // Status size is 7 bytes
            0x50, 0x45, 0x4E, 0x44, 0x49, 0x4E, 0x47                // Status is "PENDING"
        ]

        if let dtc = AADiagnosticTroubleCode(bytes: bytes1) {
            XCTAssertEqual(dtc.occurences, 2)
            XCTAssertEqual(dtc.id, "C1116FA")
            XCTAssertEqual(dtc.ecuID, "RDU_212FR")
            XCTAssertEqual(dtc.status, "PENDING")
        }
        else {
            XCTFail("Failed to initialise AADiagnosticTroubleCode")
        }

        // Fail#1
        let bytes2: [UInt8] = [
            0x01    // Invalid bytes count
        ]

        XCTAssertNil(AADiagnosticTroubleCode(bytes: bytes2))

        // Fail#2
        let bytes3: [UInt8] = [
            0x02,                                                   // Occured twice
            0x57,                                                   // ID size is INVALID
            0x43, 0x31, 0x31, 0x31, 0x36, 0x46, 0x41,               // ID is "C1116FA"
            0x09,                                                   // ECU ID size is 9 bytes
            0x52, 0x44, 0x55, 0x5F, 0x32, 0x31, 0x32, 0x46, 0x52,   // ECU ID is "RDU_212FR"
            0x07,                                                   // Status size is 7 bytes
            0x50, 0x45, 0x4E, 0x44, 0x49, 0x4E, 0x47                // Status is "PENDING"
        ]

        XCTAssertNil(AADiagnosticTroubleCode(bytes: bytes3))

        // Fail#3
        let bytes4: [UInt8] = [
            0x02,                                                   // Occured twice
            0x07,                                                   // ID size is 7 bytes
            0x43, 0x31, 0x31, 0x31, 0x36, 0x46, 0x41,               // ID is "C1116FA"
            0x59,                                                   // ECU ID size is INVALID
            0x52, 0x44, 0x55, 0x5F, 0x32, 0x31, 0x32, 0x46, 0x52,   // ECU ID is "RDU_212FR"
            0x07,                                                   // Status size is 7 bytes
            0x50, 0x45, 0x4E, 0x44, 0x49, 0x4E, 0x47                // Status is "PENDING"
        ]

        XCTAssertNil(AADiagnosticTroubleCode(bytes: bytes4))

        // Fail#4
        let bytes5: [UInt8] = [
            0x02,                                                   // Occured twice
            0x07,                                                   // ID size is 7 bytes
            0x43, 0x31, 0x31, 0x31, 0x36, 0x46, 0x41,               // ID is "C1116FA"
            0x09,                                                   // ECU ID size is 9 bytes
            0x52, 0x44, 0x55, 0x5F, 0x32, 0x31, 0x32, 0x46, 0x52,   // ECU ID is "RDU_212FR"
            0x57,                                                   // Status size is INVALID
            0x50, 0x45, 0x4E, 0x44, 0x49, 0x4E, 0x47                // Status is "PENDING"
        ]

        XCTAssertNil(AADiagnosticTroubleCode(bytes: bytes5))

        // Fail#5
        let bytes6: [UInt8] = [
            0x02,                                                   // Occured twice
            0x07,                                                   // ID size is 7 bytes
            0x43, 0x31, 0xF1, 0xF1, 0xF6, 0xF6, 0x41,               // ID is INVALID
            0x09,                                                   // ECU ID size is 9 bytes
            0x52, 0x44, 0x55, 0x5F, 0x32, 0x31, 0x32, 0x46, 0x52,   // ECU ID is "RDU_212FR"
            0x07,                                                   // Status size is 7 bytes
            0x50, 0x45, 0x4E, 0x44, 0x49, 0x4E, 0x47                // Status is "PENDING"
        ]

        XCTAssertNil(AADiagnosticTroubleCode(bytes: bytes6))
    }
}
