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
//  AAHistorical.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation
import HMUtilities


public class AAHistorical: AACapability {

    /// Property Identifiers for `AAHistorical` capability.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case states = 0x01
        case capabilityID = 0x02
        case startDate = 0x03
        case endDate = 0x04
    }


    // MARK: Properties
    
    /// The bytes of a Capability state
    ///
    /// - returns: Array of `AACapabilityState`-s wrapped in `[AAProperty<AACapabilityState>]`
    public var states: [AAProperty<AACapability>]? {
        let bytesProps: [AAProperty<AACapabilityState>]? = properties.properties(forID: PropertyIdentifier.states)
    
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
        0x0012
    }


    // MARK: Setters
    
    /// Bytes for *request states* command.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *request states* in `AAHistorical`.
    /// 
    /// - parameters:
    ///   - capabilityID: The identifier of the Capability as `UInt16`
    ///   - startDate: Milliseconds since UNIX Epoch time as `Date`
    ///   - endDate: Milliseconds since UNIX Epoch time as `Date`
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func requestStates(capabilityID: UInt16, startDate: Date? = nil, endDate: Date? = nil) -> Array<UInt8> {
        let props1 = AAProperty(identifier: PropertyIdentifier.capabilityID, value: capabilityID).bytes + AAProperty(identifier: PropertyIdentifier.startDate, value: startDate).bytes + AAProperty(identifier: PropertyIdentifier.endDate, value: endDate).bytes
    
        return AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.set.rawValue] + props1
    }


    // MARK: AADebugTreeCapable
    
    public override var propertyNodes: [HMDebugTree] {
        [
            .node(label: "States", properties: states)
        ]
    }
}