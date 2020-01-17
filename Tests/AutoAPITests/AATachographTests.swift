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
//  AATachographTest.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import AutoAPI
import XCTest


class AATachographTest: XCTestCase {

    // MARK: State Properties

    func testDriversWorkingStates() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x64, 0x01, 0x01, 0x00, 0x05, 0x01, 0x00, 0x02, 0x01, 0x02, 0x01, 0x00, 0x05, 0x01, 0x00, 0x02, 0x02, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AATachograph else {
            return XCTFail("Could not parse bytes as AATachograph")
        }
    
        guard let driversWorkingStates = capability.driversWorkingStates?.compactMap({ $0.value }) else {
            return XCTFail("Could not extract .driversWorkingStates values")
        }
    
        XCTAssertTrue(driversWorkingStates.contains { $0 == AADriverWorkingState(driverNumber: 1, workingState: .working) })
        XCTAssertTrue(driversWorkingStates.contains { $0 == AADriverWorkingState(driverNumber: 2, workingState: .resting) })
    }

    func testDriversTimeStates() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x64, 0x01, 0x02, 0x00, 0x05, 0x01, 0x00, 0x02, 0x03, 0x02, 0x02, 0x00, 0x05, 0x01, 0x00, 0x02, 0x04, 0x05]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AATachograph else {
            return XCTFail("Could not parse bytes as AATachograph")
        }
    
        guard let driversTimeStates = capability.driversTimeStates?.compactMap({ $0.value }) else {
            return XCTFail("Could not extract .driversTimeStates values")
        }
    
        XCTAssertTrue(driversTimeStates.contains { $0 == AADriverTimeState(driverNumber: 3, timeState: .fourReached) })
        XCTAssertTrue(driversTimeStates.contains { $0 == AADriverTimeState(driverNumber: 4, timeState: .fifteenMinBeforeSixteen) })
    }

    func testDriversCardsPresent() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x64, 0x01, 0x03, 0x00, 0x05, 0x01, 0x00, 0x02, 0x06, 0x01, 0x03, 0x00, 0x05, 0x01, 0x00, 0x02, 0x07, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AATachograph else {
            return XCTFail("Could not parse bytes as AATachograph")
        }
    
        guard let driversCardsPresent = capability.driversCardsPresent?.compactMap({ $0.value }) else {
            return XCTFail("Could not extract .driversCardsPresent values")
        }
    
        XCTAssertTrue(driversCardsPresent.contains { $0 == AADriverCardPresent(driverNumber: 6, cardPresent: .present) })
        XCTAssertTrue(driversCardsPresent.contains { $0 == AADriverCardPresent(driverNumber: 7, cardPresent: .notPresent) })
    }

    func testVehicleOverspeed() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x64, 0x01, 0x05, 0x00, 0x04, 0x01, 0x00, 0x01, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AATachograph else {
            return XCTFail("Could not parse bytes as AATachograph")
        }
    
        XCTAssertEqual(capability.vehicleOverspeed?.value, .noOverspeed)
    }

    func testVehicleSpeed() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x64, 0x01, 0x07, 0x00, 0x05, 0x01, 0x00, 0x02, 0x00, 0x50]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AATachograph else {
            return XCTFail("Could not parse bytes as AATachograph")
        }
    
        XCTAssertEqual(capability.vehicleSpeed?.value, 80)
    }

    func testVehicleDirection() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x64, 0x01, 0x06, 0x00, 0x04, 0x01, 0x00, 0x01, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AATachograph else {
            return XCTFail("Could not parse bytes as AATachograph")
        }
    
        XCTAssertEqual(capability.vehicleDirection?.value, .forward)
    }

    func testVehicleMotion() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x64, 0x01, 0x04, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AATachograph else {
            return XCTFail("Could not parse bytes as AATachograph")
        }
    
        XCTAssertEqual(capability.vehicleMotion?.value, .detected)
    }

    
    // MARK: Getters

    func testGetTachographState() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x64, 0x00]
    
        XCTAssertEqual(bytes, AATachograph.getTachographState())
    }
    
    func testGetTachographProperties() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x64, 0x00, 0x07]
        let getterBytes = AATachograph.getTachographProperties(propertyIDs: .vehicleSpeed)
    
        XCTAssertEqual(bytes, getterBytes)
    }
}