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
//  AAPropertyComponent.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/07/2019.
//  Copyright © 2019 High-Mobility. All rights reserved.
//

import Foundation


struct AAPropertyComponent: AABytesConvertable {

    let type: AAPropertyComponentType

    var value: [UInt8] {
        bytes.suffix(from: 3).bytes
    }


    static func dataComponent(bytes: [UInt8]) -> Self {
        .init(type: .data, value: bytes)
    }


    init(type: AAPropertyComponentType, value: [UInt8]) {
        self.bytes = [type.rawValue] + value.count.sizeBytes(amount: 2) + value
        self.type = type
    }


    // MARK: AABytesConvertable

    let bytes: [UInt8]


    init?(bytes: [UInt8]) {
        guard bytes.count >= 3 else {
            return nil
        }

        let size = 3 + UInt16(bytes: bytes[1...2])!.int

        guard bytes.count >= size,
            let type = AAPropertyComponentType(rawValue: bytes[0]) else {
                return nil
        }

        self.bytes = bytes.prefix(size).bytes
        self.type = type
    }
}
