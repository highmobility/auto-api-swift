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
//  ActionItem.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/12/2017.
//  Copyright © 2017 High Mobility. All rights reserved.
//

import Foundation


public struct ActionItem {

    public let identifier: UInt8
    public let name: String


    public init(identifier: UInt8, name: String) {
        self.identifier = identifier
        self.name = name
    }
}

extension ActionItem: BinaryInitable {

    init?<C>(_ binary: C) where C : Collection, C.Element == UInt8 {
        guard binary.count >= 1 else {
            return nil
        }

        guard let string = String(bytes: binary.dropFirst(), encoding: .utf8) else {
            return nil
        }

        identifier = binary.bytes[0]
        name = string
    }
}

extension ActionItem: PropertyConvertable {

    var propertyValue: [UInt8] {
        let nameBytes: [UInt8] = name.data(using: .utf8)?.bytes ?? []

        return [identifier] + nameBytes
    }
}
