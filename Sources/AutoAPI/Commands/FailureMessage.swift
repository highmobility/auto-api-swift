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
//  FailureMessage.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 28/11/2017.
//

import Foundation


public struct FailureMessage: InboundCommand {

    public let failedMessageIdentifier: Identifier?
    public let failedMessageType: UInt8?
    public let failureDescription: String?
    public let failureReason: FailureReason?


    // MARK: InboundCommand

    public let properties: Properties


    init?(_ messageType: UInt8, properties: Properties) {
        guard messageType == 0x01 else {
            return nil
        }

        failedMessageIdentifier = properties.value(for: 0x01)
        failedMessageType = properties.value(for: 0x02)
        failureReason = FailureReason(rawValue: properties.first(for: 0x03)?.monoValue)
        failureDescription = properties.value(for: 0x04)

        // Properties
        self.properties = properties
    }
}

extension FailureMessage: Identifiable {

    public static var identifier: Identifier = Identifier(0x0002)
}

extension FailureMessage: MessageTypesGettable {

    public enum MessageTypes: UInt8, MessageTypesKind {

        case failure = 0x01


        public static var all: [FailureMessage.MessageTypes] {
            return [self.failure]
        }
    }
}
