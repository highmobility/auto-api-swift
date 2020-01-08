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
//  AARaceTest.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import AutoAPI
import XCTest


class AARaceTest: XCTestCase {

    // MARK: State Properties

    func testBrakeTorqueVectorings() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x57, 0x01, 0x0a, 0x00, 0x05, 0x01, 0x00, 0x02, 0x00, 0x01, 0x0a, 0x00, 0x05, 0x01, 0x00, 0x02, 0x01, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AARace else {
            return XCTFail("Could not parse bytes as AARace")
        }
    
        guard let brakeTorqueVectorings = capability.brakeTorqueVectorings?.compactMap({ $0.value }) else {
            return XCTFail("Could not extract .brakeTorqueVectorings values")
        }
    
        XCTAssertTrue(brakeTorqueVectorings.contains { $0 == AABrakeTorqueVectoring(axle: .front, state: .active) })
        XCTAssertTrue(brakeTorqueVectorings.contains { $0 == AABrakeTorqueVectoring(axle: .rear, state: .inactive) })
    }

    func testSelectedGear() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x57, 0x01, 0x0c, 0x00, 0x04, 0x01, 0x00, 0x01, 0x04]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AARace else {
            return XCTFail("Could not parse bytes as AARace")
        }
    
        XCTAssertEqual(capability.selectedGear?.value, 4)
    }

    func testGasPedalPosition() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x57, 0x01, 0x04, 0x00, 0x0b, 0x01, 0x00, 0x08, 0x3f, 0xef, 0x5c, 0x28, 0xf5, 0xc2, 0x8f, 0x5c]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AARace else {
            return XCTFail("Could not parse bytes as AARace")
        }
    
        XCTAssertEqual(capability.gasPedalPosition?.value, 0.98)
    }

    func testGearMode() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x57, 0x01, 0x0b, 0x00, 0x04, 0x01, 0x00, 0x01, 0x04]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AARace else {
            return XCTFail("Could not parse bytes as AARace")
        }
    
        XCTAssertEqual(capability.gearMode?.value, .drive)
    }

    func testAcceleratorPedalIdleSwitch() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x57, 0x01, 0x10, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AARace else {
            return XCTFail("Could not parse bytes as AARace")
        }
    
        XCTAssertEqual(capability.acceleratorPedalIdleSwitch?.value, .active)
    }

    func testAccelerations() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x57, 0x01, 0x01, 0x00, 0x08, 0x01, 0x00, 0x05, 0x00, 0x3f, 0x5d, 0x2f, 0x1b, 0x01, 0x00, 0x08, 0x01, 0x00, 0x05, 0x01, 0xbf, 0x40, 0xc4, 0x9c, 0x01, 0x00, 0x08, 0x01, 0x00, 0x05, 0x02, 0xbf, 0x40, 0xc4, 0x9c, 0x01, 0x00, 0x08, 0x01, 0x00, 0x05, 0x03, 0xbf, 0x40, 0xc4, 0x9c]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AARace else {
            return XCTFail("Could not parse bytes as AARace")
        }
    
        guard let accelerations = capability.accelerations?.compactMap({ $0.value }) else {
            return XCTFail("Could not extract .accelerations values")
        }
    
        XCTAssertTrue(accelerations.contains { $0 == AAAcceleration(direction: .longitudinal, gForce: 0.864) })
        XCTAssertTrue(accelerations.contains { $0 == AAAcceleration(direction: .lateral, gForce: -0.753) })
        XCTAssertTrue(accelerations.contains { $0 == AAAcceleration(direction: .frontLateral, gForce: -0.753) })
        XCTAssertTrue(accelerations.contains { $0 == AAAcceleration(direction: .rearLateral, gForce: -0.753) })
    }

    func testBrakePedalSwitch() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x57, 0x01, 0x0e, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AARace else {
            return XCTFail("Could not parse bytes as AARace")
        }
    
        XCTAssertEqual(capability.brakePedalSwitch?.value, .active)
    }

    func testElectronicStabilityProgram() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x57, 0x01, 0x09, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AARace else {
            return XCTFail("Could not parse bytes as AARace")
        }
    
        XCTAssertEqual(capability.electronicStabilityProgram?.value, .active)
    }

    func testVehicleMoving() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x57, 0x01, 0x12, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AARace else {
            return XCTFail("Could not parse bytes as AARace")
        }
    
        XCTAssertEqual(capability.vehicleMoving?.value, .moving)
    }

    func testBrakePressure() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x57, 0x01, 0x06, 0x00, 0x07, 0x01, 0x00, 0x04, 0x41, 0xa0, 0x00, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AARace else {
            return XCTFail("Could not parse bytes as AARace")
        }
    
        XCTAssertEqual(capability.brakePressure?.value, 20.0)
    }

    func testUndersteering() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x57, 0x01, 0x02, 0x00, 0x0b, 0x01, 0x00, 0x08, 0x3f, 0xc8, 0x51, 0xeb, 0x85, 0x1e, 0xb8, 0x52]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AARace else {
            return XCTFail("Could not parse bytes as AARace")
        }
    
        XCTAssertEqual(capability.understeering?.value, 0.19)
    }

    func testAcceleratorPedalKickdownSwitch() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x57, 0x01, 0x11, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AARace else {
            return XCTFail("Could not parse bytes as AARace")
        }
    
        XCTAssertEqual(capability.acceleratorPedalKickdownSwitch?.value, .active)
    }

    func testClutchPedalSwitch() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x57, 0x01, 0x0f, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AARace else {
            return XCTFail("Could not parse bytes as AARace")
        }
    
        XCTAssertEqual(capability.clutchPedalSwitch?.value, .active)
    }

    func testBrakePedalPosition() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x57, 0x01, 0x0d, 0x00, 0x0b, 0x01, 0x00, 0x08, 0x3f, 0xbe, 0xb8, 0x51, 0xeb, 0x85, 0x1e, 0xb8]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AARace else {
            return XCTFail("Could not parse bytes as AARace")
        }
    
        XCTAssertEqual(capability.brakePedalPosition?.value, 0.12)
    }

    func testYawRate() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x57, 0x01, 0x07, 0x00, 0x07, 0x01, 0x00, 0x04, 0x40, 0xd5, 0x1e, 0xb8]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AARace else {
            return XCTFail("Could not parse bytes as AARace")
        }
    
        XCTAssertEqual(capability.yawRate?.value, 6.66)
    }

    func testOversteering() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x57, 0x01, 0x03, 0x00, 0x0b, 0x01, 0x00, 0x08, 0x3f, 0xa9, 0x99, 0x99, 0x99, 0x99, 0x99, 0x9a]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AARace else {
            return XCTFail("Could not parse bytes as AARace")
        }
    
        XCTAssertEqual(capability.oversteering?.value, 0.05)
    }

    func testSteeringAngle() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x57, 0x01, 0x05, 0x00, 0x04, 0x01, 0x00, 0x01, 0x0a]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AARace else {
            return XCTFail("Could not parse bytes as AARace")
        }
    
        XCTAssertEqual(capability.steeringAngle?.value, 10)
    }

    func testRearSuspensionSteering() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x57, 0x01, 0x08, 0x00, 0x04, 0x01, 0x00, 0x01, 0x03]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AARace else {
            return XCTFail("Could not parse bytes as AARace")
        }
    
        XCTAssertEqual(capability.rearSuspensionSteering?.value, 3)
    }

    
    // MARK: Getters

    func testGetRaceState() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x57, 0x00]
    
        XCTAssertEqual(bytes, AARace.getRaceState())
    }
    
    func testGetRaceProperties() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x57, 0x00, 0x12]
        let getterBytes = AARace.getRaceProperties(propertyIDs: .vehicleMoving)
    
        XCTAssertEqual(bytes, getterBytes)
    }
}