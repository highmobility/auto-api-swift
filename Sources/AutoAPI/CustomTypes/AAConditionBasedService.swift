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
//  AAConditionBasedService.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
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