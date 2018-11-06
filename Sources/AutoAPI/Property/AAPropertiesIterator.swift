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
//  AAPropertiesIterator.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 24/11/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct AAPropertiesIterator: IteratorProtocol {

    private var bytes: [UInt8]


    // MARK: IteratorProtocol

    public typealias Element = AAProperty


    public mutating func next() -> AAProperty? {
        guard bytes.count >= 3 else {
            return nil
        }

        let size = 3 + UInt16(bytes[1...2]).int

        guard bytes.count >= size else {
            return nil
        }

        guard let property = AAProperty(bytes.prefix(upTo: size)) else {
            return nil
        }

        bytes.removeFirst(size)

        return property
    }
}

extension AAPropertiesIterator: AABinaryInitable {

    init<C: Collection>(_ binary: C) where C.Element == UInt8 {
        bytes = binary.bytes
    }
}
