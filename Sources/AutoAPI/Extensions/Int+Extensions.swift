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
//  Int+Extensions.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 14/02/2019.
//  Copyright © 2019 High Mobility GmbH. All rights reserved.
//

import Foundation


extension Int {

    func sizeBytes(amount: Int) -> [UInt8] {
        return (0..<amount).map {
            (self >> ($0 * 8)).uint8
        }.reversed()
    }
}
