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
//  ConvertibleRoofState.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 28/08/2018.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


/*
 "Indicates the current status of the convertible roof at the time of data collection, i.e. whether it was

 closed (CLOSED),
 open (OPEN) or – in an emergency –
 locked (EMERGENCYLOCKED).

 The following additional status values are possible:

 CLOSEDSECURED = convertible roof closed, vehicle secured
 OPENSECURED = convertible roof open, vehicle secured
 HARDTOPMOUNTED = hard top mounted and closed (removable hard top)
 INTERMEDIATEPOSITION = convertible roof in intermediate position
 LOADINGPOSITION = roof is in a position that allows for easy loading of the boot
 LOADINGPOSITIONIMMEDIATE = roof is in a position that allows for easy loading of the boot"
 */

public enum ConvertibleRoofState: UInt8 {

    case closed             = 0x00
    case open               = 0x01
    case emergencyLocked    = 0x02

    case closedSecured              = 0x03
    case openSecured                = 0x04
    case hardTopMounted             = 0x05
    case intermediatePosition       = 0x06
    case loadingPosition            = 0x07
    case loadingPositionImmediate   = 0x08
}
