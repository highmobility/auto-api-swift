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
//  AAOffroad.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation
import HMUtilities


public class AAOffroad: AACapability {

    /// Property Identifiers for `AAOffroad` capability.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case routeIncline = 0x01
        case wheelSuspension = 0x02
    }


    // MARK: Properties
    
    /// The route elevation incline in degrees, which is a negative number for decline
    ///
    /// - returns: `Int16` wrapped in `AAProperty<Int16>`
    public var routeIncline: AAProperty<Int16>? {
        properties.property(forID: PropertyIdentifier.routeIncline)
    }
    
    /// The wheel suspension level percentage, whereas 0.0 is no suspension and 1.0 maximum suspension
    ///
    /// - returns: `AAPercentage` wrapped in `AAProperty<AAPercentage>`
    public var wheelSuspension: AAProperty<AAPercentage>? {
        properties.property(forID: PropertyIdentifier.wheelSuspension)
    }


    // MARK: AAIdentifiable
    
    /// Capability's Identifier
    ///
    /// - returns: `UInt16` combining the MSB and LSB
    public override class var identifier: UInt16 {
        0x0052
    }


    // MARK: Getters
    
    /// Bytes for getting the `AAOffroad` state.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *request* the state of `AAOffroad`.
    ///
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func getOffroadState() -> Array<UInt8> {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.get.rawValue]
    }
    
    /// Bytes for getting the `AAOffroad` state's **specific** properties.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *request* **specific** state properties of `AAOffroad`.
    ///
    /// - parameters:
    ///   - propertyIDs: Array of requested property identifiers
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func getOffroadProperties(propertyIDs: PropertyIdentifier...) -> Array<UInt8> {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.get.rawValue] + propertyIDs.map { $0.rawValue }
    }


    // MARK: AADebugTreeCapable
    
    public override var propertyNodes: [HMDebugTree] {
        [
            .node(label: "Route incline", property: routeIncline),
            .node(label: "Wheel suspension", property: wheelSuspension)
        ]
    }
}