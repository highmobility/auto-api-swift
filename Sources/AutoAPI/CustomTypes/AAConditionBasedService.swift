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
//  AAConditionBasedService.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation


/// Condition based service
public struct AAConditionBasedService: AABytesConvertable, Equatable {

    /// Due status
    public enum DueStatus: UInt8, AABytesConvertable {
        case ok = 0x00
        case pending = 0x01
        case overdue = 0x02
    }


    /// CBS identifier
    public let id: UInt16

    /// CBS text
    public let text: String

    /// Description
    public let description: String

    /// Due status
    public let dueStatus: DueStatus

    /// The year
    public let year: UInt16

    /// Value between 1 and 12
    public let month: UInt8


    /// Initialise `AAConditionBasedService` with parameters.
    ///
    /// - parameters:
    ///   - year: The year as `UInt16`
    ///   - month: Value between 1 and 12 as `UInt8`
    ///   - id: CBS identifier as `UInt16`
    ///   - dueStatus: Due status as `DueStatus`
    ///   - text: CBS text as `String`
    ///   - description: Description as `String`
    public init(year: UInt16, month: UInt8, id: UInt16, dueStatus: DueStatus, text: String, description: String) {
        var bytes: Array<UInt8> = []
    
        bytes += year.bytes
        bytes += month.bytes
        bytes += id.bytes
        bytes += dueStatus.bytes
        bytes += text.bytes.count.sizeBytes(amount: 2) + text.bytes
        bytes += description.bytes.count.sizeBytes(amount: 2) + description.bytes
    
        self.bytes = bytes
        self.year = year
        self.month = month
        self.id = id
        self.dueStatus = dueStatus
        self.text = text
        self.description = description
    }


    // MARK: AABytesConvertable
    
    /// `AAConditionBasedService` bytes
    ///
    /// - returns: Bytes of `AAConditionBasedService` in `Array<UInt8>`
    public let bytes: Array<UInt8>
    
    
    /// Initialise `AAConditionBasedService` with bytes.
    ///
    /// - parameters:
    ///   - bytes: Array of bytes in `Array<UInt8>`
    public init?(bytes: Array<UInt8>) {
        guard bytes.count >= 10 else {
            return nil
        }
    
        guard let year = UInt16(bytes: bytes[0..<2]),
            let month = UInt8(bytes: bytes[2..<3]),
            let id = UInt16(bytes: bytes[3..<5]),
            let dueStatus = DueStatus(bytes: bytes[5..<6]),
            let text = bytes.extractString(startingIdx: 6),
            let description = bytes.extractString(startingIdx: 8 + text.bytes.count) else {
                return nil
        }
    
        self.bytes = bytes
        self.year = year
        self.month = month
        self.id = id
        self.dueStatus = dueStatus
        self.text = text
        self.description = description
    }
}