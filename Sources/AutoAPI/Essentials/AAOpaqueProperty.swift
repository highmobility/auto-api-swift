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
//  AAOpaqueProperty.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/07/2019.
//  Copyright © 2019 High-Mobility. All rights reserved.
//

import Foundation


public class AAOpaqueProperty: AABytesConvertable {

    public var failure: AAPropertyFailure? {
        AAPropertyFailure(bytes: components.first(forType: .failure)?.value)
    }

    public var timestamp: Date? {
        Date(bytes: components.first(forType: .timestamp)?.value)
    }

    public var identifier: AAPropertyIdentifier {
        bytes[0]
    }

    public var valueBytes: [UInt8]? {
        components.first(forType: .data)?.value
    }


    let components: [AAPropertyComponent]


    public func property<T>() -> AAProperty<T>? where T: AABytesConvertable {
        AAProperty(identifier: identifier, value: T(bytes: valueBytes), components: components)
    }


    // MARK: AABytesConvertable

    public var bytes: [UInt8]


    public required init?(bytes: [UInt8]) {
        guard bytes.count >= 3 else {
            return nil
        }

        let size = 3 + UInt16(bytes: bytes[1...2])!.int

        guard bytes.count >= size else {
            return nil
        }

        self.bytes = bytes.prefix(size).bytes
        self.components = self.bytes.suffix(from: 3).generatePropertyComponents()
    }
}


private extension Collection where Element == AAPropertyComponent {

    func first(forType type: AAPropertyComponentType) -> AAPropertyComponent? {
        first { $0.type == type }
    }
}
