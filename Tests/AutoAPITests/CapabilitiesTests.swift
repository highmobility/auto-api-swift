//
// AutoAPITests
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
//  CapabilitiesTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 27/11/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import AutoAPI
import XCTest


class CapabilitiesTests: XCTestCase {

    static var allTests = [("testGetCapabilities", testGetCapabilities),
                           ("testGetCapability", testGetCapability),
                           ("testMultiple", testMultiple),
                           ("testSingle", testSingle)]


    // MARK: XCTestCase

    func testGetCapabilities() {
        let bytes: [UInt8] = [
            0x00, 0x10, // MSB, LSB Message Identifier for Capabilities
            0x00        // Message Type for Get Capabilities
        ]

        XCTAssertEqual(Capabilities.getCapabilities, bytes)
    }

    func testGetCapability() {
        let bytes: [UInt8] = [
            0x00, 0x10, // MSB, LSB Message Identifier for Capabilities
            0x02,       // Message Type for Get Capability
            0x00, 0x29  // MSB, LSB Idenfitier for Heart Rate
        ]

        XCTAssertEqual(Capabilities.getCapability(HeartRate.identifier), bytes)
    }

    func testMultiple() {
        let bytes: [UInt8] = [
            0x00, 0x10, // MSB, LSB Message Identifier for Capabilities
            0x01,       // Message Type for Capabilities

            0x01,       // Property Identifier for Capability
            0x00, 0x05, // Property size 5 bytes
            0x00, 0x20, // Identifier for Door Locks
            0x00,       // Supports Get Lock State
            0x01,       // Supports Lock State
            0x02,       // Supports Lock/Unlock Doors

            0x01,       // Property Identifier for Capability
            0x00, 0x05, // Property size 5 bytes
            0x00, 0x21, // Identifier for Trunk Access
            0x00,       // Supports Get Trunk State
            0x01,       // Supports Trunk State
            0x02,       // Supports Open/Close Trunk

            0x01,       // Property Identifier for Capability
            0x00, 0x06, // Property size 6 bytes
            0x00, 0x23, // Identifier for Charging
            0x00,       // Supports Get Charge State
            0x01,       // Supports Charge State
            0x02,       // Supports Start/Stop Charging
            0x03,       // Supports Set Charge Limit

            0x01,       // Property Identifier for Capability
            0x00, 0x09, // Property size 9 bytes
            0x00, 0x24, // Identifier for Climate
            0x00,       // Supports Get Climate State
            0x01,       // Supports Climate State
            0x02,       // Supports Set Climate Profile
            0x03,       // Supports Start/Stop HVAC
            0x04,       // Supports Start/Stop Defogging
            0x05,       // Supports Start/Stop Defrosting
            0x06,       // Supports Start/Stop Ionising

            0x01,       // Property Identifier for Capability
            0x00, 0x05, // Property size 5 bytes
            0x00, 0x25, // Identifier for Rooftop Control
            0x00,       // Supports Get Rooftop State
            0x01,       // Supports Rooftop State
            0x02,       // Supports Control Rooftop

            0x01,       // Property Identifier for Capability
            0x00, 0x06, // Property size 6 bytes
            0x00, 0x26, // Identifier for Honk Horn & Flash Lights
            0x00,       // Supports Get Flashers State
            0x01,       // Supports Flashers State
            0x02,       // Supports Honk & Flash
            0x03,       // Supports Activate/Deactivate Emergency Flasher

            0x01,       // Property Identifier for Capability
            0x00, 0x07, // Property size 7 bytes
            0x00, 0x27, // Identifier for Remote Control
            0x00,       // Supports Get Control Mode
            0x01,       // Supports Control Mode
            0x02,       // Supports Start Control Mode
            0x03,       // Supports Stop Control Mode
            0x04,       // Supports Control Command

            0x01,       // Property Identifier for Capability
            0x00, 0x05, // Property size 5 bytes
            0x00, 0x28, // Identifier for Valet Mode
            0x00,       // Supports Get Valet Mode
            0x01,       // Supports Valet Mode
            0x02,       // Supports Activate/Deactivate Valet Mode

            0x01,       // Property Identifier for Capability
            0x00, 0x03, // Property size 3 bytes
            0x00, 0x29, // Identifier for Heart Rate
            0x02,       // Supports Send Heart Rate

            0x01,       // Property Identifier for Capability
            0x00, 0x04, // Property size 4 bytes
            0x00, 0x30, // Identifier for Vehicle Location
            0x00,       // Get Vehicle Location
            0x01,       // Vehicle Location

            0x01,       // Property Identifier for Capability
            0x00, 0x05, // Property size 5 bytes
            0x00, 0x31, // Identifier for Navi Destination
            0x00,       // Get Navi Destination
            0x01,       // Navi Destination
            0x02        // Set Navi Destination
        ]

        guard let capabilities = AutoAPI.parseBinary(bytes) as? Capabilities else {
            return XCTFail("Parsed value is not Capabilities")
        }

        let all = capabilities.all

        XCTAssertEqual(all.count, 11)

        // DOOR LOCKS
        if let capability = capabilities.first(where: { $0.command is AADoorLocks.Type }) {
            XCTAssertTrue(capability.supportsAllMessageTypes(for: AADoorLocks.self))
        }
        else {
            XCTFail("Capabilities doesn't contain capability for DoorLocks")
        }

        // TRUNK ACCESS
        if let capability = capabilities.first(where: { $0.command is AATrunkAccess.Type }) {
            XCTAssertTrue(capability.supportsAllMessageTypes(for: AATrunkAccess.self))
        }
        else {
            XCTFail("Capabilities doesn't contain capability for TrunkAccess")
        }

        // CHARGING
        if let capability = capabilities.first(where: { $0.command is AACharging.Type }) {
            XCTAssertTrue(capability.supports(AACharging.MessageTypes.getChargeState, .chargeState, .startStopCharging, .setChargeLimit))
        }
        else {
            XCTFail("Capabilities doesn't contain capability for Charging")
        }

        // CLIMATE
        if let capability = capabilities.first(where: { $0.command is AAClimate.Type }) {
            XCTAssertTrue(capability.supportsAllMessageTypes(for: AAClimate.self))
        }
        else {
            XCTFail("Capabilities doesn't contain capability for Climate")
        }

        // ROOFTOP CONTROL
        if let capability = capabilities.first(where: { $0.command is AARooftopControl.Type }) {
            XCTAssertTrue(capability.supportsAllMessageTypes(for: AARooftopControl.self))
        }
        else {
            XCTFail("Capabilities doesn't contain capability for RooftopControl")
        }

        // HONK HORN, FLASH LIGHTS
        if let capability = capabilities.first(where: { $0.command is AAHonkHornFlashFlights.Type }) {
            XCTAssertTrue(capability.supportsAllMessageTypes(for: AAHonkHornFlashFlights.self))
        }
        else {
            XCTFail("Capabilities doesn't contain capability for HonkHornFlashFlights")
        }

        // REMOTE CONTROL
        if let capability = capabilities.first(where: { $0.command is RemoteControl.Type }) {
            XCTAssertTrue(capability.supportsAllMessageTypes(for: RemoteControl.self))
        }
        else {
            XCTFail("Capabilities doesn't contain capability for RemoteControl")
        }

        // VALET MODE
        if let capability = capabilities.first(where: { $0.command is ValetMode.Type }) {
            XCTAssertTrue(capability.supportsAllMessageTypes(for: ValetMode.self))
        }
        else {
            XCTFail("Capabilities doesn't contain capability for ValetMode")
        }

        // HEART RATE
        if let capability = capabilities.first(where: { $0.command is HeartRate.Type }) {
            XCTAssertTrue(capability.supportsAllMessageTypes(for: HeartRate.self))
        }
        else {
            XCTFail("Capabilities doesn't contain capability for HeartRate")
        }

        // VEHICLE LOCATION
        if let capability = capabilities.first(where: { $0.command is VehicleLocation.Type }) {
            XCTAssertTrue(capability.supportsAllMessageTypes(for: VehicleLocation.self))
        }
        else {
            XCTFail("Capabilities doesn't contain capability for VehicleLocation")
        }

        // NAVI DESTINATION
        if let capability = capabilities.first(where: { $0.command is NaviDestination.Type }) {
            XCTAssertTrue(capability.supportsAllMessageTypes(for: NaviDestination.self))
        }
        else {
            XCTFail("Capabilities doesn't contain capability for NaviDestination")
        }
    }

    func testSingle() {
        let bytes: [UInt8] = [
            0x00, 0x10, // MSB, LSB Message Identifier for Capabilities
            0x01,       // Message Type for Capabilities

            0x01,       // Property Identifier for Capability
            0x00, 0x05, // Property size 5 bytes
            0x00, 0x21, // Identifier for Trunk Access
            0x00,       // Supports Get Trunk State
            0x01,       // Supports Trunk State
            0x02,       // Supports Open/Close Trunk
        ]

        guard let capabilities = AutoAPI.parseBinary(bytes) as? Capabilities else {
            return XCTFail("Parsed value is not Capabilities")
        }

        XCTAssertEqual(capabilities.all.count, 1)

        guard let trunkAccess = capabilities.first(where: { $0.command is AATrunkAccess.Type }) else {
            return XCTFail("Capabilities doesn't contain capability for TrunkAccess")
        }

        XCTAssertEqual(trunkAccess.supportedMessageTypes, [0x00, 0x01, 0x02])
    }
}
