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
//  AASeatbeltState.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation


/// Seatbelt state
public struct AASeatbeltState: AABytesConvertable, Equatable {

    /// Fastened state
    public enum FastenedState: UInt8, AABytesConvertable {
        case notFastened = 0x00
        case fastened = 0x01
    }


    /// Fastened state
    public let fastenedState: FastenedState

    /// Location
    public let location: AASeatLocation


    /// Initialise `AASeatbeltState` with parameters.
    ///
    /// - parameters:
    ///   - location: Location as `AASeatLocation`
    ///   - fastenedState: Fastened state as `FastenedState`
    public init(location: AASeatLocation, fastenedState: FastenedState) {
        var bytes: Array<UInt8> = []
    
        bytes += location.bytes
        bytes += fastenedState.bytes
    
        self.bytes = bytes
        self.location = location
        self.fastenedState = fastenedState
    }


    // MARK: AABytesConvertable
    
    /// `AASeatbeltState` bytes
    ///
    /// - returns: Bytes of `AASeatbeltState` in `Array<UInt8>`
    public let bytes: Array<UInt8>
    
    
    /// Initialise `AASeatbeltState` with bytes.
    ///
    /// - parameters:
    ///   - bytes: Array of bytes in `Array<UInt8>`
    public init?(bytes: Array<UInt8>) {
        guard bytes.count == 2 else {
            return nil
        }
    
        guard let location = AASeatLocation(bytes: bytes[0..<1]),
            let fastenedState = FastenedState(bytes: bytes[1..<2]) else {
                return nil
        }
    
        self.bytes = bytes
        self.location = location
        self.fastenedState = fastenedState
    }
}