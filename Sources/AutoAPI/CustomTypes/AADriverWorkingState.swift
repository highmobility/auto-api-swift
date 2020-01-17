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
//  AADriverWorkingState.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/01/2020.
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