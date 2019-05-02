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
//  Created by Mikk Rätsep on 12/02/2019.
//  Copyright © 2019 High Mobility GmbH. All rights reserved.
//

import Foundation


struct AAPropertyComponent {

    let bytes: [UInt8]
    let type: AAPropertyComponentType

    var value: [UInt8] {
        return Array(bytes[3...])
    }


    // MARK: Init

    init(type: AAPropertyComponentType, value: [UInt8]) {
        self.bytes = [type.rawValue] + value.count.sizeBytes(amount: 2) + value
        self.type = type
    }
}

extension AAPropertyComponent: AABytesConvertable {

    /// Picks out the first bytes that correspond to a single component
    init?(bytes: [UInt8]) {
        guard bytes.count >= 3 else {
            return nil
        }

        // UInt16 initialiser can't create an invalid value with 2 bytes
        let componentSize = UInt16(bytes: bytes[1...2])!.int
        let size = 3 + componentSize

        guard bytes.count == size else {
            return nil
        }

        guard let type = AAPropertyComponentType(rawValue: bytes[0]) else {
            return nil
        }

        self.bytes = bytes
        self.type = type
    }
}
