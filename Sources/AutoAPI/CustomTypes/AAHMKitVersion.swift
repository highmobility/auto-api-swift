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
//  AAHMKitVersion.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation


/// HMKit version
public struct AAHMKitVersion: AABytesConvertable, Equatable {

    /// HMKit version major number
    public let major: UInt8

    /// HMKit version minor number
    public let minor: UInt8

    /// HMKit version patch number
    public let patch: UInt8


    /// Initialise `AAHMKitVersion` with parameters.
    ///
    /// - parameters:
    ///   - major: HMKit version major number as `UInt8`
    ///   - minor: HMKit version minor number as `UInt8`
    ///   - patch: HMKit version patch number as `UInt8`
    public init(major: UInt8, minor: UInt8, patch: UInt8) {
        var bytes: Array<UInt8> = []
    
        bytes += major.bytes
        bytes += minor.bytes
        bytes += patch.bytes
    
        self.bytes = bytes
        self.major = major
        self.minor = minor
        self.patch = patch
    }


    // MARK: AABytesConvertable
    
    /// `AAHMKitVersion` bytes
    ///
    /// - returns: Bytes of `AAHMKitVersion` in `Array<UInt8>`
    public let bytes: Array<UInt8>
    
    
    /// Initialise `AAHMKitVersion` with bytes.
    ///
    /// - parameters:
    ///   - bytes: Array of bytes in `Array<UInt8>`
    public init?(bytes: Array<UInt8>) {
        guard bytes.count == 3 else {
            return nil
        }
    
        guard let major = UInt8(bytes: bytes[0..<1]),
            let minor = UInt8(bytes: bytes[1..<2]),
            let patch = UInt8(bytes: bytes[2..<3]) else {
                return nil
        }
    
        self.bytes = bytes
        self.major = major
        self.minor = minor
        self.patch = patch
    }
}