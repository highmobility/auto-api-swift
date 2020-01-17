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
//  AASpringRate.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation


/// Spring rate
public struct AASpringRate: AABytesConvertable, Equatable {

    /// Axle
    public let axle: AAAxle

    /// The suspension spring rate in N/mm
    public let springRate: UInt8


    /// Initialise `AASpringRate` with parameters.
    ///
    /// - parameters:
    ///   - axle: Axle as `AAAxle`
    ///   - springRate: The suspension spring rate in N/mm as `UInt8`
    public init(axle: AAAxle, springRate: UInt8) {
        var bytes: Array<UInt8> = []
    
        bytes += axle.bytes
        bytes += springRate.bytes
    
        self.bytes = bytes
        self.axle = axle
        self.springRate = springRate
    }


    // MARK: AABytesConvertable
    
    /// `AASpringRate` bytes
    ///
    /// - returns: Bytes of `AASpringRate` in `Array<UInt8>`
    public let bytes: Array<UInt8>
    
    
    /// Initialise `AASpringRate` with bytes.
    ///
    /// - parameters:
    ///   - bytes: Array of bytes in `Array<UInt8>`
    public init?(bytes: Array<UInt8>) {
        guard bytes.count == 2 else {
            return nil
        }
    
        guard let axle = AAAxle(bytes: bytes[0..<1]),
            let springRate = UInt8(bytes: bytes[1..<2]) else {
                return nil
        }
    
        self.bytes = bytes
        self.axle = axle
        self.springRate = springRate
    }
}