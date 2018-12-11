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
//  AAPropertyFailureReason.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 11/12/2018.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public enum AAPropertyFailureReason: UInt8 {

    /// Property rate limit has been exceeded.
    case rateLimit          = 0x00

    /// Failed to retrieve property in time.
    case executionTimeout   = 0x01

    /// Could not interpret property.
    case formatError        = 0x02

    /// Insufficient permissions to get the property.
    case unauthorised       = 0x03

    /// Property missing for unknown reason.
    case unknown            = 0x04
}
