//
// AutoAPI
// Copyright (C) 2018 High-Mobility GmbH
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
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct Notifications: AAInboundCommand, OutboundCommand {

    public let actionItems: [ActionItem]?
    public let receivedActionID: UInt8?
    public let receivedClearCommand: Bool
    public let text: String?


    // MARK: AAInboundCommand

    public let properties: AAProperties


    // Needs to override this to parse CUSTOM properties
    init?<C>(_ binary: C) where C : Collection, C.Element == UInt8 {
        guard binary.count >= 3 else {
            return nil
        }

        guard AACommandIdentifier(binary) == Notifications.identifier else {
            return nil
        }

        let properties: AAProperties
        let messageType = binary.bytes[2]

        switch messageType {
        case 0x00:
            properties = AAProperties(binary.dropFirstBytes(3))

        case 0x01:
            guard binary.count == 4 else {
                return nil
            }

            // Hack
            properties = AAProperties([0x99, 0x00, 0x01, binary.bytes[3]])

        case 0x02:
            guard binary.count == 3 else {
                return nil
            }

            properties = AAProperties([])

        default:
            return nil
        }

        self.init(messageType, properties: properties)
    }

    init?(_ messageType: UInt8, properties: AAProperties) {
        var properties = properties

        switch messageType {
        case 0x00:
            receivedActionID = nil
            receivedClearCommand = false

        case 0x01:
            receivedActionID = properties.value(for: 0x99)
            receivedClearCommand = false

            properties = AAProperties([])

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

extension Notifications: AAIdentifiable {

    public static var identifier: AACommandIdentifier = AACommandIdentifier(0x0038)
}

extension Notifications: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case notification       = 0x00
        case notificationAction = 0x01
        case clearNotification  = 0x02
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
