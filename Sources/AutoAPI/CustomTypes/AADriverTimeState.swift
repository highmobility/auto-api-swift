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
//  AADriverTimeState.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation


/// Driver time state
public struct AADriverTimeState: AABytesConvertable, Equatable {

    /// Time state
    public enum TimeState: UInt8, AABytesConvertable {
        case normal = 0x00
        case fifteenMinBeforeFour = 0x01
        case fourReached = 0x02
        case fifteenMinBeforeNine = 0x03
        case nineReached = 0x04
        case fifteenMinBeforeSixteen = 0x05
        case sixteenReached = 0x06
    }


    /// The driver number
    public let driverNumber: UInt8

    /// Time state
    public let timeState: TimeState


    /// Initialise `AADriverTimeState` with parameters.
    ///
    /// - parameters:
    ///   - driverNumber: The driver number as `UInt8`
    ///   - timeState: Time state as `TimeState`
    public init(driverNumber: UInt8, timeState: TimeState) {
        var bytes: Array<UInt8> = []
    
        bytes += driverNumber.bytes
        bytes += timeState.bytes
    
        self.bytes = bytes
        self.driverNumber = driverNumber
        self.timeState = timeState
    }


    // MARK: AABytesConvertable
    
    /// `AADriverTimeState` bytes
    ///
    /// - returns: Bytes of `AADriverTimeState` in `Array<UInt8>`
    public let bytes: Array<UInt8>
    
    
    /// Initialise `AADriverTimeState` with bytes.
    ///
    /// - parameters:
    ///   - bytes: Array of bytes in `Array<UInt8>`
    public init?(bytes: Array<UInt8>) {
        guard bytes.count == 2 else {
            return nil
        }
    
        guard let driverNumber = UInt8(bytes: bytes[0..<1]),
            let timeState = TimeState(bytes: bytes[1..<2]) else {
                return nil
        }
    
        self.bytes = bytes
        self.driverNumber = driverNumber
        self.timeState = timeState
    }
}