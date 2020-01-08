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
//  AADrivingModeActivationPeriod.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation


/// Driving mode activation period
public struct AADrivingModeActivationPeriod: AABytesConvertable, Equatable {

    /// Driving mode
    public let drivingMode: AADrivingMode

    /// Percentage of the period used for a driving mode
    public let period: AAPercentage


    /// Initialise `AADrivingModeActivationPeriod` with parameters.
    ///
    /// - parameters:
    ///   - drivingMode: Driving mode as `AADrivingMode`
    ///   - period: Percentage of the period used for a driving mode as `AAPercentage`
    public init(drivingMode: AADrivingMode, period: AAPercentage) {
        var bytes: Array<UInt8> = []
    
        bytes += drivingMode.bytes
        bytes += period.bytes
    
        self.bytes = bytes
        self.drivingMode = drivingMode
        self.period = period
    }


    // MARK: AABytesConvertable
    
    /// `AADrivingModeActivationPeriod` bytes
    ///
    /// - returns: Bytes of `AADrivingModeActivationPeriod` in `Array<UInt8>`
    public let bytes: Array<UInt8>
    
    
    /// Initialise `AADrivingModeActivationPeriod` with bytes.
    ///
    /// - parameters:
    ///   - bytes: Array of bytes in `Array<UInt8>`
    public init?(bytes: Array<UInt8>) {
        guard bytes.count == 9 else {
            return nil
        }
    
        guard let drivingMode = AADrivingMode(bytes: bytes[0..<1]),
            let period = AAPercentage(bytes: bytes[1..<9]) else {
                return nil
        }
    
        self.bytes = bytes
        self.drivingMode = drivingMode
        self.period = period
    }
}