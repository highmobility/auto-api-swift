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
//  AATroubleCode.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
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