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
//  AAReductionTime.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation


/// Reduction time
public struct AAReductionTime: AABytesConvertable, Equatable {

    /// Start stop
    public let startStop: AAStartStop

    /// Time
    public let time: AATime


    /// Initialise `AAReductionTime` with parameters.
    ///
    /// - parameters:
    ///   - startStop: Start stop as `AAStartStop`
    ///   - time: Time as `AATime`
    public init(startStop: AAStartStop, time: AATime) {
        var bytes: Array<UInt8> = []
    
        bytes += startStop.bytes
        bytes += time.bytes
    
        self.bytes = bytes
        self.startStop = startStop
        self.time = time
    }


    // MARK: AABytesConvertable
    
    /// `AAReductionTime` bytes
    ///
    /// - returns: Bytes of `AAReductionTime` in `Array<UInt8>`
    public let bytes: Array<UInt8>
    
    
    /// Initialise `AAReductionTime` with bytes.
    ///
    /// - parameters:
    ///   - bytes: Array of bytes in `Array<UInt8>`
    public init?(bytes: Array<UInt8>) {
        guard bytes.count == 3 else {
            return nil
        }
    
        guard let startStop = AAStartStop(bytes: bytes[0..<1]),
            let time = AATime(bytes: bytes[1..<3]) else {
                return nil
        }
    
        self.bytes = bytes
        self.startStop = startStop
        self.time = time
    }
}