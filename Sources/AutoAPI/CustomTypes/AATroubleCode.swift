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
//  AATroubleCode.swift
//  AutoAPI
//
//  Generated by AutoAPIGenerator for Swift.
//  Copyright © 2021 High-Mobility GmbH. All rights reserved.
//

import Foundation
import HMUtilities


public final class AATroubleCode: Codable, HMBytesConvertable {

    /// System.
    public enum System: UInt8, CaseIterable, Codable, HMBytesConvertable {
        case unknown = 0x00
        case body = 0x01
        case chassis = 0x02
        case powertrain = 0x03
        case network = 0x04
    }


    /// Number of occurrences.
    public var occurrences: UInt8

    /// Identifier.
    public var ID: String

    /// Electronic Control Unit identifier.
    public var ecuID: String

    /// Status.
    public var status: String

    /// System.
    public var system: System


    /// Initialise `AATroubleCode` with arguments.
    ///
    /// - parameters:
    ///     - occurrences: Number of occurrences.
    ///     - ID: Identifier.
    ///     - ecuID: Electronic Control Unit identifier.
    ///     - status: Status.
    ///     - system: System.
    public init(occurrences: UInt8, ID: String, ecuID: String, status: String, system: System) {
        self.bytes = [occurrences.bytes, ID.bytes.sizeBytes(amount: 2), ID.bytes, ecuID.bytes.sizeBytes(amount: 2), ecuID.bytes, status.bytes.sizeBytes(amount: 2), status.bytes, system.bytes].flatMap { $0 }
        self.occurrences = occurrences
        self.ID = ID
        self.ecuID = ecuID
        self.status = status
        self.system = system
    }


    // MARK: HMBytesConvertable
    
    public let bytes: [UInt8]
    
    
    /// Initialise `AATroubleCode` with bytes.
    ///
    /// - parameters:
    ///     - bytes: Bytes array in `[UInt8]`.
    public required init?(bytes: [UInt8]) {
        guard bytes.count >= 2 else {
            return nil
        }
    
        guard let occurrences = UInt8(bytes: bytes[0..<1].bytes),
    		  let ID = bytes.extract(stringFrom: 1),
    		  let ecuID = bytes.extract(stringFrom: (3 + ID.bytes.count)),
    		  let status = bytes.extract(stringFrom: (5 + ID.bytes.count + ecuID.bytes.count)),
    		  let system = System(bytes: bytes[(7 + ID.bytes.count + ecuID.bytes.count + status.bytes.count)..<(8 + ID.bytes.count + ecuID.bytes.count + status.bytes.count)].bytes) else {
            return nil
        }
    
        self.bytes = bytes
        self.occurrences = occurrences
        self.ID = ID
        self.ecuID = ecuID
        self.status = status
        self.system = system
    }
}