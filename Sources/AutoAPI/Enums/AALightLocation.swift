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
//  AALightLocation.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 14/12/2018.
//  Copyright © 2019 High Mobility GmbH. All rights reserved.
//

import Foundation


public enum AALightLocation: UInt8 {

    case front  = 0x00
    case rear   = 0x01
}

extension AALightLocation: AABytesConvertable {
    
}
