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
//  ItemIterator.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 01/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


protocol ItemIterator: BinaryInitable, IteratorProtocol where Element: AAItem {

    var bytes: [UInt8] { get set }
}

extension ItemIterator {

    public mutating func next() -> Element? {
        guard bytes.count >= Element.size else {
            return nil
        }

        let itemBytes = bytes.prefix(upTo: Element.size)

        bytes.removeFirst(Element.size)

        return Element(itemBytes) ?? next()
    }
}
