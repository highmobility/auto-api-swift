//
// AutoAPI
// Copyright (C) 2019 High-Mobility GmbH
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
//  Notifications.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/12/2017.
//  Copyright © 2019 High Mobility. All rights reserved.
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
