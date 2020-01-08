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
//  AATachographTest.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
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

    func testVehicleMotion() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x64, 0x01, 0x04, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AATachograph else {
            return XCTFail("Could not parse bytes as AATachograph")
        }
    
        XCTAssertEqual(capability.vehicleMotion?.value, .detected)
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

    func testVehicleOverspeed() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x64, 0x01, 0x05, 0x00, 0x04, 0x01, 0x00, 0x01, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AATachograph else {
            return XCTFail("Could not parse bytes as AATachograph")
        }
    
        XCTAssertEqual(capability.vehicleOverspeed?.value, .noOverspeed)
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