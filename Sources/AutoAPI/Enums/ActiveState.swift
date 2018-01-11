//
// AutoAPI
// Copyright (C) 2017 High-Mobility GmbH
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
//  ActiveState.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 30/11/2017.
//  Copyright © 2017 High Mobility. All rights reserved.
//

import Foundation


public enum ActiveState: UInt8 {

    case inactive   = 0x00
    case active     = 0x01


    public static let inactivate = ActiveState.inactive
    public static let inactivated = ActiveState.inactive

    public static let deactive = ActiveState.inactive
    public static let deactivate = ActiveState.inactive
    public static let deactivated = ActiveState.inactive

    public static let activate = ActiveState.active
    public static let activated = ActiveState.active
}

extension ActiveState: PropertyConvertable {

}
