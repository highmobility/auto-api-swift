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
//  InboundCommand.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 14/12/2017.
//

import Foundation


protocol InboundCommand: CommandAggregate, BinaryInitable, PropertiesCapable {

    init?(_ messageType: UInt8, properties: Properties)
}

extension InboundCommand {

    // MARK: BinaryInitable

    init?<C>(_ binary: C) where C : Collection, C.Element == UInt8 {
        guard binary.count >= 3 else {
            return nil
        }

        guard Identifier(binary) == Self.identifier else {
            return nil
        }

        let messageType = binary.bytes[2]
        let properties = Properties(binary.dropFirstBytes(3))

        self.init(messageType, properties: properties)
    }


    // MARK: PropertiesCapable

    public var carSignature: [UInt8]? {
        return properties.carSignature
    }

    public var nonce: [UInt8]? {
        return properties.nonce
    }

    public var timestamp: YearTime? {
        return properties.timestamp
    }
}
