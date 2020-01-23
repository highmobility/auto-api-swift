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
//  Messaging.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/12/2017.
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

    public enum MessageTypes: UInt8, MessageTypesKind {

        case messageReceived    = 0x00
        case sendMessage        = 0x01


        public static var all: [Messaging.MessageTypes] {
            return [self.messageReceived,
                    self.sendMessage]
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

            return commandPrefix(for: .messageReceived) + handleBytes + textBytes
        }
    }
}
