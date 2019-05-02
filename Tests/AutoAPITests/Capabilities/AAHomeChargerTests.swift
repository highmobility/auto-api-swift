//
// AutoAPI
// Copyright (C) 2019 High-Mobility GmbH
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
//  AAHomeChargerTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 30/01/2018.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import AutoAPI
import XCTest


class AAHomeChargerTests: XCTestCase {

    static var allTests = [("testActivateDeactivateSolarCharging", testActivateDeactivateSolarCharging),
                           ("testEnableDisableWifiHotspot", testEnableDisableWifiHotspot),
                           ("testGetState", testGetState),
                           ("testSetAuthenticationState", testSetAuthenticationState),
                           ("testSetChargeCurrent", testSetChargeCurrent),
                           ("testSetPriceTariffs", testSetPriceTariffs),
                           ("testState", testState)]

    
    // MARK: XCTestCase

    func testActivateDeactivateSolarCharging() {
        let bytes: [UInt8] = [
            0x00, 0x60, // MSB, LSB Message Identifier for Home Charger
            0x14,       // Message Type for Activate/Deactivate Solar Charging

            0x01,       // Property Identifier for Solar charging
            0x00, 0x04, // Property size 4 bytes
            0x01,       // Data component
            0x00, 0x01, // Data component size 1 byte
            0x01        // Activate solar powered charging
        ]

        XCTAssertEqual(AAHomeCharger.activateSolarCharging(.active).bytes, bytes)
    }

    func testEnableDisableWifiHotspot() {
        let bytes: [UInt8] = [
            0x00, 0x60, // MSB, LSB Message Identifier for Home Charger
            0x15,       // Message Type for Enable/Disable Wi-Fi Hotspot

            0x01,       // Property Identifier for Wi-Fi enabled
            0x00, 0x04, // Property size 4 bytes
            0x01,       // Data component
            0x00, 0x01, // Data component size 1 byte
            0x00        // Disable Wi-Fi Hotspot
        ]

        XCTAssertEqual(AAHomeCharger.enableWifiHotspot(.disabled).bytes, bytes)
    }

    func testGetState() {
        let bytes: [UInt8] = [
            0x00, 0x60, // MSB, LSB Message Identifier for Home Charger
            0x00        // Message Type for Get Home Charger State
        ]

        XCTAssertEqual(AAHomeCharger.getChargerState.bytes, bytes)
    }

    func testSetAuthenticationState() {
        let bytes: [UInt8] = [
            0x00, 0x60, // MSB, LSB Message Identifier for Home Charger
            0x16,       // Message Type for Authenticate/Expire

            0x01,       // Property Identifier for Authentication
            0x00, 0x04, // Property size 4 byte
            0x01,       // Data component
            0x00, 0x01, // Data component size 1 byte
            0x00        // Expire authentication
        ]

        XCTAssertEqual(AAHomeCharger.setAuthenticationState(.expire).bytes, bytes)
    }

    func testSetChargeCurrent() {
        let bytes: [UInt8] = [
            0x00, 0x60, // MSB, LSB Message Identifier for Home Charger
            0x12,       // Message Type for Set Charge Current

            0x01,       // Property Identifier for Charge current (DC)
            0x00, 0x07, // Property size 7 bytes
            0x01,       // Data component
            0x00, 0x04, // Data component size 4 byte
            0x3F, 0x00, 0x00, 0x00  // Charger current (DC) 0.5
        ]

        XCTAssertEqual(AAHomeCharger.setChargingCurrent(0.5).bytes, bytes)
    }

