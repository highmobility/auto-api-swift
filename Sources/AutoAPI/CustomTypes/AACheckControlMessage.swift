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
//  Generated by AutoAPIGenerator for Swift.
//  Copyright © 2021 High-Mobility GmbH. All rights reserved.
//

import Foundation
import HMUtilities


public final class AACheckControlMessage: Codable, HMBytesConvertable {

    /// Check Control Message identifier.
    public var ID: UInt16

    /// Remaining time of the message.
    public var remainingTime: Measurement<UnitDuration>

    /// CCM text.
    public var text: String

    /// CCM status.
    public var status: String


    /// Initialise `AACheckControlMessage` with arguments.
    ///
    /// - parameters:
    ///     - ID: Check Control Message identifier.
    ///     - remainingTime: Remaining time of the message.
    ///     - text: CCM text.
    ///     - status: CCM status.
    public init(ID: UInt16, remainingTime: Measurement<UnitDuration>, text: String, status: String) {
        self.bytes = [ID.bytes, remainingTime.bytes, text.bytes.sizeBytes(amount: 2), text.bytes, status.bytes.sizeBytes(amount: 2), status.bytes].flatMap { $0 }
        self.ID = ID
        self.remainingTime = remainingTime
        self.text = text
        self.status = status
    }


    // MARK: HMBytesConvertable
    
    public let bytes: [UInt8]
    
    
    /// Initialise `AACheckControlMessage` with bytes.
    ///
    /// - parameters:
    ///     - bytes: Bytes array in `[UInt8]`.
    public required init?(bytes: [UInt8]) {
        guard bytes.count >= 12 else {
            return nil
        }
    
        guard let ID = UInt16(bytes: bytes[0..<2].bytes),
    		  let remainingTime = Measurement<UnitDuration>(bytes: bytes[2..<(2 + 10)].bytes),
    		  let text = bytes.extract(stringFrom: 12),
    		  let status = bytes.extract(stringFrom: (14 + text.bytes.count)) else {
            return nil
        }
    
        self.bytes = bytes
        self.ID = ID
        self.remainingTime = remainingTime
        self.text = text
        self.status = status
    }
}