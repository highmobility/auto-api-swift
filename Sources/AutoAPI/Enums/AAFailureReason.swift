//
// AutoAPI
// Copyright (C) 2018 High-Mobility GmbH
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
//  AAFailureReason.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 28/11/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public enum AAFailureReason: UInt8 {

    /// Car has not the capability to perform the command.
    case unsupportedCapability  = 0x00

    /// User has not been authenticated or lacks permissions.
    case unauthorised           = 0x01

    /// Command can not be executed in the current car state.
    case incorrectState         = 0x02

    /// Command failed to execute in time for an unknown reason.
    case executionTimeout       = 0x03

    /// Car has to be waken up before the command can be used.
    /// If this is for a virtual car, the emulator has to be loaded.
    case vehicleAsleep          = 0x04

    /// Not recognised.
    case invalidCommand         = 0x05

    /// Capability is being refreshed.
    case pending                = 0x06

    /// Capability rate limit has been exceeded.
    case rateLimit              = 0x07
}

extension AAFailureReason: AABytesConvertable {
    
}
