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


public class AANotifications: AACapabilityClass, AACapability {

    public let actionItems: [AAProperty<AAActionItem>]?
    public let receivedActionID: AAProperty<UInt8>?
    public let receivedClearCommand: Bool
    public let text: AAProperty<String>?


    // MARK: AACapability

    public static var identifier: AACommandIdentifier = 0x0038


    public required convenience init?(bytes: [UInt8]) {
        guard bytes.count >= 3 else {
            return nil
        }

        guard let identifier = AACommandIdentifier(bytes: bytes[0...1]) else {
            return nil
        }

        guard identifier == AANotifications.identifier else {
            return nil
        }

        guard let properties = AAProperties(bytes: bytes.dropFirst(3)) else {
            return nil
        }

        self.init(properties: properties)
    }

    required init(properties: AAProperties) {
        // Ordered by the ID
        text = properties.property(forIdentifier: 0x01)
        actionItems = properties.allOrNil(forIdentifier: 0x02)
        receivedActionID = properties.property(forIdentifier: 0x10)
        receivedClearCommand = (properties.bytes.count == 0)  // TODO: This is a "hack" – will be fixed in L11

        super.init(properties: properties)
    }
}

extension AANotifications: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case notification   = 0x00
        case action         = 0x11
        case clear          = 0x02
    }
}

public extension AANotifications {

    static var clearNotification: AACommand {
        return command(forMessageType: .clear)
    }


    static func activatedAction(_ action: UInt8) -> AACommand {
        let properties = [action.property(forIdentifier: 0x01)]

        return command(forMessageType: .action, properties: properties)
    }

    static func received(text: String, actionItems items: [AAActionItem]?) -> AACommand {
        let properties = [text.property(forIdentifier: 0x01)] + (items?.map { $0.property(forIdentifier: 0x02) } ?? [])

        return command(forMessageType: .notification, properties: properties)
    }
}
