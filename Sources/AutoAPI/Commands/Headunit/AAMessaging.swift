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
//  AAMessaging.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct AAMessaging: AAInboundCommand, AAOutboundCommand {

    public let recipientHandle: String?
    public let text: String?


    // MARK: AAInboundCommand

    public let properties: AAProperties


    init?(_ messageType: UInt8, properties: AAProperties) {
        guard messageType == 0x01 else {
            return nil
        }

        // Ordered by the ID
        recipientHandle = properties.value(for: \AAMessaging.recipientHandle)
        text = properties.value(for: \AAMessaging.text)

        // Properties
        self.properties = properties
    }
}

extension AAMessaging: AAIdentifiable {

    public static var identifier: AACommandIdentifier = 0x0037
}

extension AAMessaging: AALegacyGettable {

    public struct Legacy: AALegacyType {

        public typealias MessageTypes = AAMessaging.MessageTypes


        public init(properties: AAProperties) {

        }
    }
}

extension AAMessaging: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case received   = 0x00
        case send       = 0x01
    }
}

extension AAMessaging: AAPropertyIdentifierGettable {

    static func propertyID<Type>(for keyPath: KeyPath<AAMessaging, Type>) -> AAPropertyIdentifier {
        switch keyPath {
        case \AAMessaging.recipientHandle:  return 0x01
        case \AAMessaging.text:             return 0x02

        default:
            return 0x00
        }
    }
}


// MARK: Commands

public extension AAMessaging {

    static func received(message text: String, senderHandle handle: String?) -> [UInt8] {
        return commandPrefix(for: .received) + [text.propertyBytes(0x01),
                                                handle?.propertyBytes(0x02)].propertiesValuesCombined
    }
}

public extension AAMessaging.Legacy {

    struct Message {
        public let senderHandle: String?
        public let text: String

        public init(senderHandle: String?, text: String) {
            self.senderHandle = senderHandle
            self.text = text
        }
    }


    static var received: (Message) -> [UInt8] {
        return {
            let handleBytes: [UInt8] = $0.senderHandle?.propertyBytes(0x01) ?? []
            let textBytes: [UInt8] = $0.text.propertyBytes(0x02)

            return commandPrefix(for: AAMessaging.self, messageType: .received) + handleBytes + textBytes
        }
    }
}
