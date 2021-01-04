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
//  AADrivingModeActivationPeriod.swift
//  AutoAPI
//
//  Generated by AutoAPIGenerator for Swift.
//  Copyright © 2021 High-Mobility GmbH. All rights reserved.
//

import Foundation
import HMUtilities


public final class AADrivingModeActivationPeriod: Codable, HMBytesConvertable {

    /// Driving mode.
    public var drivingMode: AADrivingMode

    /// Percentage of the period used for a driving mode.
    public var period: AAPercentage


    /// Initialise `AADrivingModeActivationPeriod` with arguments.
    ///
    /// - parameters:
    ///     - drivingMode: Driving mode.
    ///     - period: Percentage of the period used for a driving mode.
    public init(drivingMode: AADrivingMode, period: AAPercentage) {
        self.bytes = [drivingMode.bytes, period.bytes].flatMap { $0 }
        self.drivingMode = drivingMode
        self.period = period
    }


    // MARK: HMBytesConvertable
    
    public let bytes: [UInt8]
    
    
    /// Initialise `AADrivingModeActivationPeriod` with bytes.
    ///
    /// - parameters:
    ///     - bytes: Bytes array in `[UInt8]`.
    public required init?(bytes: [UInt8]) {
        guard bytes.count == 9 else {
            return nil
        }
    
        guard let drivingMode = AADrivingMode(bytes: bytes[0..<1].bytes),
    		  let period = AAPercentage(bytes: bytes[1..<9].bytes) else {
            return nil
        }
    
        self.bytes = bytes
        self.drivingMode = drivingMode
        self.period = period
    }
}