//
//  The MIT License
//
//  Copyright (c) 2014- High-Mobility GmbH (https://high-mobility.com)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//
//
//  AASeatsTest.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import AutoAPI
import XCTest


class AASeatsTest: XCTestCase {

    // MARK: State Properties

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