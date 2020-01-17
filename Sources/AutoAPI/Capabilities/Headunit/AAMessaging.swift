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
//  AAMessaging.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation
import HMUtilities


public class AAMessaging: AACapability {

    /// Property Identifiers for `AAMessaging` capability.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case text = 0x01
        case handle = 0x02
    }


    // MARK: Properties
    
    /// The optional handle of message
    ///
    /// - returns: `String` wrapped in `AAProperty<String>`
    public var handle: AAProperty<String>? {
        properties.property(forID: PropertyIdentifier.handle)
    }
    
    /// The text
    ///
    /// - returns: `String` wrapped in `AAProperty<String>`
    public var text: AAProperty<String>? {
        properties.property(forID: PropertyIdentifier.text)
    }


    // MARK: AAIdentifiable
    
    /// Capability's Identifier
    ///
    /// - returns: `UInt16` combining the MSB and LSB
    public override class var identifier: UInt16 {
        0x0037
    }


    // MARK: Setters
    
    /// Bytes for *message received* command.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *message received* in `AAMessaging`.
    /// 
    /// - parameters:
    ///   - text: The text as `String`
    ///   - handle: The optional handle of message as `String`
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func messageReceived(text: String, handle: String? = nil) -> Array<UInt8> {
        let props1 = AAProperty(identifier: PropertyIdentifier.text, value: text).bytes + AAProperty(identifier: PropertyIdentifier.handle, value: handle).bytes
    
        return AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.set.rawValue] + props1
    }


    // MARK: AADebugTreeCapable
    
    public override var propertyNodes: [HMDebugTree] {
        [
            .node(label: "Handle", property: handle),
            .node(label: "Text", property: text)
        ]
    }
}