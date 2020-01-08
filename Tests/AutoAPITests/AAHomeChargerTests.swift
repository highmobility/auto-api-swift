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
//  AAHomeChargerTest.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import AutoAPI
import XCTest


class AAHomeChargerTest: XCTestCase {

    // MARK: State Properties

    func testWiFiHotspotPassword() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x60, 0x01, 0x0b, 0x00, 0x0d, 0x01, 0x00, 0x0a, 0x5a, 0x57, 0x33, 0x76, 0x41, 0x52, 0x4e, 0x55, 0x42, 0x65]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAHomeCharger else {
            return XCTFail("Could not parse bytes as AAHomeCharger")
        }
    
        XCTAssertEqual(capability.wiFiHotspotPassword?.value, "ZW3vARNUBe")
    }

    func testMaximumChargeCurrent() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x60, 0x01, 0x0f, 0x00, 0x07, 0x01, 0x00, 0x04, 0x3f, 0x80, 0x00, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAHomeCharger else {
            return XCTFail("Could not parse bytes as AAHomeCharger")
        }
    
        XCTAssertEqual(capability.maximumChargeCurrent?.value, 1.0)
    }

    func testSolarCharging() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x60, 0x01, 0x05, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAHomeCharger else {
            return XCTFail("Could not parse bytes as AAHomeCharger")
        }
    
        XCTAssertEqual(capability.solarCharging?.value, .active)
    }

    func testPlugType() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x60, 0x01, 0x03, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAHomeCharger else {
            return XCTFail("Could not parse bytes as AAHomeCharger")
        }
    
        XCTAssertEqual(capability.plugType?.value, .type2)
    }

    func testWiFiHotspotSecurity() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x60, 0x01, 0x0a, 0x00, 0x04, 0x01, 0x00, 0x01, 0x03]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAHomeCharger else {
            return XCTFail("Could not parse bytes as AAHomeCharger")
        }
    
        XCTAssertEqual(capability.wiFiHotspotSecurity?.value, .wpa2Personal)
    }

    func testAuthenticationState() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x60, 0x01, 0x0d, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAHomeCharger else {
            return XCTFail("Could not parse bytes as AAHomeCharger")
        }
    
        XCTAssertEqual(capability.authenticationState?.value, .authenticated)
    }

    func testCoordinates() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x60, 0x01, 0x11, 0x00, 0x13, 0x01, 0x00, 0x10, 0x40, 0x4a, 0x42, 0x8f, 0x9f, 0x44, 0xd4, 0x45, 0x40, 0x2a, 0xcf, 0x56, 0x21, 0x74, 0xc4, 0xce]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAHomeCharger else {
            return XCTFail("Could not parse bytes as AAHomeCharger")
        }
    
        XCTAssertEqual(capability.coordinates?.value, AACoordinates(latitude: 52.520008, longitude: 13.404954))
    }

    func testChargeCurrentDC() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x60, 0x01, 0x0e, 0x00, 0x07, 0x01, 0x00, 0x04, 0x3f, 0x00, 0x00, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAHomeCharger else {
            return XCTFail("Could not parse bytes as AAHomeCharger")
        }
    
        XCTAssertEqual(capability.chargeCurrentDC?.value, 0.5)
    }

    func testWifiHotspotSSID() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x60, 0x01, 0x09, 0x00, 0x0f, 0x01, 0x00, 0x0c, 0x43, 0x68, 0x61, 0x72, 0x67, 0x65, 0x72, 0x20, 0x37, 0x36, 0x31, 0x32]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAHomeCharger else {
            return XCTFail("Could not parse bytes as AAHomeCharger")
        }
    
        XCTAssertEqual(capability.wifiHotspotSSID?.value, "Charger 7612")
    }

    func testMinimumChargeCurrent() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x60, 0x01, 0x10, 0x00, 0x07, 0x01, 0x00, 0x04, 0x00, 0x00, 0x00, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAHomeCharger else {
            return XCTFail("Could not parse bytes as AAHomeCharger")
        }
    
        XCTAssertEqual(capability.minimumChargeCurrent?.value, 0.0)
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

    func testAuthenticationMechanism() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x60, 0x01, 0x02, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAHomeCharger else {
            return XCTFail("Could not parse bytes as AAHomeCharger")
        }
    
        XCTAssertEqual(capability.authenticationMechanism?.value, .app)
    }

    func testWifiHotspotEnabled() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x60, 0x01, 0x08, 0x00, 0x04, 0x01, 0x00, 0x01, 0x01]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAHomeCharger else {
            return XCTFail("Could not parse bytes as AAHomeCharger")
        }
    
        XCTAssertEqual(capability.wifiHotspotEnabled?.value, .enabled)
    }

    func testChargingStatus() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x60, 0x01, 0x01, 0x00, 0x04, 0x01, 0x00, 0x01, 0x02]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAHomeCharger else {
            return XCTFail("Could not parse bytes as AAHomeCharger")
        }
    
        XCTAssertEqual(capability.chargingStatus?.value, .charging)
    }

    func testChargingPowerKW() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x60, 0x01, 0x04, 0x00, 0x07, 0x01, 0x00, 0x04, 0x41, 0x38, 0x00, 0x00]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAHomeCharger else {
            return XCTFail("Could not parse bytes as AAHomeCharger")
        }
    
        XCTAssertEqual(capability.chargingPowerKW?.value, 11.5)
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