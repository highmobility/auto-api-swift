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
//  Notifications.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/12/2017.
//

import Foundation


public struct Notifications: BidirectionalCommand {

    public let actionItems: [ActionItem]?
    public let receivedActionID: UInt8?
    public let receivedClearCommand: Bool
    public let text: String?


    // MARK: BidirectionalCommand

    public let properties: Properties


    // Needs to override this to parse CUSTOM properties
    init?<C>(_ binary: C) where C : Collection, C.Element == UInt8 {
        guard binary.count >= 3 else {
            return nil
        }

        guard Identifier(binary) == Notifications.identifier else {
            return nil
        }

        let properties: Properties
        let messageType = binary.bytes[2]

        switch messageType {
        case 0x00:
            properties = Properties(binary.dropFirstBytes(3))

        case 0x01:
            guard binary.count == 4 else {
                return nil
            }

            // Hack
            properties = Properties([0x99, 0x00, 0x01, binary.bytes[3]])

        case 0x02:
            guard binary.count == 3 else {
                return nil
            }

            properties = Properties([])

        default:
            return nil
        }

        self.init(messageType, properties: properties)
    }

    init?(_ messageType: UInt8, properties: Properties) {
        var properties = properties

        switch messageType {
        case 0x00:
            receivedActionID = nil
            receivedClearCommand = false

        case 0x01:
            receivedActionID = properties.value(for: 0x99)
            receivedClearCommand = false

            properties = Properties([])

        case 0x02:
            receivedActionID = nil
            receivedClearCommand = true

        default:
            return nil
        }

        // Ordered by the ID
        text = properties.value(for: 0x01)
        actionItems = properties.flatMap(for: 0x02) { ActionItem($0.value) }

        // Properties
        self.properties = properties
    }
}

extension Notifications: Identifiable {

    public static var identifier: Identifier = Identifier(0x0038)
}

extension Notifications: MessageTypesGettable {

    public enum MessageTypes: UInt8, MessageTypesKind {

        case notification       = 0x00
        case notificationAction = 0x01
        case clearNotification  = 0x02


        public static var all: [Notifications.MessageTypes] {
            return [self.notification,
                    self.notificationAction,
                    self.clearNotification]
        }
    }
}

public extension Notifications {

    struct Notification {
        public let text: String
        public let actionItems: [ActionItem]?

        public init(text: String, actionItems: [ActionItem]?) {
            self.text = text
            self.actionItems = actionItems
        }
    }


    static var clearNotification: [UInt8] {
        return commandPrefix(for: .clearNotification)
    }

    static var notification: (Notification) -> [UInt8] {
        return {
            let textBytes = $0.text.propertyBytes(0x01)
            let actionsBytes: [UInt8] = $0.actionItems?.flatMap { $0.propertyBytes(0x02) } ?? []

            return commandPrefix(for: .notification) + textBytes + actionsBytes
        }
    }

    static var notificationAction: (UInt8) -> [UInt8] {
        return {
            return commandPrefix(for: .notificationAction, additionalBytes: $0)
        }
    }
}
