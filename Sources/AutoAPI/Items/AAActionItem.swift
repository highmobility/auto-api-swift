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
//  AAActionItem.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/12/2017.
//  Copyright © 2019 High Mobility GmbH. All rights reserved.
//

import Foundation


public struct AAActionItem {

    public let identifier: UInt8
    public let name: String


    public init(identifier: UInt8, name: String) {
        self.identifier = identifier
        self.name = name
    }
}

extension AAActionItem: AABytesConvertable {

    public var bytes: [UInt8] {
        return identifier.bytes + name.bytes
    }


    public init?(bytes: [UInt8]) {
        guard bytes.count >= 1 else {
            return nil
        }

        guard let string = String(bytes: bytes.dropFirst()) else {
            return nil
        }

        identifier = bytes[0]
        name = string
    }
}
