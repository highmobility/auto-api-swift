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
//  AASeats.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/01/2020.
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