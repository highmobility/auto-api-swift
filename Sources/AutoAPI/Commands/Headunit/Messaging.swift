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
//  Messaging.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct Messaging: AAInboundCommand, AAOutboundCommand {

    public let recipientHandle: String?
    public let text: String?


    // MARK: AAInboundCommand

    public let properties: AAProperties


    init?(_ messageType: UInt8, properties: AAProperties) {
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

extension Messaging: AAIdentifiable {

    public static var identifier: AACommandIdentifier = AACommandIdentifier(0x0037)
}

extension Messaging: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case received   = 0x00
        case send       = 0x01
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


    static var received: (Message) -> [UInt8] {
        return {
            let handleBytes: [UInt8] = $0.senderHandle?.propertyBytes(0x01) ?? []
            let textBytes: [UInt8] = $0.text.propertyBytes(0x02)

            return commandPrefix(for: .received) + handleBytes + textBytes
        }
    }
}
