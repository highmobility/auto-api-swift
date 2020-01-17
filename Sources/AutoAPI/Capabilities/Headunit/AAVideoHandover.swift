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
//  AAVideoHandover.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation
import HMUtilities


public class AAVideoHandover: AACapability {

    /// Screen
    public enum Screen: UInt8, AABytesConvertable {
        case front = 0x00
        case rear = 0x01
    }


    /// Property Identifiers for `AAVideoHandover` capability.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case url = 0x01
        case startingSecond = 0x02
        case screen = 0x03
    }


    // MARK: AAIdentifiable
    
    /// Capability's Identifier
    ///
    /// - returns: `UInt16` combining the MSB and LSB
    public override class var identifier: UInt16 {
        0x0043
    }


    // MARK: Setters
    
    /// Bytes for *video handover* command.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *video handover* in `AAVideoHandover`.
    /// 
    /// - parameters:
    ///   - url: URL string as `String`
    ///   - startingSecond: starting second as `UInt16`
    ///   - screen: screen as `Screen`
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func videoHandover(url: String, startingSecond: UInt16? = nil, screen: Screen? = nil) -> Array<UInt8> {
        let props1 = AAProperty(identifier: PropertyIdentifier.url, value: url).bytes + AAProperty(identifier: PropertyIdentifier.startingSecond, value: startingSecond).bytes + AAProperty(identifier: PropertyIdentifier.screen, value: screen).bytes
    
        return AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.set.rawValue] + props1
    }


    // MARK: AADebugTreeCapable
    
    public override var propertyNodes: [HMDebugTree] {
        [
    
        ]
    }
}