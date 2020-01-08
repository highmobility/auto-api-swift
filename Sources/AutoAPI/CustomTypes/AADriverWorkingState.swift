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
//  AADriverWorkingState.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation


/// Driving working state
public struct AADriverWorkingState: AABytesConvertable, Equatable {

    /// Working state
    public enum WorkingState: UInt8, AABytesConvertable {
        case resting = 0x00
        case driverAvailable = 0x01
        case working = 0x02
        case driving = 0x03
    }


    /// The driver number
    public let driverNumber: UInt8

    /// Working state
    public let workingState: WorkingState


    /// Initialise `AADriverWorkingState` with parameters.
    ///
    /// - parameters:
    ///   - driverNumber: The driver number as `UInt8`
    ///   - workingState: Working state as `WorkingState`
    public init(driverNumber: UInt8, workingState: WorkingState) {
        var bytes: Array<UInt8> = []
    
        bytes += driverNumber.bytes
        bytes += workingState.bytes
    
        self.bytes = bytes
        self.driverNumber = driverNumber
        self.workingState = workingState
    }


    // MARK: AABytesConvertable
    
    /// `AADriverWorkingState` bytes
    ///
    /// - returns: Bytes of `AADriverWorkingState` in `Array<UInt8>`
    public let bytes: Array<UInt8>
    
    
    /// Initialise `AADriverWorkingState` with bytes.
    ///
    /// - parameters:
    ///   - bytes: Array of bytes in `Array<UInt8>`
    public init?(bytes: Array<UInt8>) {
        guard bytes.count == 2 else {
            return nil
        }
    
        guard let driverNumber = UInt8(bytes: bytes[0..<1]),
            let workingState = WorkingState(bytes: bytes[1..<2]) else {
                return nil
        }
    
        self.bytes = bytes
        self.driverNumber = driverNumber
        self.workingState = workingState
    }
}