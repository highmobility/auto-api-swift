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
//  AADriverTimeState.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/01/2020.
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