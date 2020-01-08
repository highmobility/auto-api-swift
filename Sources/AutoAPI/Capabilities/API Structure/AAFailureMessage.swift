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
//  AAFailureMessage.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation
import HMUtilities


public class AAFailureMessage: AACapability {

    /// Failure reason
    public enum FailureReason: UInt8, AABytesConvertable {
        case unsupportedCapability = 0x00
        case unauthorised = 0x01
        case incorrectState = 0x02
        case executionTimeout = 0x03
        case vehicleAsleep = 0x04
        case invalidCommand = 0x05
        case pending = 0x06
        case rateLimit = 0x07
    }


    /// Property Identifiers for `AAFailureMessage` capability.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case failedMessageID = 0x01
        case failedMessageType = 0x02
        case failureReason = 0x03
        case failureDescription = 0x04
        case failedPropertyIDs = 0x05
    }


    // MARK: Properties
    
    /// Capability identifier of the failed message
    ///
    /// - returns: `UInt16` wrapped in `AAProperty<UInt16>`
    public var failedMessageID: AAProperty<UInt16>? {
        properties.property(forID: PropertyIdentifier.failedMessageID)
    }
    
    /// Message type of the failed message
    ///
    /// - returns: `UInt8` wrapped in `AAProperty<UInt8>`
    public var failedMessageType: AAProperty<UInt8>? {
        properties.property(forID: PropertyIdentifier.failedMessageType)
    }
    
    /// Array of failed property identifiers
    ///
    /// - returns: `Array<UInt8>` wrapped in `AAProperty<Array<UInt8>>`
    public var failedPropertyIDs: AAProperty<Array<UInt8>>? {
        properties.property(forID: PropertyIdentifier.failedPropertyIDs)
    }
    
    /// Failure description
    ///
    /// - returns: `String` wrapped in `AAProperty<String>`
    public var failureDescription: AAProperty<String>? {
        properties.property(forID: PropertyIdentifier.failureDescription)
    }
    
    /// Failure reason
    ///
    /// - returns: `FailureReason` wrapped in `AAProperty<FailureReason>`
    public var failureReason: AAProperty<FailureReason>? {
        properties.property(forID: PropertyIdentifier.failureReason)
    }


    // MARK: AAIdentifiable
    
    /// Capability's Identifier
    ///
    /// - returns: `UInt16` combining the MSB and LSB
    public override class var identifier: UInt16 {
        0x0002
    }


    // MARK: AADebugTreeCapable
    
    public override var propertyNodes: [HMDebugTree] {
        [
            .node(label: "Failed message ID", property: failedMessageID),
            .node(label: "Failed message type", property: failedMessageType),
            .node(label: "Failed property IDs", property: failedPropertyIDs),
            .node(label: "Failure description", property: failureDescription),
            .node(label: "Failure reason", property: failureReason)
        ]
    }
}