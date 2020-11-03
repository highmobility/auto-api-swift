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
//  AADoorsTest.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import AutoAPI
import XCTest


class AADoorsTest: XCTestCase {

    // MARK: State Properties

    func testLocksState() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x20, 0x01, 0x06, 0x00, 0x04, 0x01, 0x00, 0x01, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AADoors else {
            return XCTFail("Could not parse bytes as AADoors")
        }
    
        XCTAssertEqual(capability.locksState?.value, .unlocked)
    }

    func testInsideLocksState() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x20, 0x01, 0x05, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AADoors else {
            return XCTFail("Could not parse bytes as AADoors")
        }
    
        XCTAssertEqual(capability.insideLocksState?.value, .locked)
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
