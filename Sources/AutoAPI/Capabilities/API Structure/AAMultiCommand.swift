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
//  AAMultiCommand.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation
import HMUtilities


public class AAMultiCommand: AACapability {

    /// Property Identifiers for `AAMultiCommand` capability.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case multiStates = 0x01
        case multiCommands = 0x02
    }


    // MARK: Properties
    
    /// The incoming states
    ///
    /// - returns: Array of `AACapabilityState`-s wrapped in `[AAProperty<AACapabilityState>]`
    public var multiStates: [AAProperty<AACapability>]? {
        let bytesProps: [AAProperty<AACapabilityState>]? = properties.properties(forID: PropertyIdentifier.multiStates)
    
        return bytesProps?.compactMap {
            $0.transformValue {
                AAAutoAPI.parseBinary($0 ?? [])
            }
        }
    }


    // MARK: AAIdentifiable
    
    /// Capability's Identifier
    ///
    /// - returns: `UInt16` combining the MSB and LSB
    public override class var identifier: UInt16 {
        0x0013
    }


    // MARK: Setters
    
    /// Bytes for *multi command* command.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *multi command* in `AAMultiCommand`.
    /// 
    /// - parameters:
    ///   - multiCommands: The outgoing commands as `[AACapabilityState]`
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func multiCommand(multiCommands: [AACapabilityState]) -> Array<UInt8> {
        return AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.set.rawValue] + AAProperty.multiple(identifier: PropertyIdentifier.multiCommands, values: multiCommands).flatMap { $0.bytes }
    }


    // MARK: AADebugTreeCapable
    
    public override var propertyNodes: [HMDebugTree] {
        [
            .node(label: "Multi-states", properties: multiStates)
        ]
    }
}