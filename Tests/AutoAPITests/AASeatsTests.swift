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
//  AASeatsTests.swift
//  AutoAPI
//
//  Generated by AutoAPIGenerator for Swift.
//  Copyright © 2021 High-Mobility GmbH. All rights reserved.
//

import Foundation
import HMUtilities
import XCTest
@testable import AutoAPI


final class AASeatsTests: XCTestCase {

    // MARK: State Properties
    
    func testPersonsDetected() {
        let bytes: [UInt8] = [0x0c, 0x00, 0x56, 0x01, 0x02, 0x00, 0x05, 0x01, 0x00, 0x02, 0x00, 0x01, 0x02, 0x00, 0x05, 0x01, 0x00, 0x02, 0x01, 0x00, 0x02, 0x00, 0x05, 0x01, 0x00, 0x02, 0x02, 0x00, 0x02, 0x00, 0x05, 0x01, 0x00, 0x02, 0x03, 0x00, 0x02, 0x00, 0x05, 0x01, 0x00, 0x02, 0x04, 0x00]
        
        guard let capability = try? AAAutoAPI.parseBytes(bytes) as? AASeats else {
            return XCTFail("Could not parse bytes as `AASeats`")
        }
        
        guard let personsDetected = capability.personsDetected?.compactMap({ $0.value }) else {
            return XCTFail("Could not get `.personsDetected` values from `AASeats` capability")
        }
        
        XCTAssertTrue(personsDetected.contains { $0.bytes == AAPersonDetected(location: .frontLeft, detected: .detected).bytes })
        XCTAssertTrue(personsDetected.contains { $0.bytes == AAPersonDetected(location: .frontRight, detected: .notDetected).bytes })
        XCTAssertTrue(personsDetected.contains { $0.bytes == AAPersonDetected(location: .rearRight, detected: .notDetected).bytes })
        XCTAssertTrue(personsDetected.contains { $0.bytes == AAPersonDetected(location: .rearLeft, detected: .notDetected).bytes })
        XCTAssertTrue(personsDetected.contains { $0.bytes == AAPersonDetected(location: .rearCenter, detected: .notDetected).bytes })
    }
    
    func testSeatbeltsState() {
        let bytes: [UInt8] = [0x0c, 0x00, 0x56, 0x01, 0x03, 0x00, 0x05, 0x01, 0x00, 0x02, 0x00, 0x01, 0x03, 0x00, 0x05, 0x01, 0x00, 0x02, 0x01, 0x00, 0x03, 0x00, 0x05, 0x01, 0x00, 0x02, 0x02, 0x00, 0x03, 0x00, 0x05, 0x01, 0x00, 0x02, 0x03, 0x00, 0x03, 0x00, 0x05, 0x01, 0x00, 0x02, 0x04, 0x00]
        
        guard let capability = try? AAAutoAPI.parseBytes(bytes) as? AASeats else {
            return XCTFail("Could not parse bytes as `AASeats`")
        }
        
        guard let seatbeltsState = capability.seatbeltsState?.compactMap({ $0.value }) else {
            return XCTFail("Could not get `.seatbeltsState` values from `AASeats` capability")
        }
        
        XCTAssertTrue(seatbeltsState.contains { $0.bytes == AASeatbeltState(location: .frontLeft, fastenedState: .fastened).bytes })
        XCTAssertTrue(seatbeltsState.contains { $0.bytes == AASeatbeltState(location: .frontRight, fastenedState: .notFastened).bytes })
        XCTAssertTrue(seatbeltsState.contains { $0.bytes == AASeatbeltState(location: .rearRight, fastenedState: .notFastened).bytes })
        XCTAssertTrue(seatbeltsState.contains { $0.bytes == AASeatbeltState(location: .rearLeft, fastenedState: .notFastened).bytes })
        XCTAssertTrue(seatbeltsState.contains { $0.bytes == AASeatbeltState(location: .rearCenter, fastenedState: .notFastened).bytes })
    }


    // MARK: Getters
    
    func testGetSeatsState() {
        let bytes: [UInt8] = [0x0c, 0x00, 0x56, 0x00]
        
        XCTAssertEqual(bytes, AASeats.getSeatsState())
    }
    
    func testGetSeatsStateAvailability() {
        let bytes: [UInt8] = [0x0c, 0x00, 0x56, 0x02]
        
        XCTAssertEqual(bytes, AASeats.getSeatsStateAvailability())
    }
    
    func testGetSeatsStateProperties() {
        let bytes: [UInt8] = [0x0c, 0x00, 0x56, 0x00, 0x02]
        let getterBytes = AASeats.getSeatsStateProperties(ids: .personsDetected)
        
        XCTAssertEqual(bytes, getterBytes)
    }
    
    func testGetSeatsStatePropertiesAvailability() {
        let bytes: [UInt8] = [0x0c, 0x00, 0x56, 0x02, 0x02]
        let getterBytes = AASeats.getSeatsStatePropertiesAvailability(ids: .personsDetected)
        
        XCTAssertEqual(bytes, getterBytes)
    }


    // MARK: Identifiers
    
    func testCapabilityIdentifier() {
        XCTAssertEqual(AASeats.identifier, 0x0056)
    }
    
    func testPropeertyIdentifiers() {
        XCTAssertEqual(AASeats.PropertyIdentifier.personsDetected.rawValue, 0x02)
        XCTAssertEqual(AASeats.PropertyIdentifier.seatbeltsState.rawValue, 0x03)
    }
}