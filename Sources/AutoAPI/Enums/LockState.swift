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
//  LockState.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 27/11/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


/*

 "This indicates whether the vehicle's doors were locked (LOCKED)
 or unlocked (UNLOCKED) at the time of data collection.

 Other possible values are:
 SELECTIVELOCKED = vehicle locked with the exception of the left front door (state after a remote service door unlock was first performed) 
 SECURED = vehicle has been secured = all doors locked and alarm system activated"

 */
public enum LockState: UInt8 {

    case unlocked   = 0x00
    case locked     = 0x01

    /// Vehicle has been secured = all doors locked and alarm system activated
    case secured            = 0x02

    /// Vehicle locked with the exception of the left front door (state after a remote service door unlock was first performed)
    case selectiveLocked    = 0x03


    public static let unlock = LockState.unlocked
    public static let lock = LockState.locked
}

extension LockState: PropertyConvertable {

}
