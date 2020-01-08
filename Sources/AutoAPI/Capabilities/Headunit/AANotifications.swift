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
//  AANotifications.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
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
    public static func notification(text: String, actionItems: [AAActionItem]?) -> Array<UInt8> {
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