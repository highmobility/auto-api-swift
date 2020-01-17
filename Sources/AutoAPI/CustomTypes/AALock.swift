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
//  AALock.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation


/// Lock
public struct AALock: AABytesConvertable, Equatable {

    /// Door location
    public let location: AALocation

    /// Lock state for the door
    public let lockState: AALockState


    /// Initialise `AALock` with parameters.
    ///
    /// - parameters:
    ///   - location: Door location as `AALocation`
    ///   - lockState: Lock state for the door as `AALockState`
    public init(location: AALocation, lockState: AALockState) {
        var bytes: Array<UInt8> = []
    
        bytes += location.bytes
        bytes += lockState.bytes
    
        self.bytes = bytes
        self.location = location
        self.lockState = lockState
    }


    // MARK: AABytesConvertable
    
    /// `AALock` bytes
    ///
    /// - returns: Bytes of `AALock` in `Array<UInt8>`
    public let bytes: Array<UInt8>
    
    
    /// Initialise `AALock` with bytes.
    ///
    /// - parameters:
    ///   - bytes: Array of bytes in `Array<UInt8>`
    public init?(bytes: Array<UInt8>) {
        guard bytes.count == 2 else {
            return nil
        }
    
        guard let location = AALocation(bytes: bytes[0..<1]),
            let lockState = AALockState(bytes: bytes[1..<2]) else {
                return nil
        }
    
        self.bytes = bytes
        self.location = location
        self.lockState = lockState
    }
}