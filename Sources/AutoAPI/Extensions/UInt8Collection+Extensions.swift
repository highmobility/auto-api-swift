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
//  UInt8Collection+Extensions.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 26/08/2019.
//  Copyright © 2019 High-Mobility. All rights reserved.
//

import Foundation
import HMUtilities


extension Collection where Element == UInt8, Index == Int {

    func extractBytes(startingIdx idx: Int) -> [UInt8]? {
        extractBytesWith2ByteSizePrefix(startingIdx: idx)
    }

    func extractString(startingIdx idx: Int) -> String? {
        guard let bytes = extractBytesWith2ByteSizePrefix(startingIdx: idx) else {
            return nil
        }

        return String(bytes: bytes)
    }

    func generatePropertyComponents() -> [AAPropertyComponent] {
        var bytes = self.bytes
        var components: [AAPropertyComponent] = []

        while let component = AAPropertyComponent(bytes: bytes) {
            bytes.removeFirst(component.bytes.count)
            components.append(component)
        }

        return components
    }
}

private extension Collection where Element == UInt8, Index == Int {

    func extractBytesWith2ByteSizePrefix(startingIdx idx: Int) -> [UInt8]? {
        guard count >= (idx + 1) else {
            return nil
        }

        // UInt16 initialiser can't create an invalid value with 2 bytes
        let size = UInt16(bytes: self[idx...(idx + 1)].bytes)!.int

        guard count >= (idx + 2 + size) else {
            return nil
        }

        return self[(idx + 2) ..< (idx + 2 + size)].bytes
    }
}
