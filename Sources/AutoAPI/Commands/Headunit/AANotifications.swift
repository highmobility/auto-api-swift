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
//  AANotifications.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct AANotifications: AAInboundCommand, AAOutboundCommand {

    public let actionItems: [AAActionItem]?
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

        guard AACommandIdentifier(binary) == AANotifications.identifier else {
            return nil
        }

        let properties: AAProperties
        let messageType = binary.bytes[2]

        switch messageType {
        case MessageTypes.notification.rawValue:
            properties = AAProperties(binary.dropFirstBytes(3))

        case MessageTypes.action.rawValue:
            properties = AAProperties(binary.dropFirstBytes(3))

        case MessageTypes.clear.rawValue:
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
        case MessageTypes.notification.rawValue:
            receivedActionID = nil
            receivedClearCommand = false

        case MessageTypes.action.rawValue:
            receivedActionID = properties.value(for: \AANotifications.receivedActionID)
            receivedClearCommand = false

            properties = AAProperties([])

        case MessageTypes.clear.rawValue:
            receivedActionID = nil
            receivedClearCommand = true

        default:
            return nil
        }

        // Ordered by the ID
        text = properties.value(for: \AANotifications.text)
        actionItems = properties.flatMap(for: \AANotifications.actionItems) { AAActionItem($0.value) }

        // Properties
        self.properties = properties
    }
}

extension AANotifications: AAIdentifiable {

    public static var identifier: AACommandIdentifier = 0x0038
}

extension AANotifications: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case notification   = 0x00
        case action         = 0x11
        case clear          = 0x02
    }
}

extension AANotifications: AAPropertyIdentifierGettable {

    static func propertyID<Type>(for keyPath: KeyPath<AANotifications, Type>) -> AAPropertyIdentifier {
        switch keyPath {
        case \AANotifications.text:         return 0x01
        case \AANotifications.actionItems:  return 0x02
            /* Level 8 */
        case \AANotifications.receivedActionID: return 0x10

        default:
            return 0x00
        }
    }
}

public extension AANotifications {

    static var clearNotification: [UInt8] {
        return commandPrefix(for: .clear)
    }


    static func activatedAction(_ action: UInt8) -> [UInt8] {
        return commandPrefix(for: .action) + action.propertyBytes(0x01)
    }

    static func received(text: String, actionItems items: [AAActionItem]?) -> [UInt8] {
        return commandPrefix(for: .notification) + text.propertyBytes(0x01)
                                                 + (items?.reduceToByteArray { $0.propertyBytes(0x02) } ?? [])
    }
}
