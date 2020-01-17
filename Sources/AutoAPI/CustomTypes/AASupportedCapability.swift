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
//  Created by Mikk Rätsep on 13/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation


/// Supported capability
public struct AASupportedCapability: AABytesConvertable, Equatable {

    /// Array of supported property identifiers
    public let supportedPropertyIDs: Array<UInt8>

    /// The identifier of the supported capability
    public let capabilityID: UInt16


    /// Initialise `AASupportedCapability` with parameters.
    ///
    /// - parameters:
    ///   - capabilityID: The identifier of the supported capability as `UInt16`
    ///   - supportedPropertyIDs: Array of supported property identifiers as `Array<UInt8>`
    public init(capabilityID: UInt16, supportedPropertyIDs: Array<UInt8>) {
        var bytes: Array<UInt8> = []
    
        bytes += capabilityID.bytes
        bytes += supportedPropertyIDs.bytes.count.sizeBytes(amount: 2) + supportedPropertyIDs.bytes
    
        self.bytes = bytes
        self.capabilityID = capabilityID
        self.supportedPropertyIDs = supportedPropertyIDs
    }


    // MARK: AABytesConvertable
    
    /// `AASupportedCapability` bytes
    ///
    /// - returns: Bytes of `AASupportedCapability` in `Array<UInt8>`
    public let bytes: Array<UInt8>
    
    
    /// Initialise `AASupportedCapability` with bytes.
    ///
    /// - parameters:
    ///   - bytes: Array of bytes in `Array<UInt8>`
    public init?(bytes: Array<UInt8>) {
        guard bytes.count >= 2 else {
            return nil
        }
    
        guard let capabilityID = UInt16(bytes: bytes[0..<2]),
            let supportedPropertyIDs = bytes.extractBytes(startingIdx: 2) else {
                return nil
        }
    
        self.bytes = bytes
        self.capabilityID = capabilityID
        self.supportedPropertyIDs = supportedPropertyIDs
    }
}