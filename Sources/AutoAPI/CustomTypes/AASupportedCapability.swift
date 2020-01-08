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
//  AASupportedCapability.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
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