    func testSetPriceTariffs() {
        let bytes: [UInt8] = [
            0x00, 0x60, // MSB, LSB Message Identifier for Home Charger
            0x13,       // Message Type for Set Price Tariffs

            0x0C,       // Property Identifier for Price tariff
            0x00, 0x0C, // Property size 12 bytes
            0x01,       // Data component
            0x00, 0x09, // Data component size 9 bytes
            0x00,                   // Starting fee
            0x40, 0x90, 0x00, 0x00, // 4.50
            0x03,                   // Currency size 3 bytes
            0x45, 0x55, 0x52,       // EUR

            0x0C,       // Property Identifier for Price tariff
            0x00, 0x0C, // Property size 12 bytes
            0x01,       // Data component
            0x00, 0x09, // Data component size 9 bytes
            0x02,                   // Per kWh
            0x3e, 0x99, 0x99, 0x9a, // 0.30
            0x03,                   // Currency size 3 bytes
            0x45, 0x55, 0x52        // EUR
        ]

        let tariff1 = AAPriceTariff(currency: "EUR", price: 4.5, type: .startingFee)
        let tariff2 = AAPriceTariff(currency: "EUR", price: 0.3, type: .perKWh)

        XCTAssertEqual(AAHomeCharger.setPriceTariffs([tariff1, tariff2]).bytes, bytes)
    }

