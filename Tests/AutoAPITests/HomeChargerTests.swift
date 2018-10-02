//
// AutoAPI
// Copyright (C) 2018 High-Mobility GmbH
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
//  HomeChargerTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 30/01/2018.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import AutoAPI
import XCTest


class HomeChargerTests: XCTestCase {

    static var allTests = [("testActivateDeactivateSolarCharging", testActivateDeactivateSolarCharging),
                           ("testEnableDisableWifiHotspot", testEnableDisableWifiHotspot),
                           ("testGetState", testGetState),
                           ("testSetChargeCurrent", testSetChargeCurrent),
                           ("testSetPriceTariffs", testSetPriceTariffs),
                           ("testState", testState)]

    
    // MARK: XCTestCase

    func testActivateDeactivateSolarCharging() {
        let bytes: [UInt8] = [
            0x00, 0x60, // MSB, LSB Message Identifier for Home Charger
            0x04,       // Message Type for Activate/Deactivate Solar Charging

            0x01    // Activate solar powered charging
        ]

        XCTAssertEqual(AAHomeCharger.activateSolarCharging(true), bytes)
    }

    func testEnableDisableWifiHotspot() {
        let bytes: [UInt8] = [
            0x00, 0x60, // MSB, LSB Message Identifier for Home Charger
            0x05,       // Message Type for Enable/Disable Wi-Fi Hotspot

            0x00    // Disable Wi-Fi Hotspot
        ]

        XCTAssertEqual(AAHomeCharger.enableWifiHotspot(false), bytes)
    }

    func testGetState() {
        let bytes: [UInt8] = [
            0x00, 0x60, // MSB, LSB Message Identifier for Home Charger
            0x00        // Message Type for Get Home Charger State
        ]

        XCTAssertEqual(AAHomeCharger.getHomeChargerState, bytes)
    }

    func testSetChargeCurrent() {
        let bytes: [UInt8] = [
            0x00, 0x60, // MSB, LSB Message Identifier for Home Charger
            0x02,       // Message Type for Set Charge Current

            0x3f, 0x00, 0x00, 0x00  // Charger current (DC) 0.5
        ]

        XCTAssertEqual(AAHomeCharger.setChargeCurrent(0.5), bytes)
    }

    func testSetPriceTariffs() {
        let bytes: [UInt8] = [
            0x00, 0x60, // MSB, LSB Message Identifier for Home Charger
            0x03,       // Message Type for Set Price Tariffs

            0x0C,       // Property Identifier for Price tariff
            0x00, 0x08, // Property size 8 bytes
            0x00,                   // Starting fee
            0x45, 0x55, 0x52,       // EUR
            0x40, 0x90, 0x00, 0x00, // 4.50

            0x0C,       // Property Identifier for Price tariff
            0x00, 0x08, // Property size 8 bytes
            0x02,                   // Per kWh
            0x45, 0x55, 0x52,       // EUR
            0x3e, 0x99, 0x99, 0x9a  // 0.30
        ]

        let tariff1 = AAHomeCharger.PriceTariff(type: .startingFee, currency: "EUR", price: 4.5)
        let tariff2 = AAHomeCharger.PriceTariff(type: .per_kWh, currency: "EUR", price: 0.3)

        XCTAssertEqual(AAHomeCharger.setPriceTariffs([tariff1, tariff2]), bytes)
    }

