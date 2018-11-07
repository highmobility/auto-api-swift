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
//  AAProperties.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 24/11/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct AAProperties: Sequence, AAPropertiesCapable, AAPropertiesTimestampGettable {

    public var carSignature: [UInt8]? {
        return first(for: 0xA1)?.value
    }

    public var milliseconds: TimeInterval? {
        return value(for: 0xA3)
    }

    public var nonce: [UInt8]? {
        return first(for: 0xA0)?.value
    }

    public var timestamp: Date? {
        return value(for: 0xA2)
    }

    public var properties: AAProperties {
        return self
    }

    public var propertiesTimestamps: [AAPropertyTimestamp]? {
        return flatMap(for: 0xA4) { AAPropertyTimestamp($0.value) }
    }

    public func propertyTimestamp<Type>(for keyPath: KeyPath<AAProperties, Type>, specificProperty property: Any?) -> AAPropertyTimestamp? {
        return nil
    }


    let bytes: [UInt8]


    // MARK: Sequence

    public typealias Iterator = AAPropertiesIterator


    public func makeIterator() -> AAPropertiesIterator {
        return AAPropertiesIterator(bytes)
    }
}

extension AAProperties: AABinaryInitable {

    init<C: Collection>(_ binary: C) where C.Element == UInt8 {
        bytes = binary.bytes
    }
}

extension AAProperties {

    func value<ReturnType>(for identifier: AAPropertyIdentifier) -> ReturnType? {
        guard let bytes = first(for: identifier)?.value else {
            return nil
        }

        guard let firstByte = bytes.first else {
            return nil
        }

        switch ReturnType.self {

        /*** INTs ***/
        case is Int8.Type:
            return Int8(bitPattern: firstByte) as? ReturnType

        case is Int16.Type:
            return Int16(bitPattern: UInt16(bytes)) as? ReturnType

        case is Int32.Type:
            return Int32(bitPattern: UInt32(bytes)) as? ReturnType


        /*** OTHERs ***/
        case is AAActiveState.Type:
            return AAActiveState(rawValue: firstByte) as? ReturnType

        case is Date.Type:
            return Date(bytes) as? ReturnType

        case is Double.Type:
            return Double(bytes) as? ReturnType

        case is Float.Type:
            return Float(bytes) as? ReturnType

        case is AAFluidLevel.Type:
            return AAFluidLevel(rawValue: firstByte) as? ReturnType

        case is String.Type:
            return String(bytes: bytes, encoding: .utf8) as? ReturnType


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

    func value<Type: AAPropertyIdentifierGettable, ReturnType>(for propertyKeyPath: KeyPath<Type, ReturnType?>) -> ReturnType? {
        let identifier = Type.propertyID(for: propertyKeyPath)

        guard identifier != 0x00 else {
            return nil
        }

        return value(for: identifier)
    }
}

extension AAProperties {

    func contains(identifier: AAPropertyIdentifier) -> Bool {
        return contains { $0.identifier == identifier }
    }


    func filter(for identifier: AAPropertyIdentifier) -> [AAProperty] {
        return filter { $0.identifier == identifier }
    }

    func filter<Type: AAPropertyIdentifierGettable, ReturnType>(for propertyKeyPath: KeyPath<Type, ReturnType>) -> [AAProperty] {
        let identifer = Type.propertyID(for: propertyKeyPath)

        guard identifer != 0x00 else {
            return []
        }

        return filter(for: identifer)
    }


    func first(for identifier: AAPropertyIdentifier) -> AAProperty? {
        return first(where: { $0.identifier == identifier })
    }

    func first<Type: AAPropertyIdentifierGettable, ReturnType>(for propertyKeyPath: KeyPath<Type, ReturnType>) -> AAProperty? {
        let identifier = Type.propertyID(for: propertyKeyPath)

        guard identifier != 0x00 else {
            return nil
        }

        return first(for: identifier)
    }


    func flatMap<T>(for identifier: AAPropertyIdentifier, transform: (AAProperty) throws -> T?) rethrows -> [T]? {
        let filtered = filter(for: identifier)

        guard filtered.count > 0 else {
            return nil
        }

        return try filtered.compactMap(transform)
    }

    func flatMap<T, Type: AAPropertyIdentifierGettable, ReturnType>(for propertyKeyPath: KeyPath<Type, ReturnType>, transform: (AAProperty) throws -> T?) rethrows -> [T]? {
        let identifier = Type.propertyID(for: propertyKeyPath)

        guard identifier != 0x00 else {
            return nil
        }

        return try flatMap(for: identifier, transform: transform)
    }
}
