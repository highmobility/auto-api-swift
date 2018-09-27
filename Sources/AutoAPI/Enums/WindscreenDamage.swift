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
//  WindscreenDamage.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 05/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public enum WindscreenDamage: UInt8 {

    case noImpactDetected           = 0x00
    case impactButNoDamageDetected  = 0x01
    case damageSmallerThan_1in      = 0x02
    case damageLargerThan_1in       = 0x03


    public static let small = WindscreenDamage.damageSmallerThan_1in
    public static let big = WindscreenDamage.damageLargerThan_1in
}

extension WindscreenDamage: AAPropertyConvertable {
    
}
