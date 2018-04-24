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
//  Properties.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 24/11/2017.
//  Copyright © 2017 High Mobility. All rights reserved.
//

import Foundation


public struct Properties: Sequence {

    public var carSignature: [UInt8]? {
        return first(for: 0xA1)?.value
    }

    public var nonce: [UInt8]? {
        return first(for: 0xA0)?.value
    }

    public var timestamp: YearTime? {
        return value(for: 0xA2)
    }


    private let bytes: [UInt8]


    // MARK: Sequence

    public typealias Iterator = PropertiesIterator


    public func makeIterator() -> PropertiesIterator {
        return PropertiesIterator(bytes)
    }
}

extension Properties: BinaryInitable {

    init<C: Collection>(_ binary: C) where C.Element == UInt8 {
        bytes = binary.bytes
    }
}

extension Properties {


    func value<ReturnType>(for identifier: UInt8) -> ReturnType? {
        guard let bytes = first(for: identifier)?.value else {
            return nil
        }

        guard let firstByte = bytes.first else {
            return nil
        }

        // Handles some of the Types
        switch ReturnType.self {

        /*** INTs ***/
        case is Int8.Type:
            return Int8(bitPattern: firstByte) as? ReturnType

        case is Int16.Type:
            return Int16(bitPattern: UInt16(bytes)) as? ReturnType

        case is Int32.Type:
            return Int32(bitPattern: UInt32(bytes)) as? ReturnType

        /*** OTHERs ***/
        case is Bool.Type:
            return (firstByte == 0x01) as? ReturnType

        case is Float.Type:
            return Float(bytes) as? ReturnType

        case is FluidLevel.Type:
            return FluidLevel(rawValue: firstByte) as? ReturnType

        case is String.Type:
            return String(bytes: bytes, encoding: .utf8) as? ReturnType

        case is YearTime.Type:
            return YearTime(bytes) as? ReturnType

        /*** UINTs ***/
        case is UInt8.Type:
            return bytes.first as? ReturnType

        case is UInt16.Type:
            return UInt16(bytes) as? ReturnType

        case is UInt32.Type:
            return UInt32(bytes) as? ReturnType

        /*** Everything else... ***/
        default:
            return nil
        }
    }
}

public extension Properties {

    func contains(identifier: UInt8) -> Bool {
        return contains { $0.identifier == identifier }
    }

    func filter(for identifier: UInt8) -> [Property] {
        return filter { $0.identifier == identifier }
    }

    func first(for identifier: UInt8) -> Property? {
        return first(where: { $0.identifier == identifier })
    }

    func flatMap<T>(for identifier: UInt8, transform: (Property) throws -> T?) rethrows -> [T]? {
        let filtered = filter(for: identifier)

        guard filtered.count > 0 else {
            return nil
        }

        return try filtered.compactMap(transform)
    }
}
