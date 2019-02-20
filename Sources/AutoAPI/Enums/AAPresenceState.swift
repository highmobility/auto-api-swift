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
//  AAPresenceState.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 04/10/2018.
//  Copyright © 2019 High Mobility GmbH. All rights reserved.
//

import Foundation


public enum AAPresenceState: UInt8 {

    case notPresent = 0x00
    case present    = 0x01
}

extension AAPresenceState: AABytesConvertable {
    
}
