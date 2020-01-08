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
//  AASeats.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation
import HMUtilities


public class AASeats: AACapability {

    /// Property Identifiers for `AASeats` capability.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case personsDetected = 0x02
        case seatbeltsState = 0x03
    }


    // MARK: Properties
    
    /// Persons detected
    ///
    /// - returns: Array of `AAPersonDetected`-s wrapped in `[AAProperty<AAPersonDetected>]`
    public var personsDetected: [AAProperty<AAPersonDetected>]? {
        properties.properties(forID: PropertyIdentifier.personsDetected)
    }
    
    /// Seatbelts state
    ///
    /// - returns: Array of `AASeatbeltState`-s wrapped in `[AAProperty<AASeatbeltState>]`
    public var seatbeltsState: [AAProperty<AASeatbeltState>]? {
        properties.properties(forID: PropertyIdentifier.seatbeltsState)
    }


    // MARK: AAIdentifiable
    
    /// Capability's Identifier
    ///
    /// - returns: `UInt16` combining the MSB and LSB
    public override class var identifier: UInt16 {
        0x0056
    }


    // MARK: Getters
    
    /// Bytes for getting the `AASeats` state.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *request* the state of `AASeats`.
    ///
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func getSeatsState() -> Array<UInt8> {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.get.rawValue]
    }
    
    /// Bytes for getting the `AASeats` state's **specific** properties.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *request* **specific** state properties of `AASeats`.
    ///
    /// - parameters:
    ///   - propertyIDs: Array of requested property identifiers
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func getSeatsProperties(propertyIDs: PropertyIdentifier...) -> Array<UInt8> {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.get.rawValue] + propertyIDs.map { $0.rawValue }
    }


    // MARK: AADebugTreeCapable
    
    public override var propertyNodes: [HMDebugTree] {
        [
            .node(label: "Persons detected", properties: personsDetected),
            .node(label: "Seatbelts state", properties: seatbeltsState)
        ]
    }
}