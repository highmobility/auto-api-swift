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
//  AANotifications.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation
import HMUtilities


public class AANotifications: AACapability {

    /// Clear
    public enum Clear: UInt8, AABytesConvertable {
        case clear = 0x00
    }


    /// Property Identifiers for `AANotifications` capability.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case text = 0x01
        case actionItems = 0x02
        case activatedAction = 0x03
        case clear = 0x04
    }


    // MARK: Properties
    
    /// Action items
    ///
    /// - returns: Array of `AAActionItem`-s wrapped in `[AAProperty<AAActionItem>]`
    public var actionItems: [AAProperty<AAActionItem>]? {
        properties.properties(forID: PropertyIdentifier.actionItems)
    }
    
    /// Identifier of the activated action
    ///
    /// - returns: `UInt8` wrapped in `AAProperty<UInt8>`
    public var activatedAction: AAProperty<UInt8>? {
        properties.property(forID: PropertyIdentifier.activatedAction)
    }
    
    /// Clear
    ///
    /// - returns: `Clear` wrapped in `AAProperty<Clear>`
    public var clear: AAProperty<Clear>? {
        properties.property(forID: PropertyIdentifier.clear)
    }
    
    /// Text for the notification
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
        0x0038
    }


    // MARK: Setters
    
    /// Bytes for *notification* command.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *notification* in `AANotifications`.
    /// 
    /// - parameters:
    ///   - text: Text for the notification as `String`
    ///   - actionItems: action items as `[AAActionItem]`
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func notification(text: String, actionItems: [AAActionItem]? = nil) -> Array<UInt8> {
        let props1 = AAProperty(identifier: PropertyIdentifier.text, value: text).bytes + AAProperty.multiple(identifier: PropertyIdentifier.actionItems, values: actionItems).flatMap { $0.bytes }
    
        return AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.set.rawValue] + props1
    }
    
    /// Bytes for *action* command.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *action* in `AANotifications`.
    /// 
    /// - parameters:
    ///   - activatedAction: Identifier of the activated action as `UInt8`
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func action(activatedAction: UInt8) -> Array<UInt8> {
        return AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.set.rawValue] + AAProperty(identifier: PropertyIdentifier.activatedAction, value: activatedAction).bytes
    }
    
    /// Bytes for *clear notification* command.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *clear notification* in `AANotifications`.
    /// 
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func clearNotification() -> Array<UInt8> {
        return AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.set.rawValue] + AAProperty(identifier: PropertyIdentifier.clear, value: Clear(bytes: [0x00])).bytes
    }


    // MARK: AADebugTreeCapable
    
    public override var propertyNodes: [HMDebugTree] {
        [
            .node(label: "Action items", properties: actionItems),
            .node(label: "Activate action", property: activatedAction),
            .node(label: "Clear", property: clear),
            .node(label: "Text", property: text)
        ]
    }
}