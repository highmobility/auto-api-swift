//
// AutoAPI
// Copyright (C) 2020 High-Mobility GmbH
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program. If not, see http://www.gnu.org/licenses/.
//
// Please inquire about commercial licensing options at
// licensing@high-mobility.com
//
//
//  AAHMKitVersion.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
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