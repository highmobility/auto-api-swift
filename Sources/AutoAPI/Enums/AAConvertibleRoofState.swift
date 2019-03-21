//
// AutoAPI
// Copyright (C) 2019 High-Mobility GmbH
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
//  AAConvertibleRoofState.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 28/08/2018.
//  Copyright © 2019 High Mobility GmbH. All rights reserved.
//

import Foundation


public enum AAConvertibleRoofState: UInt8 {

    /// Roof is closed.
    case closed             = 0x00

    /// Roof is open.
    case open               = 0x01

    /// Roof is locked in an emergency.
    case emergencyLocked    = 0x02

    /// Roof closed, vehicle secured.
    case closedSecured              = 0x03

    /// Roof open, vehicle secured.
    case openSecured                = 0x04

    /// Hard top mounted and closed (removable hard top).
    case hardTopMounted             = 0x05

    /// Roof in intermediate position.
    case intermediatePosition       = 0x06

    /// Roof is in a position that allows for easy loading of the boot.
    case loadingPosition            = 0x07

    /// Roof is in a position that allows for easy loading of the boot.
    case loadingPositionImmediate   = 0x08
}

extension AAConvertibleRoofState: AABytesConvertable {
    
}