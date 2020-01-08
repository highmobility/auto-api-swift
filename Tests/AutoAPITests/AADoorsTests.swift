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
//  AADoorsTest.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import AutoAPI
import XCTest


class AADoorsTest: XCTestCase {

    // MARK: State Properties

    func testPositions() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x20, 0x01, 0x04, 0x00, 0x05, 0x01, 0x00, 0x02, 0x00, 0x01, 0x04, 0x00, 0x05, 0x01, 0x00, 0x02, 0x01, 0x00, 0x04, 0x00, 0x05, 0x01, 0x00, 0x02, 0x02, 0x00, 0x04, 0x00, 0x05, 0x01, 0x00, 0x02, 0x03, 0x00, 0x04, 0x00, 0x05, 0x01, 0x00, 0x02, 0x05, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AADoors else {
            return XCTFail("Could not parse bytes as AADoors")
        }
    
        guard let positions = capability.positions?.compactMap({ $0.value }) else {
            return XCTFail("Could not extract .positions values")
        }
    
        XCTAssertTrue(positions.contains { $0 == AADoorPosition(location: .frontLeft, position: .open) })
        XCTAssertTrue(positions.contains { $0 == AADoorPosition(location: .frontRight, position: .closed) })
        XCTAssertTrue(positions.contains { $0 == AADoorPosition(location: .rearRight, position: .closed) })
        XCTAssertTrue(positions.contains { $0 == AADoorPosition(location: .rearLeft, position: .closed) })
        XCTAssertTrue(positions.contains { $0 == AADoorPosition(location: .all, position: .closed) })
    }

    func testInsideLocksState() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x20, 0x01, 0x05, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AADoors else {
            return XCTFail("Could not parse bytes as AADoors")
        }
    
        XCTAssertEqual(capability.insideLocksState?.value, .locked)
    }

    func testLocksState() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x20, 0x01, 0x06, 0x00, 0x04, 0x01, 0x00, 0x01, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AADoors else {
            return XCTFail("Could not parse bytes as AADoors")
        }
    
        XCTAssertEqual(capability.locksState?.value, .unlocked)
    }

    func testLocks() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x20, 0x01, 0x03, 0x00, 0x05, 0x01, 0x00, 0x02, 0x00, 0x00, 0x03, 0x00, 0x05, 0x01, 0x00, 0x02, 0x01, 0x00, 0x03, 0x00, 0x05, 0x01, 0x00, 0x02, 0x02, 0x01, 0x03, 0x00, 0x05, 0x01, 0x00, 0x02, 0x03, 0x01]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AADoors else {
            return XCTFail("Could not parse bytes as AADoors")
        }
    
        guard let locks = capability.locks?.compactMap({ $0.value }) else {
            return XCTFail("Could not extract .locks values")
        }
    
        XCTAssertTrue(locks.contains { $0 == AALock(location: .frontLeft, lockState: .unlocked) })
        XCTAssertTrue(locks.contains { $0 == AALock(location: .frontRight, lockState: .unlocked) })
        XCTAssertTrue(locks.contains { $0 == AALock(location: .rearRight, lockState: .locked) })
        XCTAssertTrue(locks.contains { $0 == AALock(location: .rearLeft, lockState: .locked) })
    }

    func testInsideLocks() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x20, 0x01, 0x02, 0x00, 0x05, 0x01, 0x00, 0x02, 0x00, 0x01, 0x02, 0x00, 0x05, 0x01, 0x00, 0x02, 0x01, 0x00, 0x02, 0x00, 0x05, 0x01, 0x00, 0x02, 0x02, 0x00, 0x02, 0x00, 0x05, 0x01, 0x00, 0x02, 0x03, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AADoors else {
            return XCTFail("Could not parse bytes as AADoors")
        }
    
        guard let insideLocks = capability.insideLocks?.compactMap({ $0.value }) else {
            return XCTFail("Could not extract .insideLocks values")
        }
    
        XCTAssertTrue(insideLocks.contains { $0 == AALock(location: .frontLeft, lockState: .locked) })
        XCTAssertTrue(insideLocks.contains { $0 == AALock(location: .frontRight, lockState: .unlocked) })
        XCTAssertTrue(insideLocks.contains { $0 == AALock(location: .rearRight, lockState: .unlocked) })
        XCTAssertTrue(insideLocks.contains { $0 == AALock(location: .rearLeft, lockState: .unlocked) })
    }

    
    // MARK: Getters

    func testGetDoorsState() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x20, 0x00]
    
        XCTAssertEqual(bytes, AADoors.getDoorsState())
    }
    
    func testGetDoorsProperties() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x20, 0x00, 0x06]
        let getterBytes = AADoors.getDoorsProperties(propertyIDs: .locksState)
    
        XCTAssertEqual(bytes, getterBytes)
    }

    
    // MARK: Setters

    func testLockUnlockDoors() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x20, 0x01] + [0x06, 0x00, 0x04, 0x01, 0x00, 0x01, 0x00]
        let setterBytes = AADoors.lockUnlockDoors(locksState: .unlocked)
    
        XCTAssertEqual(bytes, setterBytes)
    }
}