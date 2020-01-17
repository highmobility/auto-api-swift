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
//  AAVehicleStatusTest.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import AutoAPI
import XCTest


class AAVehicleStatusTest: XCTestCase {

    // MARK: State Properties

    func testGearbox() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x11, 0x01, 0x0e, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAVehicleStatus else {
            return XCTFail("Could not parse bytes as AAVehicleStatus")
        }
    
        XCTAssertEqual(capability.gearbox?.value, .automatic)
    }

    func testVin() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x11, 0x01, 0x01, 0x00, 0x14, 0x01, 0x00, 0x11, 0x4a, 0x46, 0x32, 0x53, 0x48, 0x42, 0x44, 0x43, 0x37, 0x43, 0x48, 0x34, 0x35, 0x31, 0x38, 0x36, 0x39]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAVehicleStatus else {
            return XCTFail("Could not parse bytes as AAVehicleStatus")
        }
    
        XCTAssertEqual(capability.vin?.value, "JF2SHBDC7CH451869")
    }

    func testModelName() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x11, 0x01, 0x03, 0x00, 0x09, 0x01, 0x00, 0x06, 0x54, 0x79, 0x70, 0x65, 0x20, 0x58]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAVehicleStatus else {
            return XCTFail("Could not parse bytes as AAVehicleStatus")
        }
    
        XCTAssertEqual(capability.modelName?.value, "Type X")
    }

    func testPowertrain() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x11, 0x01, 0x02, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAVehicleStatus else {
            return XCTFail("Could not parse bytes as AAVehicleStatus")
        }
    
        XCTAssertEqual(capability.powertrain?.value, .allElectric)
    }

    func testLicensePlate() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x11, 0x01, 0x05, 0x00, 0x09, 0x01, 0x00, 0x06, 0x41, 0x42, 0x43, 0x31, 0x32, 0x33]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAVehicleStatus else {
            return XCTFail("Could not parse bytes as AAVehicleStatus")
        }
    
        XCTAssertEqual(capability.licensePlate?.value, "ABC123")
    }

    func testColourName() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x11, 0x01, 0x08, 0x00, 0x0f, 0x01, 0x00, 0x0c, 0x45, 0x73, 0x74, 0x6f, 0x72, 0x69, 0x6c, 0x20, 0x42, 0x6c, 0x61, 0x75]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAVehicleStatus else {
            return XCTFail("Could not parse bytes as AAVehicleStatus")
        }
    
        XCTAssertEqual(capability.colourName?.value, "Estoril Blau")
    }

    func testNumberOfSeats() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x11, 0x01, 0x0b, 0x00, 0x04, 0x01, 0x00, 0x01, 0x05]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAVehicleStatus else {
            return XCTFail("Could not parse bytes as AAVehicleStatus")
        }
    
        XCTAssertEqual(capability.numberOfSeats?.value, 5)
    }

    func testEngineMaxTorque() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x11, 0x01, 0x0d, 0x00, 0x05, 0x01, 0x00, 0x02, 0x00, 0xf5]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAVehicleStatus else {
            return XCTFail("Could not parse bytes as AAVehicleStatus")
        }
    
        XCTAssertEqual(capability.engineMaxTorque?.value, 245)
    }

    func testDriverSeatLocation() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x11, 0x01, 0x10, 0x00, 0x04, 0x01, 0x00, 0x01, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAVehicleStatus else {
            return XCTFail("Could not parse bytes as AAVehicleStatus")
        }
    
        XCTAssertEqual(capability.driverSeatLocation?.value, .left)
    }

    func testDisplayUnit() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x11, 0x01, 0x0f, 0x00, 0x04, 0x01, 0x00, 0x01, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAVehicleStatus else {
            return XCTFail("Could not parse bytes as AAVehicleStatus")
        }
    
        XCTAssertEqual(capability.displayUnit?.value, .km)
    }

    func testEquipments() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x11, 0x01, 0x11, 0x00, 0x12, 0x01, 0x00, 0x0f, 0x50, 0x61, 0x72, 0x6b, 0x69, 0x6e, 0x67, 0x20, 0x73, 0x65, 0x6e, 0x73, 0x6f, 0x72, 0x73, 0x11, 0x00, 0x13, 0x01, 0x00, 0x10, 0x41, 0x75, 0x74, 0x6f, 0x6d, 0x61, 0x74, 0x69, 0x63, 0x20, 0x77, 0x69, 0x70, 0x65, 0x72, 0x73]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAVehicleStatus else {
            return XCTFail("Could not parse bytes as AAVehicleStatus")
        }
    
        guard let equipments = capability.equipments?.compactMap({ $0.value }) else {
            return XCTFail("Could not extract .equipments values")
        }
    
        XCTAssertTrue(equipments.contains { $0 == "Parking sensors" })
        XCTAssertTrue(equipments.contains { $0 == "Automatic wipers" })
    }

    func testSalesDesignation() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x11, 0x01, 0x06, 0x00, 0x0b, 0x01, 0x00, 0x08, 0x50, 0x61, 0x63, 0x6b, 0x61, 0x67, 0x65, 0x2b]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAVehicleStatus else {
            return XCTFail("Could not parse bytes as AAVehicleStatus")
        }
    
        XCTAssertEqual(capability.salesDesignation?.value, "Package+")
    }

    func testBrand() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x11, 0x01, 0x12, 0x00, 0x08, 0x01, 0x00, 0x05, 0x54, 0x65, 0x73, 0x6c, 0x61]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAVehicleStatus else {
            return XCTFail("Could not parse bytes as AAVehicleStatus")
        }
    
        XCTAssertEqual(capability.brand?.value, "Tesla")
    }

    func testModelYear() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x11, 0x01, 0x07, 0x00, 0x05, 0x01, 0x00, 0x02, 0x07, 0xe3]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAVehicleStatus else {
            return XCTFail("Could not parse bytes as AAVehicleStatus")
        }
    
        XCTAssertEqual(capability.modelYear?.value, 2019)
    }

    func testName() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x11, 0x01, 0x04, 0x00, 0x09, 0x01, 0x00, 0x06, 0x53, 0x70, 0x65, 0x65, 0x64, 0x79]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAVehicleStatus else {
            return XCTFail("Could not parse bytes as AAVehicleStatus")
        }
    
        XCTAssertEqual(capability.name?.value, "Speedy")
    }

    func testEngineVolume() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x11, 0x01, 0x0c, 0x00, 0x07, 0x01, 0x00, 0x04, 0x40, 0x20, 0x00, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAVehicleStatus else {
            return XCTFail("Could not parse bytes as AAVehicleStatus")
        }
    
        XCTAssertEqual(capability.engineVolume?.value, 2.5)
    }

    func testStates() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x11, 0x01, 0x99, 0x00, 0x16, 0x01, 0x00, 0x13, 0x0b, 0x00, 0x20, 0x01, 0x06, 0x00, 0x04, 0x01, 0x00, 0x01, 0x00, 0x04, 0x00, 0x05, 0x01, 0x00, 0x02, 0x00, 0x01, 0x99, 0x00, 0x18, 0x01, 0x00, 0x15, 0x0b, 0x00, 0x23, 0x01, 0x0a, 0x00, 0x07, 0x01, 0x00, 0x04, 0x40, 0x60, 0x00, 0x00, 0x0b, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAVehicleStatus else {
            return XCTFail("Could not parse bytes as AAVehicleStatus")
        }
    
        guard let states = capability.states?.compactMap({ $0.value }) else {
            return XCTFail("Could not extract .states values")
        }
    
        XCTAssertTrue(states.contains { $0 is AADoors })
        XCTAssertTrue(states.contains { $0 is AACharging })
    }

    func testPowerInKW() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x11, 0x01, 0x09, 0x00, 0x05, 0x01, 0x00, 0x02, 0x00, 0xdc]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAVehicleStatus else {
            return XCTFail("Could not parse bytes as AAVehicleStatus")
        }
    
        XCTAssertEqual(capability.powerInKW?.value, 220)
    }

    func testNumberOfDoors() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x11, 0x01, 0x0a, 0x00, 0x04, 0x01, 0x00, 0x01, 0x05]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAVehicleStatus else {
            return XCTFail("Could not parse bytes as AAVehicleStatus")
        }
    
        XCTAssertEqual(capability.numberOfDoors?.value, 5)
    }

    
    // MARK: Getters

    func testGetVehicleStatus() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x11, 0x00]
    
        XCTAssertEqual(bytes, AAVehicleStatus.getVehicleStatus())
    }
    
    func testGetVehicleStatusProperties() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x11, 0x00, 0x99]
        let getterBytes = AAVehicleStatus.getVehicleStatusProperties(propertyIDs: .states)
    
        XCTAssertEqual(bytes, getterBytes)
    }
}