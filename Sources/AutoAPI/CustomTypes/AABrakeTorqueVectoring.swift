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
//  AABrakeTorqueVectoring.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation


/// Brake torque vectoring
public struct AABrakeTorqueVectoring: AABytesConvertable, Equatable {

    /// Axle
    public let axle: AAAxle

    /// State
    public let state: AAActiveState


    /// Initialise `AABrakeTorqueVectoring` with parameters.
    ///
    /// - parameters:
    ///   - axle: Axle as `AAAxle`
    ///   - state: State as `AAActiveState`
    public init(axle: AAAxle, state: AAActiveState) {
        var bytes: Array<UInt8> = []
    
        bytes += axle.bytes
        bytes += state.bytes
    
        self.bytes = bytes
        self.axle = axle
        self.state = state
    }


    // MARK: AABytesConvertable
    
    /// `AABrakeTorqueVectoring` bytes
    ///
    /// - returns: Bytes of `AABrakeTorqueVectoring` in `Array<UInt8>`
    public let bytes: Array<UInt8>
    
    
    /// Initialise `AABrakeTorqueVectoring` with bytes.
    ///
    /// - parameters:
    ///   - bytes: Array of bytes in `Array<UInt8>`
    public init?(bytes: Array<UInt8>) {
        guard bytes.count == 2 else {
            return nil
        }
    
        guard let axle = AAAxle(bytes: bytes[0..<1]),
            let state = AAActiveState(bytes: bytes[1..<2]) else {
                return nil
        }
    
        self.bytes = bytes
        self.axle = axle
        self.state = state
    }
}