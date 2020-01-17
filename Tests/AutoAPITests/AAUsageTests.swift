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
//  AAUsageTest.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import AutoAPI
import XCTest


class AAUsageTest: XCTestCase {

    // MARK: State Properties

    func testLastTripAverageEnergyRecuperation() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x68, 0x01, 0x0b, 0x00, 0x07, 0x01, 0x00, 0x04, 0x40, 0xb5, 0xc2, 0x8f]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAUsage else {
            return XCTFail("Could not parse bytes as AAUsage")
        }
    
        XCTAssertEqual(capability.lastTripAverageEnergyRecuperation?.value, 5.68)
    }

    func testDrivingModesEnergyConsumptions() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x68, 0x01, 0x06, 0x00, 0x08, 0x01, 0x00, 0x05, 0x00, 0x41, 0xa1, 0x99, 0x9a, 0x06, 0x00, 0x08, 0x01, 0x00, 0x05, 0x01, 0x42, 0x04, 0xcc, 0xcd, 0x06, 0x00, 0x08, 0x01, 0x00, 0x05, 0x02, 0x42, 0x58, 0x00, 0x00, 0x06, 0x00, 0x08, 0x01, 0x00, 0x05, 0x03, 0x42, 0x81, 0x99, 0x9a, 0x06, 0x00, 0x08, 0x01, 0x00, 0x05, 0x04, 0x41, 0x90, 0x00, 0x00, 0x06, 0x00, 0x08, 0x01, 0x00, 0x05, 0x05, 0x42, 0x06, 0x66, 0x66]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAUsage else {
            return XCTFail("Could not parse bytes as AAUsage")
        }
    
        guard let drivingModesEnergyConsumptions = capability.drivingModesEnergyConsumptions?.compactMap({ $0.value }) else {
            return XCTFail("Could not extract .drivingModesEnergyConsumptions values")
        }
    
        XCTAssertTrue(drivingModesEnergyConsumptions.contains { $0 == AADrivingModeEnergyConsumption(drivingMode: .regular, consumption: 20.2) })
        XCTAssertTrue(drivingModesEnergyConsumptions.contains { $0 == AADrivingModeEnergyConsumption(drivingMode: .eco, consumption: 33.2) })
        XCTAssertTrue(drivingModesEnergyConsumptions.contains { $0 == AADrivingModeEnergyConsumption(drivingMode: .sport, consumption: 54.0) })
        XCTAssertTrue(drivingModesEnergyConsumptions.contains { $0 == AADrivingModeEnergyConsumption(drivingMode: .sportPlus, consumption: 64.8) })
        XCTAssertTrue(drivingModesEnergyConsumptions.contains { $0 == AADrivingModeEnergyConsumption(drivingMode: .ecoplus, consumption: 18.0) })
        XCTAssertTrue(drivingModesEnergyConsumptions.contains { $0 == AADrivingModeEnergyConsumption(drivingMode: .comfort, consumption: 33.6) })
    }

    func testLastTripBatteryRemaining() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x68, 0x01, 0x0c, 0x00, 0x0b, 0x01, 0x00, 0x08, 0x3f, 0xe0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAUsage else {
            return XCTFail("Could not parse bytes as AAUsage")
        }
    
        XCTAssertEqual(capability.lastTripBatteryRemaining?.value, 0.5)
    }

    func testAccelerationEvaluation() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x68, 0x01, 0x03, 0x00, 0x0b, 0x01, 0x00, 0x08, 0x3f, 0xe6, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAUsage else {
            return XCTFail("Could not parse bytes as AAUsage")
        }
    
        XCTAssertEqual(capability.accelerationEvaluation?.value, 0.7)
    }

    func testLastTripFuelConsumption() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x68, 0x01, 0x08, 0x00, 0x07, 0x01, 0x00, 0x04, 0x41, 0xb4, 0x00, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAUsage else {
            return XCTFail("Could not parse bytes as AAUsage")
        }
    
        XCTAssertEqual(capability.lastTripFuelConsumption?.value, 22.5)
    }

    func testMileageAfterLastTrip() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x68, 0x01, 0x09, 0x00, 0x07, 0x01, 0x00, 0x04, 0x00, 0x01, 0x75, 0x90]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAUsage else {
            return XCTFail("Could not parse bytes as AAUsage")
        }
    
        XCTAssertEqual(capability.mileageAfterLastTrip?.value, 95632)
    }

    func testDrivingModesActivationPeriods() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x68, 0x01, 0x05, 0x00, 0x0c, 0x01, 0x00, 0x09, 0x00, 0x3f, 0xc9, 0x99, 0x99, 0x99, 0x99, 0x99, 0x9a, 0x05, 0x00, 0x0c, 0x01, 0x00, 0x09, 0x01, 0x3f, 0xd3, 0x33, 0x33, 0x33, 0x33, 0x33, 0x33, 0x05, 0x00, 0x0c, 0x01, 0x00, 0x09, 0x02, 0x3f, 0xb9, 0x99, 0x99, 0x99, 0x99, 0x99, 0x9a, 0x05, 0x00, 0x0c, 0x01, 0x00, 0x09, 0x03, 0x3f, 0xb9, 0x99, 0x99, 0x99, 0x99, 0x99, 0x9a, 0x05, 0x00, 0x0c, 0x01, 0x00, 0x09, 0x04, 0x3f, 0xd3, 0x33, 0x33, 0x33, 0x33, 0x33, 0x33, 0x05, 0x00, 0x0c, 0x01, 0x00, 0x09, 0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAUsage else {
            return XCTFail("Could not parse bytes as AAUsage")
        }
    
        guard let drivingModesActivationPeriods = capability.drivingModesActivationPeriods?.compactMap({ $0.value }) else {
            return XCTFail("Could not extract .drivingModesActivationPeriods values")
        }
    
        XCTAssertTrue(drivingModesActivationPeriods.contains { $0 == AADrivingModeActivationPeriod(drivingMode: .regular, period: 0.2) })
        XCTAssertTrue(drivingModesActivationPeriods.contains { $0 == AADrivingModeActivationPeriod(drivingMode: .eco, period: 0.3) })
        XCTAssertTrue(drivingModesActivationPeriods.contains { $0 == AADrivingModeActivationPeriod(drivingMode: .sport, period: 0.1) })
        XCTAssertTrue(drivingModesActivationPeriods.contains { $0 == AADrivingModeActivationPeriod(drivingMode: .sportPlus, period: 0.1) })
        XCTAssertTrue(drivingModesActivationPeriods.contains { $0 == AADrivingModeActivationPeriod(drivingMode: .ecoplus, period: 0.3) })
        XCTAssertTrue(drivingModesActivationPeriods.contains { $0 == AADrivingModeActivationPeriod(drivingMode: .comfort, period: 0.0) })
    }

    func testLastTripEnergyConsumption() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x68, 0x01, 0x07, 0x00, 0x07, 0x01, 0x00, 0x04, 0x42, 0xca, 0x99, 0x9a]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAUsage else {
            return XCTFail("Could not parse bytes as AAUsage")
        }
    
        XCTAssertEqual(capability.lastTripEnergyConsumption?.value, 101.3)
    }

    func testDrivingStyleEvaluation() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x68, 0x01, 0x04, 0x00, 0x0b, 0x01, 0x00, 0x08, 0x3f, 0xec, 0x28, 0xf5, 0xc2, 0x8f, 0x5c, 0x29]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAUsage else {
            return XCTFail("Could not parse bytes as AAUsage")
        }
    
        XCTAssertEqual(capability.drivingStyleEvaluation?.value, 0.88)
    }

    func testCurrentFuelConsumption() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x68, 0x01, 0x0f, 0x00, 0x07, 0x01, 0x00, 0x04, 0x40, 0xf0, 0x00, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAUsage else {
            return XCTFail("Could not parse bytes as AAUsage")
        }
    
        XCTAssertEqual(capability.currentFuelConsumption?.value, 7.5)
    }

    func testAverageWeeklyDistanceLongRun() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x68, 0x01, 0x02, 0x00, 0x05, 0x01, 0x00, 0x02, 0x02, 0x9c]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAUsage else {
            return XCTFail("Could not parse bytes as AAUsage")
        }
    
        XCTAssertEqual(capability.averageWeeklyDistanceLongRun?.value, 668)
    }

    func testLastTripDate() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x68, 0x01, 0x0d, 0x00, 0x0b, 0x01, 0x00, 0x08, 0x00, 0x00, 0x01, 0x66, 0x82, 0x05, 0x9d, 0x50]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAUsage else {
            return XCTFail("Could not parse bytes as AAUsage")
        }
    
        XCTAssertEqual(capability.lastTripDate?.value, DateFormatter.hmFormatter.date(from: "2018-10-17T12:34:58.000Z")!)
    }

    func testAverageFuelConsumption() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x68, 0x01, 0x0e, 0x00, 0x07, 0x01, 0x00, 0x04, 0x40, 0xd0, 0x00, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAUsage else {
            return XCTFail("Could not parse bytes as AAUsage")
        }
    
        XCTAssertEqual(capability.averageFuelConsumption?.value, 6.5)
    }

    func testLastTripElectricPortion() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x68, 0x01, 0x0a, 0x00, 0x0b, 0x01, 0x00, 0x08, 0x3f, 0xe6, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAUsage else {
            return XCTFail("Could not parse bytes as AAUsage")
        }
    
        XCTAssertEqual(capability.lastTripElectricPortion?.value, 0.7)
    }

    func testAverageWeeklyDistance() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x68, 0x01, 0x01, 0x00, 0x05, 0x01, 0x00, 0x02, 0x02, 0x9a]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAUsage else {
            return XCTFail("Could not parse bytes as AAUsage")
        }
    
        XCTAssertEqual(capability.averageWeeklyDistance?.value, 666)
    }

    
    // MARK: Getters

    func testGetUsage() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x68, 0x00]
    
        XCTAssertEqual(bytes, AAUsage.getUsage())
    }
    
    func testGetUsageProperties() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x68, 0x00, 0x0f]
        let getterBytes = AAUsage.getUsageProperties(propertyIDs: .currentFuelConsumption)
    
        XCTAssertEqual(bytes, getterBytes)
    }
}