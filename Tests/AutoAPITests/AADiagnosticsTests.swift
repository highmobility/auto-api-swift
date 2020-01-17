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
//  AADiagnosticsTest.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import AutoAPI
import XCTest


class AADiagnosticsTest: XCTestCase {

    // MARK: State Properties

    func testAdBlueLevel() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x33, 0x01, 0x0c, 0x00, 0x07, 0x01, 0x00, 0x04, 0x3f, 0x00, 0x00, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AADiagnostics else {
            return XCTFail("Could not parse bytes as AADiagnostics")
        }
    
        XCTAssertEqual(capability.adBlueLevel?.value, 0.5)
    }

    func testFuelLevel() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x33, 0x01, 0x05, 0x00, 0x0b, 0x01, 0x00, 0x08, 0x3f, 0xec, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcd]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AADiagnostics else {
            return XCTFail("Could not parse bytes as AADiagnostics")
        }
    
        XCTAssertEqual(capability.fuelLevel?.value, 0.9)
    }

    func testWheelRPMs() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x33, 0x01, 0x1c, 0x00, 0x06, 0x01, 0x00, 0x03, 0x00, 0x02, 0xea, 0x1c, 0x00, 0x06, 0x01, 0x00, 0x03, 0x01, 0x02, 0xea, 0x1c, 0x00, 0x06, 0x01, 0x00, 0x03, 0x02, 0x02, 0xea, 0x1c, 0x00, 0x06, 0x01, 0x00, 0x03, 0x03, 0x02, 0xea]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AADiagnostics else {
            return XCTFail("Could not parse bytes as AADiagnostics")
        }
    
        guard let wheelRPMs = capability.wheelRPMs?.compactMap({ $0.value }) else {
            return XCTFail("Could not extract .wheelRPMs values")
        }
    
        XCTAssertTrue(wheelRPMs.contains { $0 == AAWheelRPM(location: .frontLeft, RPM: 746) })
        XCTAssertTrue(wheelRPMs.contains { $0 == AAWheelRPM(location: .frontRight, RPM: 746) })
        XCTAssertTrue(wheelRPMs.contains { $0 == AAWheelRPM(location: .rearRight, RPM: 746) })
        XCTAssertTrue(wheelRPMs.contains { $0 == AAWheelRPM(location: .rearLeft, RPM: 746) })
    }

    func testTroubleCodes() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x33, 0x01, 0x1d, 0x00, 0x21, 0x01, 0x00, 0x1e, 0x02, 0x00, 0x07, 0x43, 0x31, 0x31, 0x31, 0x36, 0x46, 0x41, 0x00, 0x09, 0x52, 0x44, 0x55, 0x5f, 0x32, 0x31, 0x32, 0x46, 0x52, 0x00, 0x07, 0x50, 0x45, 0x4e, 0x44, 0x49, 0x4e, 0x47, 0x1d, 0x00, 0x1e, 0x01, 0x00, 0x1b, 0x02, 0x00, 0x07, 0x43, 0x31, 0x36, 0x33, 0x41, 0x46, 0x41, 0x00, 0x06, 0x44, 0x54, 0x52, 0x32, 0x31, 0x32, 0x00, 0x07, 0x50, 0x45, 0x4e, 0x44, 0x49, 0x4e, 0x47]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AADiagnostics else {
            return XCTFail("Could not parse bytes as AADiagnostics")
        }
    
        guard let troubleCodes = capability.troubleCodes?.compactMap({ $0.value }) else {
            return XCTFail("Could not extract .troubleCodes values")
        }
    
        XCTAssertTrue(troubleCodes.contains { $0 == AATroubleCode(occurences: 2, ID: "C1116FA", ecuID: "RDU_212FR", status: "PENDING") })
        XCTAssertTrue(troubleCodes.contains { $0 == AATroubleCode(occurences: 2, ID: "C163AFA", ecuID: "DTR212", status: "PENDING") })
    }

    func testWheelBasedSpeed() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x33, 0x01, 0x17, 0x00, 0x05, 0x01, 0x00, 0x02, 0x00, 0x41]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AADiagnostics else {
            return XCTFail("Could not parse bytes as AADiagnostics")
        }
    
        XCTAssertEqual(capability.wheelBasedSpeed?.value, 65)
    }

    func testSpeed() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x33, 0x01, 0x03, 0x00, 0x05, 0x01, 0x00, 0x02, 0x00, 0x3c]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AADiagnostics else {
            return XCTFail("Could not parse bytes as AADiagnostics")
        }
    
        XCTAssertEqual(capability.speed?.value, 60)
    }

    func testBrakeFluidLevel() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x33, 0x01, 0x14, 0x00, 0x04, 0x01, 0x00, 0x01, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AADiagnostics else {
            return XCTFail("Could not parse bytes as AADiagnostics")
        }
    
        XCTAssertEqual(capability.brakeFluidLevel?.value, .low)
    }

    func testEngineOilTemperature() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x33, 0x01, 0x02, 0x00, 0x05, 0x01, 0x00, 0x02, 0x00, 0x63]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AADiagnostics else {
            return XCTFail("Could not parse bytes as AADiagnostics")
        }
    
        XCTAssertEqual(capability.engineOilTemperature?.value, 99)
    }

    func testBatteryVoltage() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x33, 0x01, 0x0b, 0x00, 0x07, 0x01, 0x00, 0x04, 0x41, 0x40, 0x00, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AADiagnostics else {
            return XCTFail("Could not parse bytes as AADiagnostics")
        }
    
        XCTAssertEqual(capability.batteryVoltage?.value, 12.0)
    }

    func testFuelVolume() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x33, 0x01, 0x0f, 0x00, 0x07, 0x01, 0x00, 0x04, 0x42, 0x0e, 0x00, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AADiagnostics else {
            return XCTFail("Could not parse bytes as AADiagnostics")
        }
    
        XCTAssertEqual(capability.fuelVolume?.value, 35.5)
    }

    func testMileageMeters() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x33, 0x01, 0x1e, 0x00, 0x07, 0x01, 0x00, 0x04, 0x00, 0x02, 0x49, 0xf1]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AADiagnostics else {
            return XCTFail("Could not parse bytes as AADiagnostics")
        }
    
        XCTAssertEqual(capability.mileageMeters?.value, 150001)
    }

    func testEngineRPM() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x33, 0x01, 0x04, 0x00, 0x05, 0x01, 0x00, 0x02, 0x09, 0xc4]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AADiagnostics else {
            return XCTFail("Could not parse bytes as AADiagnostics")
        }
    
        XCTAssertEqual(capability.engineRPM?.value, 2500)
    }

    func testEstimatedRange() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x33, 0x01, 0x06, 0x00, 0x05, 0x01, 0x00, 0x02, 0x01, 0x09]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AADiagnostics else {
            return XCTFail("Could not parse bytes as AADiagnostics")
        }
    
        XCTAssertEqual(capability.estimatedRange?.value, 265)
    }

    func testWasherFluidLevel() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x33, 0x01, 0x09, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AADiagnostics else {
            return XCTFail("Could not parse bytes as AADiagnostics")
        }
    
        XCTAssertEqual(capability.washerFluidLevel?.value, .filled)
    }

    func testDistanceSinceReset() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x33, 0x01, 0x0d, 0x00, 0x05, 0x01, 0x00, 0x02, 0x05, 0xdc]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AADiagnostics else {
            return XCTFail("Could not parse bytes as AADiagnostics")
        }
    
        XCTAssertEqual(capability.distanceSinceReset?.value, 1500)
    }

    func testAntiLockBraking() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x33, 0x01, 0x10, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AADiagnostics else {
            return XCTFail("Could not parse bytes as AADiagnostics")
        }
    
        XCTAssertEqual(capability.antiLockBraking?.value, .active)
    }

    func testCheckControlMessages() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x33, 0x01, 0x19, 0x00, 0x1e, 0x01, 0x00, 0x1b, 0x00, 0x01, 0x00, 0x01, 0x9c, 0x78, 0x00, 0x0c, 0x43, 0x68, 0x65, 0x63, 0x6b, 0x20, 0x65, 0x6e, 0x67, 0x69, 0x6e, 0x65, 0x00, 0x05, 0x41, 0x6c, 0x65, 0x72, 0x74]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AADiagnostics else {
            return XCTFail("Could not parse bytes as AADiagnostics")
        }
    
        guard let checkControlMessages = capability.checkControlMessages?.compactMap({ $0.value }) else {
            return XCTFail("Could not extract .checkControlMessages values")
        }
    
        XCTAssertTrue(checkControlMessages.contains { $0 == AACheckControlMessage(ID: 1, remainingMinutes: 105592, text: "Check engine", status: "Alert") })
    }

    func testEngineCoolantTemperature() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x33, 0x01, 0x11, 0x00, 0x05, 0x01, 0x00, 0x02, 0x00, 0x14]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AADiagnostics else {
            return XCTFail("Could not parse bytes as AADiagnostics")
        }
    
        XCTAssertEqual(capability.engineCoolantTemperature?.value, 20)
    }

    func testEngineLoad() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x33, 0x01, 0x16, 0x00, 0x0b, 0x01, 0x00, 0x08, 0x3f, 0xb9, 0x99, 0x99, 0x99, 0x99, 0x99, 0x9a]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AADiagnostics else {
            return XCTFail("Could not parse bytes as AADiagnostics")
        }
    
        XCTAssertEqual(capability.engineLoad?.value, 0.1)
    }

    func testDistanceSinceStart() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x33, 0x01, 0x0e, 0x00, 0x05, 0x01, 0x00, 0x02, 0x00, 0x0a]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AADiagnostics else {
            return XCTFail("Could not parse bytes as AADiagnostics")
        }
    
        XCTAssertEqual(capability.distanceSinceStart?.value, 10)
    }

    func testEngineTotalOperatingHours() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x33, 0x01, 0x12, 0x00, 0x07, 0x01, 0x00, 0x04, 0x44, 0xbb, 0x94, 0xcd]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AADiagnostics else {
            return XCTFail("Could not parse bytes as AADiagnostics")
        }
    
        XCTAssertEqual(capability.engineTotalOperatingHours?.value, 1500.65)
    }

    func testTireTemperatures() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x33, 0x01, 0x1b, 0x00, 0x08, 0x01, 0x00, 0x05, 0x00, 0x42, 0x20, 0x00, 0x00, 0x1b, 0x00, 0x08, 0x01, 0x00, 0x05, 0x01, 0x42, 0x20, 0x00, 0x00, 0x1b, 0x00, 0x08, 0x01, 0x00, 0x05, 0x02, 0x42, 0x20, 0x00, 0x00, 0x1b, 0x00, 0x08, 0x01, 0x00, 0x05, 0x03, 0x42, 0x20, 0x00, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AADiagnostics else {
            return XCTFail("Could not parse bytes as AADiagnostics")
        }
    
        guard let tireTemperatures = capability.tireTemperatures?.compactMap({ $0.value }) else {
            return XCTFail("Could not extract .tireTemperatures values")
        }
    
        XCTAssertTrue(tireTemperatures.contains { $0 == AATireTemperature(location: .frontLeft, temperature: 40) })
        XCTAssertTrue(tireTemperatures.contains { $0 == AATireTemperature(location: .frontRight, temperature: 40) })
        XCTAssertTrue(tireTemperatures.contains { $0 == AATireTemperature(location: .rearRight, temperature: 40) })
        XCTAssertTrue(tireTemperatures.contains { $0 == AATireTemperature(location: .rearLeft, temperature: 40) })
    }

    func testTirePressures() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x33, 0x01, 0x1a, 0x00, 0x08, 0x01, 0x00, 0x05, 0x00, 0x40, 0x13, 0xd7, 0x0a, 0x1a, 0x00, 0x08, 0x01, 0x00, 0x05, 0x01, 0x40, 0x13, 0xd7, 0x0a, 0x1a, 0x00, 0x08, 0x01, 0x00, 0x05, 0x02, 0x40, 0x0f, 0x5c, 0x29, 0x1a, 0x00, 0x08, 0x01, 0x00, 0x05, 0x03, 0x40, 0x0f, 0x5c, 0x29]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AADiagnostics else {
            return XCTFail("Could not parse bytes as AADiagnostics")
        }
    
        guard let tirePressures = capability.tirePressures?.compactMap({ $0.value }) else {
            return XCTFail("Could not extract .tirePressures values")
        }
    
        XCTAssertTrue(tirePressures.contains { $0 == AATirePressure(location: .frontLeft, pressure: 2.31) })
        XCTAssertTrue(tirePressures.contains { $0 == AATirePressure(location: .frontRight, pressure: 2.31) })
        XCTAssertTrue(tirePressures.contains { $0 == AATirePressure(location: .rearRight, pressure: 2.24) })
        XCTAssertTrue(tirePressures.contains { $0 == AATirePressure(location: .rearLeft, pressure: 2.24) })
    }

    func testEngineTotalFuelConsumption() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x33, 0x01, 0x13, 0x00, 0x07, 0x01, 0x00, 0x04, 0x46, 0xd7, 0x86, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AADiagnostics else {
            return XCTFail("Could not parse bytes as AADiagnostics")
        }
    
        XCTAssertEqual(capability.engineTotalFuelConsumption?.value, 27587.0)
    }

    func testBatteryLevel() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x33, 0x01, 0x18, 0x00, 0x0b, 0x01, 0x00, 0x08, 0x3f, 0xe1, 0xeb, 0x85, 0x1e, 0xb8, 0x51, 0xec]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AADiagnostics else {
            return XCTFail("Could not parse bytes as AADiagnostics")
        }
    
        XCTAssertEqual(capability.batteryLevel?.value, 0.56)
    }

    func testMileage() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x33, 0x01, 0x01, 0x00, 0x07, 0x01, 0x00, 0x04, 0x00, 0x02, 0x49, 0xf0]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AADiagnostics else {
            return XCTFail("Could not parse bytes as AADiagnostics")
        }
    
        XCTAssertEqual(capability.mileage?.value, 150000)
    }

    func testEngineTorque() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x33, 0x01, 0x15, 0x00, 0x0b, 0x01, 0x00, 0x08, 0x3f, 0xc9, 0x99, 0x99, 0x99, 0x99, 0x99, 0x9a]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AADiagnostics else {
            return XCTFail("Could not parse bytes as AADiagnostics")
        }
    
        XCTAssertEqual(capability.engineTorque?.value, 0.2)
    }

    
    // MARK: Getters

    func testGetDiagnosticsState() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x33, 0x00]
    
        XCTAssertEqual(bytes, AADiagnostics.getDiagnosticsState())
    }
    
    func testGetDiagnosticsProperties() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x33, 0x00, 0x1e]
        let getterBytes = AADiagnostics.getDiagnosticsProperties(propertyIDs: .mileageMeters)
    
        XCTAssertEqual(bytes, getterBytes)
    }
}