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
//  Property.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 23/11/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct Property {

    public let identifier: UInt8
    public let size: UInt16
    public let value: [UInt8]

    public var bytes: [UInt8] {
        return [identifier] + size.bytes + value.bytes
    }

    
    var monoValue: UInt8? {
        return value.first
    }
}

extension Property: BinaryInitable {

    init?<C: Collection>(_ binary: C) where C.Element == UInt8 {
        guard binary.count >= 3 else {
            return nil
        }

        /*
         This is a workaround for a Swift Compiler problem/bug? that doesn't let to subscript with an Int.
         Which should work, as it inherits Comparable from (BinaryInteger -> Stridable).
         */
        let bytes = binary.bytes

        identifier = bytes[0]
        size = UInt16(bytes[1...2])

        guard binary.count == (3 + size) else {
            return nil
        }

        value = bytes.suffix(from: 3).bytes
    }
}

extension Property: CustomStringConvertible {

    public var description: String {
        let id = String(format: "0x%02X", identifier)
        let size = String(format: "%3d", self.size)
        let value = self.value.map { String(format: "%02X", $0) }.joined()

        return "id: " + id + ", size: " + size + ", val: 0x" + value
    }
}
