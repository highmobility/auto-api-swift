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
//  AAVehicleStatusTest.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import AutoAPI
import XCTest


class AAVehicleStatusTest: XCTestCase {

    // MARK: State Properties

    func testModelName() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x11, 0x01, 0x03, 0x00, 0x09, 0x01, 0x00, 0x06, 0x54, 0x79, 0x70, 0x65, 0x20, 0x58]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAVehicleStatus else {
            return XCTFail("Could not parse bytes as AAVehicleStatus")
        }
    
        XCTAssertEqual(capability.modelName?.value, "Type X")
    }

    func testName() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x11, 0x01, 0x04, 0x00, 0x09, 0x01, 0x00, 0x06, 0x53, 0x70, 0x65, 0x65, 0x64, 0x79]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAVehicleStatus else {
            return XCTFail("Could not parse bytes as AAVehicleStatus")
        }
    
        XCTAssertEqual(capability.name?.value, "Speedy")
    }

    func testPowerInKW() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x11, 0x01, 0x09, 0x00, 0x05, 0x01, 0x00, 0x02, 0x00, 0xdc]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAVehicleStatus else {
            return XCTFail("Could not parse bytes as AAVehicleStatus")
        }
    
        XCTAssertEqual(capability.powerInKW?.value, 220)
    }

    func testEngineMaxTorque() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x11, 0x01, 0x0d, 0x00, 0x05, 0x01, 0x00, 0x02, 0x00, 0xf5]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAVehicleStatus else {
            return XCTFail("Could not parse bytes as AAVehicleStatus")
        }
    
        XCTAssertEqual(capability.engineMaxTorque?.value, 245)
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

    func testVin() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x11, 0x01, 0x01, 0x00, 0x14, 0x01, 0x00, 0x11, 0x4a, 0x46, 0x32, 0x53, 0x48, 0x42, 0x44, 0x43, 0x37, 0x43, 0x48, 0x34, 0x35, 0x31, 0x38, 0x36, 0x39]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAVehicleStatus else {
            return XCTFail("Could not parse bytes as AAVehicleStatus")
        }
    
        XCTAssertEqual(capability.vin?.value, "JF2SHBDC7CH451869")
    }

    func testNumberOfSeats() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x11, 0x01, 0x0b, 0x00, 0x04, 0x01, 0x00, 0x01, 0x05]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAVehicleStatus else {
            return XCTFail("Could not parse bytes as AAVehicleStatus")
        }
    
        XCTAssertEqual(capability.numberOfSeats?.value, 5)
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

    func testDriverSeatLocation() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x11, 0x01, 0x10, 0x00, 0x04, 0x01, 0x00, 0x01, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAVehicleStatus else {
            return XCTFail("Could not parse bytes as AAVehicleStatus")
        }
    
        XCTAssertEqual(capability.driverSeatLocation?.value, .left)
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

    func testDisplayUnit() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x11, 0x01, 0x0f, 0x00, 0x04, 0x01, 0x00, 0x01, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAVehicleStatus else {
            return XCTFail("Could not parse bytes as AAVehicleStatus")
        }
    
        XCTAssertEqual(capability.displayUnit?.value, .km)
    }

    func testNumberOfDoors() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x11, 0x01, 0x0a, 0x00, 0x04, 0x01, 0x00, 0x01, 0x05]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAVehicleStatus else {
            return XCTFail("Could not parse bytes as AAVehicleStatus")
        }
    
        XCTAssertEqual(capability.numberOfDoors?.value, 5)
    }

    func testModelYear() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x11, 0x01, 0x07, 0x00, 0x05, 0x01, 0x00, 0x02, 0x07, 0xe3]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAVehicleStatus else {
            return XCTFail("Could not parse bytes as AAVehicleStatus")
        }
    
        XCTAssertEqual(capability.modelYear?.value, 2019)
    }

    func testGearbox() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x11, 0x01, 0x0e, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAVehicleStatus else {
            return XCTFail("Could not parse bytes as AAVehicleStatus")
        }
    
        XCTAssertEqual(capability.gearbox?.value, .automatic)
    }

    func testColourName() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x11, 0x01, 0x08, 0x00, 0x0f, 0x01, 0x00, 0x0c, 0x45, 0x73, 0x74, 0x6f, 0x72, 0x69, 0x6c, 0x20, 0x42, 0x6c, 0x61, 0x75]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAVehicleStatus else {
            return XCTFail("Could not parse bytes as AAVehicleStatus")
        }
    
        XCTAssertEqual(capability.colourName?.value, "Estoril Blau")
    }

    func testEngineVolume() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x11, 0x01, 0x0c, 0x00, 0x07, 0x01, 0x00, 0x04, 0x40, 0x20, 0x00, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAVehicleStatus else {
            return XCTFail("Could not parse bytes as AAVehicleStatus")
        }
    
        XCTAssertEqual(capability.engineVolume?.value, 2.5)
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