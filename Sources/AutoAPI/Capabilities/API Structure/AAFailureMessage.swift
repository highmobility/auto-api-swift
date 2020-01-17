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
//  AAFailureMessage.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/01/2020.
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