    func testState() {
        let bytes: [UInt8] = [
            0x00, 0x60, // MSB, LSB Message Identifier for Home Charger
            0x01,       // Message Type for Home Charger State

            0x01,       // Property identifier for Charging
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Data component size is 1 bytes
            0x02,       // Charging complete

            0x02,       // Property identifier for Authentication mechanism
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Data component size is 1 bytes
            0x01,       // App

            0x03,       // Property identifier for Plug type
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Data component size is 1 bytes
            0x01,       // Type 2 plug

            0x04,       // Property identifier for Charging power
            0x00, 0x07, // Property size is 7 bytes
            0x01,       // Data component identifier
            0x00, 0x04, // Data component size is 4 bytes
            0x41, 0x38, 0x00, 0x00, // 11.5 kWh

            0x05,       // Property identifier for Solar charging
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Data component size is 1 bytes
            0x01,       // Solar powered charging activated

            0x08,       // Property identifier for Hotspot enabled
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Data component size is 1 bytes
            0x01,       // Wi-Fi Hotspot enabled

            0x09,       // Property identifier for Hotspot ssid
            0x00, 0x0F, // Property size is 15 bytes
            0x01,       // Data component identifier
            0x00, 0x0C, // Data component size is 12 bytes
            0x43, 0x68, 0x61, 0x72, 0x67, 0x65, 0x72, 0x20, 0x37, 0x36, 0x31, 0x32, // Wi-Fi Hotspot name "Charger 7612"

            0x0A,       // Property identifier for Wi fi hotspot security
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Data component size is 1 bytes
            0x03,       // WPA2 Personal

            0x0B,       // Property identifier for Wi fi hotspot password
            0x00, 0x0D, // Property size is 13 bytes
            0x01,       // Data component identifier
            0x00, 0x0A, // Data component size is 10 bytes
            0x5A, 0x57, 0x33, 0x76, 0x41, 0x52, 0x4E, 0x55, 0x42, 0x65, // Network password "ZW3vARNUBe"

            0x0D,       // Property identifier for Authentication state
            0x00, 0x04, // Property size is 4 bytes
            0x01,       // Data component identifier
            0x00, 0x01, // Data component size is 1 bytes
            0x01,       // Authenticated

            0x0E,       // Property identifier for Charge current dc
            0x00, 0x07, // Property size is 7 bytes
            0x01,       // Data component identifier
            0x00, 0x04, // Data component size is 4 bytes
            0x3F, 0x00, 0x00, 0x00, // Charger current (DC) is 0.5

            0x0F,       // Property identifier for Maximum charge current
            0x00, 0x07, // Property size is 7 bytes
            0x01,       // Data component identifier
            0x00, 0x04, // Data component size is 4 bytes
            0x3F, 0x80, 0x00, 0x00, // Maximum possible current is 1.0

            0x10,       // Property identifier for Minimum charge current
            0x00, 0x07, // Property size is 7 bytes
            0x01,       // Data component identifier
            0x00, 0x04, // Data component size is 4 bytes
            0x00, 0x00, 0x00, 0x00, // Minimum possible current is 0

            0x11,       // Property identifier for Coordinates
            0x00, 0x13, // Property size is 19 bytes
            0x01,       // Data component identifier
            0x00, 0x10, // Data component size is 16 bytes
            0x40, 0x4A, 0x42, 0x8F, 0x9F, 0x44, 0xD4, 0x45, // 52.520008 Latitude in IEE 754 format
            0x40, 0x2A, 0xCF, 0x56, 0x21, 0x74, 0xC4, 0xCE, // 13.404954 Longitude in IEE 754 format

            0x12,       // Property identifier for Price tariffs
            0x00, 0x0C, // Property size is 12 bytes
            0x01,       // Data component identifier
            0x00, 0x09, // Data component size is 9 bytes
            0x00,                   // Starting fee
            0x40, 0x90, 0x00, 0x00, // Price is 4.50
            0x03,                   // Currency string is 3 bytes
            0x45, 0x55, 0x52,       // EUR

            0x12,       // Property identifier for Price tariffs
            0x00, 0x0F, // Property size is 15 bytes
            0x01,       // Data component identifier
            0x00, 0x0C, // Data component size is 12 bytes
            0x02,                               // Per kWh
            0x3E, 0x99, 0x99, 0x9A,             // Price is 0.30
            0x06,                               // Currency string is 6 bytes
            0x52, 0x69, 0x70, 0x70, 0x6C, 0x65  // Ripple
        ]

        var homeCharger: AAHomeCharger!

        measure {
            guard let parsed = AAAutoAPI.parseBinary(bytes) as? AAHomeCharger else {
                return XCTFail("Parsed value is not AAHomeCharger")
            }

            homeCharger = parsed
        }

        XCTAssertEqual(homeCharger.chargingState?.value, .chargingComplete)
        XCTAssertEqual(homeCharger.authenticationMechanism?.value, .app)
        XCTAssertEqual(homeCharger.plugType?.value, .type2)
        XCTAssertEqual(homeCharger.chargingPower?.value, 11.5)

        if let location = homeCharger.coordinates?.value {
            XCTAssertEqual(location.latitude, 52.520008, accuracy: 1e-7)
            XCTAssertEqual(location.longitude, 13.404954, accuracy: 1e-7)
        }
        else {
            XCTFail("Home Charger doesn't contain Location")
        }

        XCTAssertEqual(homeCharger.chargeCurrentDC?.value, 0.5)
        XCTAssertEqual(homeCharger.maximumChargeCurrent?.value, 1.0)
        XCTAssertEqual(homeCharger.minimumChargeCurrent?.value, 0.0)

        XCTAssertEqual(homeCharger.wifiHotspotSSID?.value, "Charger 7612")
        XCTAssertEqual(homeCharger.wifiHotspotSecurity?.value, .WPA2Personal)
        XCTAssertEqual(homeCharger.wifiHotspotPassword?.value, "ZW3vARNUBe")

        XCTAssertEqual(homeCharger.priceTariffs?.count, 2)

        if let pricingTariff = homeCharger.priceTariffs?.first(where: { $0.value?.type == .startingFee }) {
            XCTAssertEqual(pricingTariff.value?.currency, "EUR")
            XCTAssertEqual(pricingTariff.value?.price, 4.5)
        }
        else {
            XCTFail("Home Charger doesn't contain Pricing Tariff with a Starting Fee")
        }

        if let pricingTariff = homeCharger.priceTariffs?.first(where: { $0.value?.type == .perKWh }) {
            XCTAssertEqual(pricingTariff.value?.currency, "Ripple")
            XCTAssertEqual(pricingTariff.value?.price, 0.3)
        }
        else {
            XCTFail("Home Charger doesn't contain Pricing Tariff with a Per kWh")
        }
    }
}
