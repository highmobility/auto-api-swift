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
//  AAAvailability.swift
//  AutoAPI
//
//  Generated by AutoAPIGenerator for Swift.
//  Copyright © 2021 High-Mobility GmbH. All rights reserved.
//

import Foundation
import HMUtilities


public final class AAAvailability: Codable, HMBytesConvertable {

    /// Update rate.
    public enum UpdateRate: UInt8, CaseIterable, Codable, HMBytesConvertable {
        case tripHigh = 0x00
        case trip = 0x01
        case tripStartEnd = 0x02
        case tripEnd = 0x03
        case unknown = 0x04
        case notAvailable = 0x05
        case onChange = 0x06
    }

    /// Rate limit applies per.
    public enum AppliesPer: UInt8, CaseIterable, Codable, HMBytesConvertable {
        case app = 0x00
        case vehicle = 0x01
    }


    /// Update rate.
    public var updateRate: UpdateRate

    /// Frequency denoting the rate limit.
    public var rateLimit: Measurement<UnitFrequency>

    /// Rate limit applies per.
    public var appliesPer: AppliesPer


    /// Initialise `AAAvailability` with arguments.
    ///
    /// - parameters:
    ///     - updateRate: Update rate.
    ///     - rateLimit: Frequency denoting the rate limit.
    ///     - appliesPer: Rate limit applies per.
    public init(updateRate: UpdateRate, rateLimit: Measurement<UnitFrequency>, appliesPer: AppliesPer) {
        self.bytes = [updateRate.bytes, rateLimit.bytes, appliesPer.bytes].flatMap { $0 }
        self.updateRate = updateRate
        self.rateLimit = rateLimit
        self.appliesPer = appliesPer
    }


    // MARK: HMBytesConvertable
    
    public let bytes: [UInt8]
    
    
    /// Initialise `AAAvailability` with bytes.
    ///
    /// - parameters:
    ///     - bytes: Bytes array in `[UInt8]`.
    public required init?(bytes: [UInt8]) {
        guard bytes.count == 12 else {
            return nil
        }
    
        guard let updateRate = UpdateRate(bytes: bytes[0..<1].bytes),
    		  let rateLimit = Measurement<UnitFrequency>(bytes: bytes[1..<(1 + 10)].bytes),
    		  let appliesPer = AppliesPer(bytes: bytes[11..<12].bytes) else {
            return nil
        }
    
        self.bytes = bytes
        self.updateRate = updateRate
        self.rateLimit = rateLimit
        self.appliesPer = appliesPer
    }
}