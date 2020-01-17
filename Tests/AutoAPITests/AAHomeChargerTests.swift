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
//  AAHomeChargerTest.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import AutoAPI
import XCTest


class AAHomeChargerTest: XCTestCase {

    // MARK: State Properties

    func testSolarCharging() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x60, 0x01, 0x05, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAHomeCharger else {
            return XCTFail("Could not parse bytes as AAHomeCharger")
        }
    
        XCTAssertEqual(capability.solarCharging?.value, .active)
    }

    func testMinimumChargeCurrent() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x60, 0x01, 0x10, 0x00, 0x07, 0x01, 0x00, 0x04, 0x00, 0x00, 0x00, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAHomeCharger else {
            return XCTFail("Could not parse bytes as AAHomeCharger")
        }
    
        XCTAssertEqual(capability.minimumChargeCurrent?.value, 0.0)
    }

    func testCoordinates() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x60, 0x01, 0x11, 0x00, 0x13, 0x01, 0x00, 0x10, 0x40, 0x4a, 0x42, 0x8f, 0x9f, 0x44, 0xd4, 0x45, 0x40, 0x2a, 0xcf, 0x56, 0x21, 0x74, 0xc4, 0xce]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAHomeCharger else {
            return XCTFail("Could not parse bytes as AAHomeCharger")
        }
    
        XCTAssertEqual(capability.coordinates?.value, AACoordinates(latitude: 52.520008, longitude: 13.404954))
    }

    func testWiFiHotspotSecurity() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x60, 0x01, 0x0a, 0x00, 0x04, 0x01, 0x00, 0x01, 0x03]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAHomeCharger else {
            return XCTFail("Could not parse bytes as AAHomeCharger")
        }
    
        XCTAssertEqual(capability.wiFiHotspotSecurity?.value, .wpa2Personal)
    }

    func testChargingPowerKW() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x60, 0x01, 0x04, 0x00, 0x07, 0x01, 0x00, 0x04, 0x41, 0x38, 0x00, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAHomeCharger else {
            return XCTFail("Could not parse bytes as AAHomeCharger")
        }
    
        XCTAssertEqual(capability.chargingPowerKW?.value, 11.5)
    }

    func testWiFiHotspotPassword() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x60, 0x01, 0x0b, 0x00, 0x0d, 0x01, 0x00, 0x0a, 0x5a, 0x57, 0x33, 0x76, 0x41, 0x52, 0x4e, 0x55, 0x42, 0x65]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAHomeCharger else {
            return XCTFail("Could not parse bytes as AAHomeCharger")
        }
    
        XCTAssertEqual(capability.wiFiHotspotPassword?.value, "ZW3vARNUBe")
    }

    func testWifiHotspotSSID() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x60, 0x01, 0x09, 0x00, 0x0f, 0x01, 0x00, 0x0c, 0x43, 0x68, 0x61, 0x72, 0x67, 0x65, 0x72, 0x20, 0x37, 0x36, 0x31, 0x32]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAHomeCharger else {
            return XCTFail("Could not parse bytes as AAHomeCharger")
        }
    
        XCTAssertEqual(capability.wifiHotspotSSID?.value, "Charger 7612")
    }

    func testWifiHotspotEnabled() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x60, 0x01, 0x08, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAHomeCharger else {
            return XCTFail("Could not parse bytes as AAHomeCharger")
        }
    
        XCTAssertEqual(capability.wifiHotspotEnabled?.value, .enabled)
    }

    func testMaximumChargeCurrent() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x60, 0x01, 0x0f, 0x00, 0x07, 0x01, 0x00, 0x04, 0x3f, 0x80, 0x00, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAHomeCharger else {
            return XCTFail("Could not parse bytes as AAHomeCharger")
        }
    
        XCTAssertEqual(capability.maximumChargeCurrent?.value, 1.0)
    }

    func testChargingStatus() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x60, 0x01, 0x01, 0x00, 0x04, 0x01, 0x00, 0x01, 0x02]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAHomeCharger else {
            return XCTFail("Could not parse bytes as AAHomeCharger")
        }
    
        XCTAssertEqual(capability.chargingStatus?.value, .charging)
    }

    func testAuthenticationMechanism() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x60, 0x01, 0x02, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAHomeCharger else {
            return XCTFail("Could not parse bytes as AAHomeCharger")
        }
    
        XCTAssertEqual(capability.authenticationMechanism?.value, .app)
    }

    func testPriceTariffs() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x60, 0x01, 0x12, 0x00, 0x0d, 0x01, 0x00, 0x0a, 0x00, 0x40, 0x90, 0x00, 0x00, 0x00, 0x03, 0x45, 0x55, 0x52, 0x12, 0x00, 0x0d, 0x01, 0x00, 0x0a, 0x01, 0x3e, 0x99, 0x99, 0x9a, 0x00, 0x03, 0x45, 0x55, 0x52, 0x12, 0x00, 0x10, 0x01, 0x00, 0x0d, 0x02, 0x3e, 0x99, 0x99, 0x9a, 0x00, 0x06, 0x52, 0x69, 0x70, 0x70, 0x6c, 0x65]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAHomeCharger else {
            return XCTFail("Could not parse bytes as AAHomeCharger")
        }
    
        guard let priceTariffs = capability.priceTariffs?.compactMap({ $0.value }) else {
            return XCTFail("Could not extract .priceTariffs values")
        }
    
        XCTAssertTrue(priceTariffs.contains { $0 == AAPriceTariff(pricingType: .startingFee, price: 4.5, currency: "EUR") })
        XCTAssertTrue(priceTariffs.contains { $0 == AAPriceTariff(pricingType: .perMinute, price: 0.3, currency: "EUR") })
        XCTAssertTrue(priceTariffs.contains { $0 == AAPriceTariff(pricingType: .perKwh, price: 0.3, currency: "Ripple") })
    }

    func testAuthenticationState() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x60, 0x01, 0x0d, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAHomeCharger else {
            return XCTFail("Could not parse bytes as AAHomeCharger")
        }
    
        XCTAssertEqual(capability.authenticationState?.value, .authenticated)
    }

    func testPlugType() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x60, 0x01, 0x03, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAHomeCharger else {
            return XCTFail("Could not parse bytes as AAHomeCharger")
        }
    
        XCTAssertEqual(capability.plugType?.value, .type2)
    }

    func testChargeCurrentDC() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x60, 0x01, 0x0e, 0x00, 0x07, 0x01, 0x00, 0x04, 0x3f, 0x00, 0x00, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAHomeCharger else {
            return XCTFail("Could not parse bytes as AAHomeCharger")
        }
    
        XCTAssertEqual(capability.chargeCurrentDC?.value, 0.5)
    }

    
    // MARK: Getters

    func testGetHomeChargerState() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x60, 0x00]
    
        XCTAssertEqual(bytes, AAHomeCharger.getHomeChargerState())
    }
    
    func testGetHomeChargerProperties() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x60, 0x00, 0x12]
        let getterBytes = AAHomeCharger.getHomeChargerProperties(propertyIDs: .priceTariffs)
    
        XCTAssertEqual(bytes, getterBytes)
    }

    
    // MARK: Setters

    func testSetChargeCurrent() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x60, 0x01] + [0x0e, 0x00, 0x07, 0x01, 0x00, 0x04, 0x3f, 0x00, 0x00, 0x00]
        let setterBytes = AAHomeCharger.setChargeCurrent(chargeCurrentDC: 0.5)
    
        XCTAssertEqual(bytes, setterBytes)
    }

    func testSetPriceTariffs() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x60, 0x01] + [0x12, 0x00, 0x0d, 0x01, 0x00, 0x0a, 0x00, 0x40, 0x90, 0x00, 0x00, 0x00, 0x03, 0x45, 0x55, 0x52]
        let setterBytes = AAHomeCharger.setPriceTariffs(priceTariffs: [AAPriceTariff(pricingType: .startingFee, price: 4.5, currency: "EUR")])
    
        XCTAssertEqual(bytes, setterBytes)
    }

    func testActivateDeactivateSolarCharging() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x60, 0x01] + [0x05, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
        let setterBytes = AAHomeCharger.activateDeactivateSolarCharging(solarCharging: .active)
    
        XCTAssertEqual(bytes, setterBytes)
    }

    func testEnableDisableWiFiHotspot() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x60, 0x01] + [0x08, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
        let setterBytes = AAHomeCharger.enableDisableWiFiHotspot(wifiHotspotEnabled: .enabled)
    
        XCTAssertEqual(bytes, setterBytes)
    }

    func testAuthenticateExpire() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x60, 0x01] + [0x0d, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
        let setterBytes = AAHomeCharger.authenticateExpire(authenticationState: .authenticated)
    
        XCTAssertEqual(bytes, setterBytes)
    }
}