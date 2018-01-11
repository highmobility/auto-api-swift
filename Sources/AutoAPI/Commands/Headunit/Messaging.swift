//
// AutoAPI
// Copyright (C) 2017 High-Mobility GmbH
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
//  Messaging.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/12/2017.
//  Copyright © 2017 High Mobility. All rights reserved.
//

import Foundation


public struct Messaging: BidirectionalCommand {

    public let recipientHandle: String?
    public let text: String?


    // MARK: BidirectionalCommand

    public let properties: Properties


    init?(_ messageType: UInt8, properties: Properties) {
        guard messageType == 0x01 else {
            return nil
        }

        // Ordered by the ID
        recipientHandle = properties.value(for: 0x01)
        text = properties.value(for: 0x02)

        // Properties
        self.properties = properties
    }
}

extension Messaging: Identifiable {

    public static var identifier: Identifier = Identifier(0x0037)
}

extension Messaging: MessageTypesGettable {

    public enum MessageTypes: UInt8, MessageTypesType {

        case messageReceived    = 0x00
        case sendMessage        = 0x01


        public static var all: [UInt8] {
            return [self.messageReceived.rawValue,
                    self.sendMessage.rawValue]
        }
    }
}

public extension Messaging {

    struct Message {
        public let senderHandle: String?
        public let text: String

        public init(senderHandle: String?, text: String) {
            self.senderHandle = senderHandle
            self.text = text
        }
    }


    static var messageReceived: (Message) -> [UInt8] {
        return {
            let handleBytes: [UInt8] = $0.senderHandle?.propertyBytes(0x01) ?? []
            let textBytes: [UInt8] = $0.text.propertyBytes(0x02)

            return identifier.bytes + [MessageTypes.messageReceived.rawValue] + handleBytes + textBytes
        }
    }
}
