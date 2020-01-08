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
//  AAMaintenanceTest.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import AutoAPI
import XCTest


class AAMaintenanceTest: XCTestCase {

    // MARK: State Properties

    func testMonthsToExhaustInspection() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x34, 0x01, 0x04, 0x00, 0x04, 0x01, 0x00, 0x01, 0x05]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAMaintenance else {
            return XCTFail("Could not parse bytes as AAMaintenance")
        }
    
        XCTAssertEqual(capability.monthsToExhaustInspection?.value, 5)
    }

    func testTeleserviceAvailability() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x34, 0x01, 0x05, 0x00, 0x04, 0x01, 0x00, 0x01, 0x02]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAMaintenance else {
            return XCTFail("Could not parse bytes as AAMaintenance")
        }
    
        XCTAssertEqual(capability.teleserviceAvailability?.value, .successful)
    }

    func testCbsReportsCount() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x34, 0x01, 0x03, 0x00, 0x04, 0x01, 0x00, 0x01, 0x03]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAMaintenance else {
            return XCTFail("Could not parse bytes as AAMaintenance")
        }
    
        XCTAssertEqual(capability.cbsReportsCount?.value, 3)
    }

    func testServiceDistanceThreshold() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x34, 0x01, 0x06, 0x00, 0x05, 0x01, 0x00, 0x02, 0x01, 0xf4]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAMaintenance else {
            return XCTFail("Could not parse bytes as AAMaintenance")
        }
    
        XCTAssertEqual(capability.serviceDistanceThreshold?.value, 500)
    }

    func testDaysToNextService() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x34, 0x01, 0x01, 0x00, 0x05, 0x01, 0x00, 0x02, 0x01, 0xf5]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAMaintenance else {
            return XCTFail("Could not parse bytes as AAMaintenance")
        }
    
        XCTAssertEqual(capability.daysToNextService?.value, 501)
    }

    func testServiceTimeThreshold() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x34, 0x01, 0x07, 0x00, 0x04, 0x01, 0x00, 0x01, 0x04]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAMaintenance else {
            return XCTFail("Could not parse bytes as AAMaintenance")
        }
    
        XCTAssertEqual(capability.serviceTimeThreshold?.value, 4)
    }

    func testAutomaticTeleserviceCallDate() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x34, 0x01, 0x08, 0x00, 0x0b, 0x01, 0x00, 0x08, 0x00, 0x00, 0x01, 0x67, 0x40, 0x58, 0xf1, 0x30]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAMaintenance else {
            return XCTFail("Could not parse bytes as AAMaintenance")
        }
    
        XCTAssertEqual(capability.automaticTeleserviceCallDate?.value, DateFormatter.hmFormatter.date(from: "2018-11-23T11:33:50.000Z")!)
    }

    func testTeleserviceBatteryCallDate() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x34, 0x01, 0x09, 0x00, 0x0b, 0x01, 0x00, 0x08, 0x00, 0x00, 0x01, 0x67, 0x40, 0x24, 0xc1, 0xd0]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAMaintenance else {
            return XCTFail("Could not parse bytes as AAMaintenance")
        }
    
        XCTAssertEqual(capability.teleserviceBatteryCallDate?.value, DateFormatter.hmFormatter.date(from: "2018-11-23T10:36:50.000Z")!)
    }

    func testNextInspectionDate() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x34, 0x01, 0x0a, 0x00, 0x0b, 0x01, 0x00, 0x08, 0x00, 0x00, 0x01, 0x66, 0xa1, 0x5d, 0x20, 0xd8]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAMaintenance else {
            return XCTFail("Could not parse bytes as AAMaintenance")
        }
    
        XCTAssertEqual(capability.nextInspectionDate?.value, DateFormatter.hmFormatter.date(from: "2018-10-23T14:38:47.000Z")!)
    }

    func testConditionBasedServices() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x34, 0x01, 0x0b, 0x00, 0x44, 0x01, 0x00, 0x41, 0x07, 0xe3, 0x05, 0x00, 0x03, 0x00, 0x00, 0x0b, 0x42, 0x72, 0x61, 0x6b, 0x65, 0x20, 0x66, 0x6c, 0x75, 0x69, 0x64, 0x00, 0x2c, 0x4e, 0x65, 0x78, 0x74, 0x20, 0x63, 0x68, 0x61, 0x6e, 0x67, 0x65, 0x20, 0x61, 0x74, 0x20, 0x73, 0x70, 0x65, 0x63, 0x69, 0x66, 0x69, 0x65, 0x64, 0x20, 0x64, 0x61, 0x74, 0x65, 0x20, 0x61, 0x74, 0x20, 0x74, 0x68, 0x65, 0x20, 0x6c, 0x61, 0x74, 0x65, 0x73, 0x74, 0x2e]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAMaintenance else {
            return XCTFail("Could not parse bytes as AAMaintenance")
        }
    
        guard let conditionBasedServices = capability.conditionBasedServices?.compactMap({ $0.value }) else {
            return XCTFail("Could not extract .conditionBasedServices values")
        }
    
        XCTAssertTrue(conditionBasedServices.contains { $0 == AAConditionBasedService(year: 2019, month: 5, id: 3, dueStatus: .ok, text: "Brake fluid", description: "Next change at specified date at the latest.") })
    }

    func testBrakeFluidChangeDate() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x34, 0x01, 0x0c, 0x00, 0x0b, 0x01, 0x00, 0x08, 0x00, 0x00, 0x01, 0x67, 0x7c, 0x63, 0xd2, 0x80]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAMaintenance else {
            return XCTFail("Could not parse bytes as AAMaintenance")
        }
    
        XCTAssertEqual(capability.brakeFluidChangeDate?.value, DateFormatter.hmFormatter.date(from: "2018-12-05T03:22:56.000Z")!)
    }

    func testKilometersToNextService() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x34, 0x01, 0x02, 0x00, 0x07, 0x01, 0x00, 0x04, 0x00, 0x00, 0x0e, 0x61]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAMaintenance else {
            return XCTFail("Could not parse bytes as AAMaintenance")
        }
    
        XCTAssertEqual(capability.kilometersToNextService?.value, 3681)
    }

    
    // MARK: Getters

    func testGetMaintenanceState() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x34, 0x00]
    
        XCTAssertEqual(bytes, AAMaintenance.getMaintenanceState())
    }
    
    func testGetMaintenanceProperties() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x34, 0x00, 0x0c]
        let getterBytes = AAMaintenance.getMaintenanceProperties(propertyIDs: .brakeFluidChangeDate)
    
        XCTAssertEqual(bytes, getterBytes)
    }
}