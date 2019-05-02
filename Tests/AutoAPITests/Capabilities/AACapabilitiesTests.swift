//
// AutoAPITests
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
//  AACapabilitiesTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 27/11/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import AutoAPI
import XCTest


class AACapabilitiesTests: XCTestCase {

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

        XCTAssertEqual(AACapabilities.getCapabilities.bytes, bytes)
    }

    func testGetCapability() {
        let bytes: [UInt8] = [
            0x00, 0x10, // MSB, LSB Message Identifier for Capabilities
            0x02,       // Message Type for Get Capability

            0x01,       // Property Identifier for Capability Identifier
            0x00, 0x05, // Property size 5 bytes
            0x01,       // Data component identifier
            0x00, 0x02, // Component size 2 bytes
            0x00, 0x29  // MSB, LSB Idenfitier for Heart Rate
        ]

        XCTAssertEqual(AACapabilities.getCapability(AAHeartRate.identifier).bytes, bytes)
    }

    func testMultiple() {
        let bytes: [UInt8] = [
            0x00, 0x10, // MSB, LSB Message Identifier for Capabilities
            0x01,       // Message Type for Capabilities

            0x01,       // Property Identifier for Capability
            0x00, 0x08, // Property size 8 bytes
            0x01,       // Data component identifier
            0x00, 0x05, // Component size 5 bytes
            0x00, 0x20, // Identifier for Door Locks
            0x00,       // Supports Get Lock State
            0x01,       // Supports Lock State
            0x12,       // Supports Lock/Unlock Doors

            0x01,       // Property Identifier for Capability
            0x00, 0x08, // Property size 8 bytes
            0x01,       // Data component identifier
            0x00, 0x05, // Component size 5 bytes
            0x00, 0x21, // Identifier for Trunk Access
            0x00,       // Supports Get Trunk State
            0x01,       // Supports Trunk State
            0x12,       // Supports Control Trunk

            0x01,       // Property Identifier for Capability
            0x00, 0x09, // Property size 9 bytes
            0x01,       // Data component identifier
            0x00, 0x06, // Component size 6 bytes
            0x00, 0x23, // Identifier for Charging
            0x00,       // Supports Get Charge State
            0x01,       // Supports Charge State
            0x12,       // Supports Start/Stop Charging
            0x13,       // Supports Set Charge Limit

            0x01,       // Property Identifier for Capability
            0x00, 0x0D, // Property size 13 bytes
            0x01,       // Data component identifier
            0x00, 0x0A, // Component size 10 bytes
            0x00, 0x24, // Identifier for Climate
            0x00,       // Supports Get Climate State
            0x01,       // Supports Climate State
            0x12,       // Supports Set HVAC starting times
            0x13,       // Supports Start/Stop HVAC
            0x14,       // Supports Start/Stop Defogging
            0x15,       // Supports Start/Stop Defrosting
            0x16,       // Supports Start/Stop Ionising
            0x17,       // Supports Change Temperature

            0x01,       // Property Identifier for Capability
            0x00, 0x08, // Property size 8 bytes
            0x01,       // Data component identifier
            0x00, 0x05, // Component size 5 bytes
            0x00, 0x25, // Identifier for Rooftop Control
            0x00,       // Supports Get Rooftop State
            0x01,       // Supports Rooftop State
            0x12,       // Supports Control Rooftop

            0x01,       // Property Identifier for Capability
            0x00, 0x09, // Property size 9 bytes
            0x01,       // Data component identifier
            0x00, 0x06, // Component size 6 bytes
            0x00, 0x26, // Identifier for Honk Horn & Flash Lights
            0x00,       // Supports Get Flashers State
            0x01,       // Supports Flashers State
            0x12,       // Supports Honk & Flash
            0x13,       // Supports Activate/Deactivate Emergency Flasher

            0x01,       // Property Identifier for Capability
            0x00, 0x09, // Property size 9 bytes
            0x01,       // Data component identifier
            0x00, 0x06, // Component size 6 bytes
            0x00, 0x27, // Identifier for Remote Control
            0x00,       // Supports Get Control Mode
            0x01,       // Supports Control Mode
            0x12,       // Supports Start Control Mode
            0x04,       // Supports Control Command

            0x01,       // Property Identifier for Capability
            0x00, 0x08, // Property size 8 bytes
            0x01,       // Data component identifier
            0x00, 0x05, // Component size 5 bytes
            0x00, 0x28, // Identifier for Valet Mode
            0x00,       // Supports Get Valet Mode
            0x01,       // Supports Valet Mode
            0x12,       // Supports Activate/Deactivate Valet Mode

            0x01,       // Property Identifier for Capability
            0x00, 0x06, // Property size 6 bytes
            0x01,       // Data component identifier
            0x00, 0x03, // Component size 3 bytes
            0x00, 0x29, // Identifier for Heart Rate
            0x12,       // Supports Send Heart Rate

            0x01,       // Property Identifier for Capability
            0x00, 0x07, // Property size 7 bytes
            0x01,       // Data component identifier
            0x00, 0x04, // Component size 4 bytes
            0x00, 0x30, // Identifier for Vehicle Location
            0x00,       // Get Vehicle Location
            0x01,       // Vehicle Location

            0x01,       // Property Identifier for Capability
            0x00, 0x08, // Property size 8 bytes
            0x01,       // Data component identifier
            0x00, 0x05, // Component size 5 bytes
            0x00, 0x31, // Identifier for Navi Destination
            0x00,       // Get Navi Destination
            0x01,       // Navi Destination
            0x12        // Set Navi Destination
        ]

        var capabilities: AACapabilities!

        measure {
            guard let parsed = AAAutoAPI.parseBinary(bytes) as? AACapabilities else {
                return XCTFail("Parsed value is not AACapabilities")
            }

            capabilities = parsed
        }

        let all = capabilities.capabilities

        XCTAssertEqual(all?.count, 11)

        // DOOR LOCKS
        if let capability = all?.first(where: { $0.value?.capability == AADoorLocks.self }) {
            XCTAssertTrue(capability.value?.supportsAllMessageTypes(for: AADoorLocks.self) ?? false)
        }
        else {
            XCTFail("Capabilities doesn't contain capability for AADoorLocks")
        }

        // TRUNK ACCESS
        if let capability = all?.first(where: { $0.value?.capability == AATrunkAccess.self }) {
            XCTAssertTrue(capability.value?.supportsAllMessageTypes(for: AATrunkAccess.self) ?? false)
        }
        else {
            XCTFail("Capabilities doesn't contain capability for AATrunkAccess")
        }

        // CHARGING
        if let capability = all?.first(where: { $0.value?.capability == AACharging.self }) {
            XCTAssertTrue(capability.value?.supports(AACharging.MessageTypes.getChargingState, .chargingState, .startStopCharging, .setChargeLimit) ?? false)
        }
        else {
            XCTFail("Capabilities doesn't contain capability for AACharging")
        }

        // CLIMATE
        if let capability = all?.first(where: { $0.value?.capability == AAClimate.self }) {
            XCTAssertTrue(capability.value?.supportsAllMessageTypes(for: AAClimate.self) ?? false)
        }
        else {
            XCTFail("Capabilities doesn't contain capability for AAClimate")
        }

        // ROOFTOP CONTROL
        if let capability = all?.first(where: { $0.value?.capability == AARooftopControl.self }) {
            XCTAssertTrue(capability.value?.supportsAllMessageTypes(for: AARooftopControl.self) ?? false)
        }
        else {
            XCTFail("Capabilities doesn't contain capability for AARooftopControl")
        }

        // HONK HORN, FLASH LIGHTS
        if let capability = all?.first(where: { $0.value?.capability == AAHonkHornFlashLights.self }) {
            XCTAssertTrue(capability.value?.supportsAllMessageTypes(for: AAHonkHornFlashLights.self) ?? false)
        }
        else {
            XCTFail("Capabilities doesn't contain capability for AAHonkHornFlashLights")
        }

        // REMOTE CONTROL
        if let capability = all?.first(where: { $0.value?.capability == AARemoteControl.self }) {
            XCTAssertTrue(capability.value?.supportsAllMessageTypes(for: AARemoteControl.self) ?? false)
        }
        else {
            XCTFail("Capabilities doesn't contain capability for AARemoteControl")
        }

        // VALET MODE
        if let capability = all?.first(where: { $0.value?.capability == AAValetMode.self }) {
            XCTAssertTrue(capability.value?.supportsAllMessageTypes(for: AAValetMode.self) ?? false)
        }
        else {
            XCTFail("Capabilities doesn't contain capability for AAValetMode")
        }

        // HEART RATE
        if let capability = all?.first(where: { $0.value?.capability == AAHeartRate.self }) {
            XCTAssertTrue(capability.value?.supportsAllMessageTypes(for: AAHeartRate.self) ?? false)
        }
        else {
            XCTFail("Capabilities doesn't contain capability for AAHeartRate")
        }

        // VEHICLE LOCATION
        if let capability = all?.first(where: { $0.value?.capability == AAVehicleLocation.self }) {
            XCTAssertTrue(capability.value?.supportsAllMessageTypes(for: AAVehicleLocation.self) ?? false)
        }
        else {
            XCTFail("Capabilities doesn't contain capability for AAVehicleLocation")
        }

        // NAVI DESTINATION
        if let capability = all?.first(where: { $0.value?.capability == AANaviDestination.self }) {
            XCTAssertTrue(capability.value?.supportsAllMessageTypes(for: AANaviDestination.self) ?? false)
        }
        else {
            XCTFail("Capabilities doesn't contain capability for AANaviDestination")
        }
    }

    func testSingle() {
        let bytes: [UInt8] = [
            0x00, 0x10, // MSB, LSB Message Identifier for Capabilities
            0x01,       // Message Type for Capabilities

            0x01,       // Property Identifier for Capability
            0x00, 0x08, // Property size 8 bytes
            0x01,       // Data component
            0x00, 0x05, // Data component size 5 bytes
            0x00, 0x21, // Identifier for Trunk Access
            0x00,       // Supports Get Trunk State
            0x01,       // Supports Trunk State
            0x02        // Supports Open/Close Trunk
        ]

        guard let capabilities = AAAutoAPI.parseBinary(bytes) as? AACapabilities else {
            return XCTFail("Parsed value is not AACapabilities")
        }

        XCTAssertEqual(capabilities.capabilities?.count, 1)

        guard let trunkAccess = capabilities.capabilities?.first(where: { $0.value?.capability == AATrunkAccess.self }) else {
            return XCTFail("Capabilities doesn't contain capability for AATrunkAccess")
        }

        XCTAssertEqual(trunkAccess.value?.supportedMessageTypes, [0x00, 0x01, 0x02])
    }
}
