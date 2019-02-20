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
//  AATimeState.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 30/04/2018.
//  Copyright © 2019 High Mobility GmbH. All rights reserved.
//

import Foundation


public enum AATimeState: UInt8 {

    case normal                 = 0x00
    case quarterBefore4½Hours   = 0x01
    case reached4½Hours         = 0x02
    case quarterBefore9Hours    = 0x03
    case reached9Hours          = 0x04
    case quarterBefore16Hours   = 0x05
    case reached16Hours         = 0x06
}

extension AATimeState: AABytesConvertable {
    
}