    func testState() {
        let bytes: [UInt8] = [
            0x00, 0x60, // MSB, LSB Message Identifier for Home Charger
            0x01,       // Message Type for Home Charger State

            0x01,       // Property identifier for Charging
            0x00, 0x01, // Property size is 1 bytes
            0x02,       // Charging

            0x02,       // Property identifier for Authentication mechanism
            0x00, 0x01, // Property size is 1 bytes
            0x01,       // App

            0x03,       // Property identifier for Plug type
            0x00, 0x01, // Property size is 1 bytes
            0x01,       // Type 2 plug

            0x04,       // Property identifier for Charging power
            0x00, 0x04, // Property size is 4 bytes
            0x41, 0x38, 0x00, 0x00, // 11.5 kWh

            0x05,       // Property identifier for Solar charging
            0x00, 0x01, // Property size is 1 bytes
            0x01,       // Solar powered charging activated

            0x06,       // Property identifier for Location
            0x00, 0x08, // Property size is 8 bytes
            0x42, 0x52, 0x14, 0x7d, // 52.520008 Latitude in IEE 754 format
            0x41, 0x56, 0x7a, 0xb1, // 13.404954 Longitude in IEE 754 format

            0x07,       // Property identifier for Charge current
            0x00, 0x0C, // Property size is 12 bytes
            0x3f, 0x00, 0x00, 0x00, // Charger current (DC) 0.5
            0x3f, 0x80, 0x00, 0x00, // Maximum possible current is 1.0
            0x00, 0x00, 0x00, 0x00, // Minimum possible current is 0

            0x08,       // Property identifier for Hotspot enabled
            0x00, 0x01, // Property size is 1 bytes
            0x01,       // Wi-Fi Hotspot enabled

            0x09,       // Property identifier for Hotspot ssid
            0x00, 0x0C, // Property size is 12 bytes
            0x43, 0x68, 0x61, 0x72, 0x67, 0x65, //
            0x72, 0x20, 0x37, 0x36, 0x31, 0x32, // Wi-Fi Hotspot name "Charger 7612"

            0x0A,       // Property identifier for Wi fi hotspot security
            0x00, 0x01, // Property size is 1 bytes
            0x03,       // WPA2 Personal

            0x0B,       // Property identifier for Wi fi hotspot password
            0x00, 0x0A, // Property size is 10 bytes
            0x5a, 0x57, 0x33, 0x76, 0x41,   //
            0x52, 0x4e, 0x55, 0x42, 0x65,   // Network password "ZW3vARNUBe"

            0x0C,       // Property identifier for Price tariff
            0x00, 0x08, // Property size is 8 bytes
            0x00,                   // Starting fee
            0x45, 0x55, 0x52,       // EUR
            0x40, 0x90, 0x00, 0x00, // 4.50

            0x0C,       // Property identifier for Price tariff
            0x00, 0x08, // Property size is 8 bytes
            0x02,                   // Per kWh
            0x45, 0x55, 0x52,       // EUR
            0x3e, 0x99, 0x99, 0x9a  // 0.30
        ]

        guard let homeCharger = AutoAPI.parseBinary(bytes) as? AAHomeCharger else {
            return XCTFail("Parsed value is not HomeCharger")
        }

        XCTAssertEqual(homeCharger.chargingState, .charging)
        XCTAssertEqual(homeCharger.authenticationMechanism, .app)
        XCTAssertEqual(homeCharger.plugType, .type2)
        XCTAssertEqual(homeCharger.chargingPower, 11.5)

        if let location = homeCharger.location {
            XCTAssertEqual(location.latitude, 52.520008, accuracy: 1e-7)
            XCTAssertEqual(location.longitude, 13.404954, accuracy: 1e-7)
        }
        else {
            XCTFail("Home Charger doesn't contain Location")
        }

        XCTAssertEqual(homeCharger.chargeCurrent?.chargeCurrentDC, 0.5)
        XCTAssertEqual(homeCharger.chargeCurrent?.maximumValue, 1.0)
        XCTAssertEqual(homeCharger.chargeCurrent?.minimumValue, 0.0)

        XCTAssertEqual(homeCharger.wifiHotspotSSID, "Charger 7612")
        XCTAssertEqual(homeCharger.wifiHotspotSecurity, .WPA2Personal)
        XCTAssertEqual(homeCharger.wifiHotspotPassword, "ZW3vARNUBe")

        XCTAssertEqual(homeCharger.pricingTariffs?.count, 2)

        if let pricingTariff = homeCharger.pricingTariffs?.first(where: { $0.type == .startingFee }) {
            XCTAssertEqual(pricingTariff.currency, "EUR")
            XCTAssertEqual(pricingTariff.price, 4.5)
        }
        else {
            XCTFail("Home Charger doesn't contain Pricing Tariff with a Starting Fee")
        }

        if let pricingTariff = homeCharger.pricingTariffs?.first(where: { $0.type == .per_kWh }) {
            XCTAssertEqual(pricingTariff.currency, "EUR")
            XCTAssertEqual(pricingTariff.price, 0.3)
        }
        else {
            XCTFail("Home Charger doesn't contain Pricing Tariff with a Per kWh")
        }
    }
}
