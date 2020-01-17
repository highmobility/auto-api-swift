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
//  AATroubleCode.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation


/// Trouble code
public struct AATroubleCode: AABytesConvertable, Equatable {

    /// Electronic Control Unit identifier
    public let ecuID: String

    /// Identifier
    public let ID: String

    /// Number of occurences
    public let occurences: UInt8

    /// Status
    public let status: String


    /// Initialise `AATroubleCode` with parameters.
    ///
    /// - parameters:
    ///   - occurences: Number of occurences as `UInt8`
    ///   - ID: Identifier as `String`
    ///   - ecuID: Electronic Control Unit identifier as `String`
    ///   - status: Status as `String`
    public init(occurences: UInt8, ID: String, ecuID: String, status: String) {
        var bytes: Array<UInt8> = []
    
        bytes += occurences.bytes
        bytes += ID.bytes.count.sizeBytes(amount: 2) + ID.bytes
        bytes += ecuID.bytes.count.sizeBytes(amount: 2) + ecuID.bytes
        bytes += status.bytes.count.sizeBytes(amount: 2) + status.bytes
    
        self.bytes = bytes
        self.occurences = occurences
        self.ID = ID
        self.ecuID = ecuID
        self.status = status
    }


    // MARK: AABytesConvertable
    
    /// `AATroubleCode` bytes
    ///
    /// - returns: Bytes of `AATroubleCode` in `Array<UInt8>`
    public let bytes: Array<UInt8>
    
    
    /// Initialise `AATroubleCode` with bytes.
    ///
    /// - parameters:
    ///   - bytes: Array of bytes in `Array<UInt8>`
    public init?(bytes: Array<UInt8>) {
        guard bytes.count >= 7 else {
            return nil
        }
    
        guard let occurences = UInt8(bytes: bytes[0..<1]),
            let ID = bytes.extractString(startingIdx: 1),
            let ecuID = bytes.extractString(startingIdx: 3 + ID.bytes.count),
            let status = bytes.extractString(startingIdx: 5 + ID.bytes.count + ecuID.bytes.count) else {
                return nil
        }
    
        self.bytes = bytes
        self.occurences = occurences
        self.ID = ID
        self.ecuID = ecuID
        self.status = status
    }
}