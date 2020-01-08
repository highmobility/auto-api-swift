//
// AutoAPI
// Copyright (C) 2020 High-Mobility GmbH
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
//  AACheckControlMessage.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
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