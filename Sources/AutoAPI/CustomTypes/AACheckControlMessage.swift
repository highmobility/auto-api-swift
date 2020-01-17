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
//  AACheckControlMessage.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation


/// Check control message
public struct AACheckControlMessage: AABytesConvertable, Equatable {

    /// CCM status
    public let status: String

    /// CCM text
    public let text: String

    /// Check Control Message identifier
    public let ID: UInt16

    /// Remaining time of the message in minutes
    public let remainingMinutes: UInt32


    /// Initialise `AACheckControlMessage` with parameters.
    ///
    /// - parameters:
    ///   - ID: Check Control Message identifier as `UInt16`
    ///   - remainingMinutes: Remaining time of the message in minutes as `UInt32`
    ///   - text: CCM text as `String`
    ///   - status: CCM status as `String`
    public init(ID: UInt16, remainingMinutes: UInt32, text: String, status: String) {
        var bytes: Array<UInt8> = []
    
        bytes += ID.bytes
        bytes += remainingMinutes.bytes
        bytes += text.bytes.count.sizeBytes(amount: 2) + text.bytes
        bytes += status.bytes.count.sizeBytes(amount: 2) + status.bytes
    
        self.bytes = bytes
        self.ID = ID
        self.remainingMinutes = remainingMinutes
        self.text = text
        self.status = status
    }


    // MARK: AABytesConvertable
    
    /// `AACheckControlMessage` bytes
    ///
    /// - returns: Bytes of `AACheckControlMessage` in `Array<UInt8>`
    public let bytes: Array<UInt8>
    
    
    /// Initialise `AACheckControlMessage` with bytes.
    ///
    /// - parameters:
    ///   - bytes: Array of bytes in `Array<UInt8>`
    public init?(bytes: Array<UInt8>) {
        guard bytes.count >= 10 else {
            return nil
        }
    
        guard let ID = UInt16(bytes: bytes[0..<2]),
            let remainingMinutes = UInt32(bytes: bytes[2..<6]),
            let text = bytes.extractString(startingIdx: 6),
            let status = bytes.extractString(startingIdx: 8 + text.bytes.count) else {
                return nil
        }
    
        self.bytes = bytes
        self.ID = ID
        self.remainingMinutes = remainingMinutes
        self.text = text
        self.status = status
    }
}