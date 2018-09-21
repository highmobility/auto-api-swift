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
//  PropertiesInitable.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 20/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


protocol PropertiesInitable {

    var propertiesIterator: AAPropertiesIterator { get }


    init(propertiesArray properties: [Property])
    init(propertiesIterator iterator: AAPropertiesIterator)
}

extension PropertiesInitable {

    init(propertiesArray properties: [Property]) {
        self.init(propertiesIterator: AAPropertiesIterator(properties.flatMap { $0.bytes }))
    }
}
