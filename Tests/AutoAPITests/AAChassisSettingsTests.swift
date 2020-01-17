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
//  AAChassisSettingsTest.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import AutoAPI
import XCTest


class AAChassisSettingsTest: XCTestCase {

    // MARK: State Properties

    func testSportChrono() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x53, 0x01, 0x02, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAChassisSettings else {
            return XCTFail("Could not parse bytes as AAChassisSettings")
        }
    
        XCTAssertEqual(capability.sportChrono?.value, .active)
    }

    func testCurrentChassisPosition() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x53, 0x01, 0x08, 0x00, 0x04, 0x01, 0x00, 0x01, 0x19]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAChassisSettings else {
            return XCTFail("Could not parse bytes as AAChassisSettings")
        }
    
        XCTAssertEqual(capability.currentChassisPosition?.value, 25)
    }

    func testMaximumChassisPosition() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x53, 0x01, 0x09, 0x00, 0x04, 0x01, 0x00, 0x01, 0x37]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAChassisSettings else {
            return XCTFail("Could not parse bytes as AAChassisSettings")
        }
    
        XCTAssertEqual(capability.maximumChassisPosition?.value, 55)
    }

    func testMinimumChassisPosition() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x53, 0x01, 0x0a, 0x00, 0x04, 0x01, 0x00, 0x01, 0xe4]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAChassisSettings else {
            return XCTFail("Could not parse bytes as AAChassisSettings")
        }
    
        XCTAssertEqual(capability.minimumChassisPosition?.value, -28)
    }

    func testCurrentSpringRates() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x53, 0x01, 0x05, 0x00, 0x05, 0x01, 0x00, 0x02, 0x00, 0x15, 0x05, 0x00, 0x05, 0x01, 0x00, 0x02, 0x01, 0x17]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAChassisSettings else {
            return XCTFail("Could not parse bytes as AAChassisSettings")
        }
    
        guard let currentSpringRates = capability.currentSpringRates?.compactMap({ $0.value }) else {
            return XCTFail("Could not extract .currentSpringRates values")
        }
    
        XCTAssertTrue(currentSpringRates.contains { $0 == AASpringRate(axle: .front, springRate: 21) })
        XCTAssertTrue(currentSpringRates.contains { $0 == AASpringRate(axle: .rear, springRate: 23) })
    }

    func testMaximumSpringRates() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x53, 0x01, 0x06, 0x00, 0x05, 0x01, 0x00, 0x02, 0x00, 0x25, 0x06, 0x00, 0x05, 0x01, 0x00, 0x02, 0x01, 0x27]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAChassisSettings else {
            return XCTFail("Could not parse bytes as AAChassisSettings")
        }
    
        guard let maximumSpringRates = capability.maximumSpringRates?.compactMap({ $0.value }) else {
            return XCTFail("Could not extract .maximumSpringRates values")
        }
    
        XCTAssertTrue(maximumSpringRates.contains { $0 == AASpringRate(axle: .front, springRate: 37) })
        XCTAssertTrue(maximumSpringRates.contains { $0 == AASpringRate(axle: .rear, springRate: 39) })
    }

    func testDrivingMode() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x53, 0x01, 0x01, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAChassisSettings else {
            return XCTFail("Could not parse bytes as AAChassisSettings")
        }
    
        XCTAssertEqual(capability.drivingMode?.value, .eco)
    }

    func testMinimumSpringRates() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x53, 0x01, 0x07, 0x00, 0x05, 0x01, 0x00, 0x02, 0x00, 0x10, 0x07, 0x00, 0x05, 0x01, 0x00, 0x02, 0x01, 0x12]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAChassisSettings else {
            return XCTFail("Could not parse bytes as AAChassisSettings")
        }
    
        guard let minimumSpringRates = capability.minimumSpringRates?.compactMap({ $0.value }) else {
            return XCTFail("Could not extract .minimumSpringRates values")
        }
    
        XCTAssertTrue(minimumSpringRates.contains { $0 == AASpringRate(axle: .front, springRate: 16) })
        XCTAssertTrue(minimumSpringRates.contains { $0 == AASpringRate(axle: .rear, springRate: 18) })
    }

    
    // MARK: Getters

    func testGetChassisSettings() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x53, 0x00]
    
        XCTAssertEqual(bytes, AAChassisSettings.getChassisSettings())
    }
    
    func testGetChassisSettingsProperties() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x53, 0x00, 0x0a]
        let getterBytes = AAChassisSettings.getChassisSettingsProperties(propertyIDs: .minimumChassisPosition)
    
        XCTAssertEqual(bytes, getterBytes)
    }

    
    // MARK: Setters

    func testSetDrivingMode() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x53, 0x01] + [0x01, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
        let setterBytes = AAChassisSettings.setDrivingMode(drivingMode: .eco)
    
        XCTAssertEqual(bytes, setterBytes)
    }

    func testStartStopSportsChrono() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x53, 0x01] + [0x02, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
        let setterBytes = AAChassisSettings.startStopSportsChrono(sportChrono: .active)
    
        XCTAssertEqual(bytes, setterBytes)
    }

    func testSetSpringRates() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x53, 0x01] + [0x05, 0x00, 0x05, 0x01, 0x00, 0x02, 0x00, 0x15]
        let setterBytes = AAChassisSettings.setSpringRates(currentSpringRates: [AASpringRate(axle: .front, springRate: 21)])
    
        XCTAssertEqual(bytes, setterBytes)
    }

    func testSetChassisPosition() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x53, 0x01] + [0x08, 0x00, 0x04, 0x01, 0x00, 0x01, 0x19]
        let setterBytes = AAChassisSettings.setChassisPosition(currentChassisPosition: 25)
    
        XCTAssertEqual(bytes, setterBytes)
    }
}