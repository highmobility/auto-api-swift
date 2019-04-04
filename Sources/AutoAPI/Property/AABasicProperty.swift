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
//  AABasicProperty.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 12/02/2019.
//  Copyright © 2019 High Mobility GmbH. All rights reserved.
//

import Foundation


public class AABasicProperty: AABytesConvertable {

    public var identifier: AAPropertyIdentifier {
        return bytes[0]
    }

    public var failure: AAPropertyFailure? {
        return AAPropertyFailure(bytes: components.component(for: .failure)?.value)
    }

    public var timestamp: Date? {
        return Date(bytes: components.component(for: .timestamp)?.value)
    }

    public var valueBytes: [UInt8]? {
        return components.component(for: .data)?.value
    }


    let components: AAPropertyComponents


    // MARK: AABytesConvertable

    public let bytes: [UInt8]


    required public init?(bytes: [UInt8]) {
        guard bytes.count >= 3 else {
            return nil
        }

        // UInt16 initialiser can't create an invalid value with 2 bytes
        let propertySize = UInt16(bytes: bytes[1...2])!.int
        let size = 3 + propertySize

        guard bytes.count == size,
            let components = AAPropertyComponents(bytes: bytes[3..<size]) else {
                return nil
        }

        // Set the required and pre-computed values
        self.bytes = bytes
        self.components = components
    }
}
