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
//  AADriverCardPresent.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation


/// Driver card present
public struct AADriverCardPresent: AABytesConvertable, Equatable {

    /// Card present
    public enum CardPresent: UInt8, AABytesConvertable {
        case notPresent = 0x00
        case present = 0x01
    }


    /// Card present
    public let cardPresent: CardPresent

    /// The driver number
    public let driverNumber: UInt8


    /// Initialise `AADriverCardPresent` with parameters.
    ///
    /// - parameters:
    ///   - driverNumber: The driver number as `UInt8`
    ///   - cardPresent: Card present as `CardPresent`
    public init(driverNumber: UInt8, cardPresent: CardPresent) {
        var bytes: Array<UInt8> = []
    
        bytes += driverNumber.bytes
        bytes += cardPresent.bytes
    
        self.bytes = bytes
        self.driverNumber = driverNumber
        self.cardPresent = cardPresent
    }


    // MARK: AABytesConvertable
    
    /// `AADriverCardPresent` bytes
    ///
    /// - returns: Bytes of `AADriverCardPresent` in `Array<UInt8>`
    public let bytes: Array<UInt8>
    
    
    /// Initialise `AADriverCardPresent` with bytes.
    ///
    /// - parameters:
    ///   - bytes: Array of bytes in `Array<UInt8>`
    public init?(bytes: Array<UInt8>) {
        guard bytes.count == 2 else {
            return nil
        }
    
        guard let driverNumber = UInt8(bytes: bytes[0..<1]),
            let cardPresent = CardPresent(bytes: bytes[1..<2]) else {
                return nil
        }
    
        self.bytes = bytes
        self.driverNumber = driverNumber
        self.cardPresent = cardPresent
    }
}