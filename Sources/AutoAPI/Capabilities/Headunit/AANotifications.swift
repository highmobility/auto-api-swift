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


public class AANotifications: AACapability, __PropertyIdentifying {

    public enum Clear: UInt8, AABytesConvertable {
        case clear = 0x00
    }


    // MARK: AAPropertyIdentifying

    /// Property Identifiers for `AANotifications` capability.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case text = 0x01
        case actionItems = 0x02
        case activatedAction = 0x03
        case clear = 0x04
    }


    // MARK: Properties

    public var actionItems: [AAProperty<AAActionItem>]? {
        properties(forID: .actionItems)
    }

    public var activatedAction: AAProperty<UInt8>? {
        property(forID: .activatedAction)
    }

    public var clear: AAProperty<Clear>? {
        property(forID: .clear)
    }

    public var text: AAProperty<String>? {
        property(forID: .text)
    }


    // MARK: Identifier

    /// `AANotifications` capability's identifier.
    ///
    /// - returns: `UInt16` combining the MSB and LSB
    public override class var identifier: UInt16 {
        0x0038
    }


    // MARK: Setters

    public static func notification(text: String, actionItems: [AAActionItem]?) -> [UInt8] {
        var propertiesBytesArray: [[UInt8]?] = []

        propertiesBytesArray.append(text.property(identifier: PropertyIdentifier.text).bytes)
        propertiesBytesArray.append((actionItems?.flatMap { $0.property(identifier: PropertyIdentifier.actionItems).bytes } ?? []))

        return AAAutoAPI.protocolVersion.bytes +
            Self.identifier.bytes +
            [AACommandType.set.rawValue] +
            propertiesBytesArray.compactMap { $0 }.flatMap { $0 }
    }

    public static func action(activatedAction: UInt8) -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes +
            Self.identifier.bytes +
            [AACommandType.set.rawValue] +
            activatedAction.property(identifier: PropertyIdentifier.activatedAction).bytes
    }

    public static func clearNotification() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes +
            Self.identifier.bytes +
            [AACommandType.set.rawValue] +
            // Constants must have the correct data (value)
            Clear(bytes: [0x00])!.property(identifier: PropertyIdentifier.clear).bytes
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
