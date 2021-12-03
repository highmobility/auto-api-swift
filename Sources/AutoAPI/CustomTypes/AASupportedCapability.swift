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
//  AASupportedCapability.swift
//  AutoAPI
//
//  Generated by AutoAPIGenerator for Swift.
//  Copyright © 2021 High-Mobility GmbH. All rights reserved.
//

import Foundation
import HMUtilities


public final class AASupportedCapability: Codable, HMBytesConvertable {

    /// The identifier of the supported capability.
    public var capabilityID: UInt16

    /// Array of supported property identifiers.
    public var supportedPropertyIDs: [UInt8]


    /// Initialise `AASupportedCapability` with arguments.
    ///
    /// - parameters:
    ///     - capabilityID: The identifier of the supported capability.
    ///     - supportedPropertyIDs: Array of supported property identifiers.
    public init(capabilityID: UInt16, supportedPropertyIDs: [UInt8]) {
        self.bytes = [capabilityID.bytes, supportedPropertyIDs.bytes.sizeBytes(amount: 2), supportedPropertyIDs.bytes].flatMap { $0 }
        self.capabilityID = capabilityID
        self.supportedPropertyIDs = supportedPropertyIDs
    }


    // MARK: HMBytesConvertable
    
    public let bytes: [UInt8]
    
    
    /// Initialise `AASupportedCapability` with bytes.
    ///
    /// - parameters:
    ///     - bytes: Bytes array in `[UInt8]`.
    public required init?(bytes: [UInt8]) {
        guard bytes.count >= 2 else {
            return nil
        }
    
        guard let capabilityID = UInt16(bytes: bytes[0..<2].bytes),
    		  let supportedPropertyIDs = bytes.extract(bytesFrom: 2) else {
            return nil
        }
    
        self.bytes = bytes
        self.capabilityID = capabilityID
        self.supportedPropertyIDs = supportedPropertyIDs
    }
}