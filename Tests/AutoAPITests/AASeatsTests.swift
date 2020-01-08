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
//  AASeatsTest.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import AutoAPI
import XCTest


class AASeatsTest: XCTestCase {

    // MARK: State Properties

    func testSeatbeltsState() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x56, 0x01, 0x03, 0x00, 0x05, 0x01, 0x00, 0x02, 0x00, 0x01, 0x03, 0x00, 0x05, 0x01, 0x00, 0x02, 0x01, 0x00, 0x03, 0x00, 0x05, 0x01, 0x00, 0x02, 0x02, 0x00, 0x03, 0x00, 0x05, 0x01, 0x00, 0x02, 0x03, 0x00, 0x03, 0x00, 0x05, 0x01, 0x00, 0x02, 0x04, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AASeats else {
            return XCTFail("Could not parse bytes as AASeats")
        }
    
        guard let seatbeltsState = capability.seatbeltsState?.compactMap({ $0.value }) else {
            return XCTFail("Could not extract .seatbeltsState values")
        }
    
        XCTAssertTrue(seatbeltsState.contains { $0 == AASeatbeltState(location: .frontLeft, fastenedState: .fastened) })
        XCTAssertTrue(seatbeltsState.contains { $0 == AASeatbeltState(location: .frontRight, fastenedState: .notFastened) })
        XCTAssertTrue(seatbeltsState.contains { $0 == AASeatbeltState(location: .rearRight, fastenedState: .notFastened) })
        XCTAssertTrue(seatbeltsState.contains { $0 == AASeatbeltState(location: .rearLeft, fastenedState: .notFastened) })
        XCTAssertTrue(seatbeltsState.contains { $0 == AASeatbeltState(location: .rearCenter, fastenedState: .notFastened) })
    }

    func testPersonsDetected() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x56, 0x01, 0x02, 0x00, 0x05, 0x01, 0x00, 0x02, 0x00, 0x01, 0x02, 0x00, 0x05, 0x01, 0x00, 0x02, 0x01, 0x00, 0x02, 0x00, 0x05, 0x01, 0x00, 0x02, 0x02, 0x00, 0x02, 0x00, 0x05, 0x01, 0x00, 0x02, 0x03, 0x00, 0x02, 0x00, 0x05, 0x01, 0x00, 0x02, 0x04, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AASeats else {
            return XCTFail("Could not parse bytes as AASeats")
        }
    
        guard let personsDetected = capability.personsDetected?.compactMap({ $0.value }) else {
            return XCTFail("Could not extract .personsDetected values")
        }
    
        XCTAssertTrue(personsDetected.contains { $0 == AAPersonDetected(location: .frontLeft, detected: .detected) })
        XCTAssertTrue(personsDetected.contains { $0 == AAPersonDetected(location: .frontRight, detected: .notDetected) })
        XCTAssertTrue(personsDetected.contains { $0 == AAPersonDetected(location: .rearRight, detected: .notDetected) })
        XCTAssertTrue(personsDetected.contains { $0 == AAPersonDetected(location: .rearLeft, detected: .notDetected) })
        XCTAssertTrue(personsDetected.contains { $0 == AAPersonDetected(location: .rearCenter, detected: .notDetected) })
    }

    
    // MARK: Getters

    func testGetSeatsState() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x56, 0x00]
    
        XCTAssertEqual(bytes, AASeats.getSeatsState())
    }
    
    func testGetSeatsProperties() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x56, 0x00, 0x03]
        let getterBytes = AASeats.getSeatsProperties(propertyIDs: .seatbeltsState)
    
        XCTAssertEqual(bytes, getterBytes)
    }
}