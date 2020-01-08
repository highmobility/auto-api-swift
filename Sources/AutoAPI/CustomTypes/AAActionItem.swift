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
//  AAActionItem.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation


/// Action item
public struct AAActionItem: AABytesConvertable, Equatable {

    /// Action identifier
    public let id: UInt8

    /// Name of the action
    public let name: String


    /// Initialise `AAActionItem` with parameters.
    ///
    /// - parameters:
    ///   - id: Action identifier as `UInt8`
    ///   - name: Name of the action as `String`
    public init(id: UInt8, name: String) {
        var bytes: Array<UInt8> = []
    
        bytes += id.bytes
        bytes += name.bytes.count.sizeBytes(amount: 2) + name.bytes
    
        self.bytes = bytes
        self.id = id
        self.name = name
    }


    // MARK: AABytesConvertable
    
    /// `AAActionItem` bytes
    ///
    /// - returns: Bytes of `AAActionItem` in `Array<UInt8>`
    public let bytes: Array<UInt8>
    
    
    /// Initialise `AAActionItem` with bytes.
    ///
    /// - parameters:
    ///   - bytes: Array of bytes in `Array<UInt8>`
    public init?(bytes: Array<UInt8>) {
        guard bytes.count >= 3 else {
            return nil
        }
    
        guard let id = UInt8(bytes: bytes[0..<1]),
            let name = bytes.extractString(startingIdx: 1) else {
                return nil
        }
    
        self.bytes = bytes
        self.id = id
        self.name = name
    }
}