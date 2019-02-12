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


public struct AAProperties: Sequence, AAPropertiesCapable {

    public var carSignature: [UInt8]? {
        return first(for: 0xA1)?.value
    }

    public var milliseconds: TimeInterval? {
        guard let bytes = first(for: 0xA3)?.value else {
            return nil
        }

        return TimeInterval(bytes)
    }

    public var nonce: [UInt8]? {
        return first(for: 0xA0)?.value
    }

    public var timestamp: Date? {
        guard let bytes = first(for: 0xA2)?.value else {
            return nil
        }

        return Date(bytes)
    }

    public var properties: AAProperties {
        return self
    }


    // MARK: Internal Vars

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

    var propertiesFailures: [AAPropertyFailure]? {
        return flatMap(for: 0xA5) {  AAPropertyFailure($0.value) }
    }

    var propertiesTimestamps: [AAPropertyTimestamp]? {
        return flatMap(for: 0xA4) { AAPropertyTimestamp($0.value) }
    }


    // MARK: Methods

    func filter(for identifier: AAPropertyIdentifier) -> [AABasicProperty] {
        return filter { $0.identifier == identifier }
    }

    func filter<Type: AAPropertyIdentifierGettable, ReturnType>(for propertyKeyPath: KeyPath<Type, ReturnType>) -> [AABasicProperty] {
        guard let identifier = Type.propertyID(for: propertyKeyPath) else {
            return []
        }

        return filter(for: identifier)
    }


    func first(for identifier: AAPropertyIdentifier) -> AABasicProperty? {
        return first(where: { $0.identifier == identifier })
    }

    func first<Type: AAPropertyIdentifierGettable, ReturnType>(for propertyKeyPath: KeyPath<Type, ReturnType>) -> AABasicProperty? {
        guard let identifier = Type.propertyID(for: propertyKeyPath) else {
            return nil
        }

        return first(for: identifier)
    }


    func flatMap<T>(for identifier: AAPropertyIdentifier, transform: (AABasicProperty) throws -> T?) rethrows -> [T]? {
        let filtered = filter(for: identifier)

        guard filtered.count > 0 else {
            return nil
        }

        return try filtered.compactMap(transform)
    }

    func flatMap<T, Type: AAPropertyIdentifierGettable, ReturnType>(for propertyKeyPath: KeyPath<Type, ReturnType>, transform: (AABasicProperty) throws -> T?) rethrows -> [T]? {
        guard let identifier = Type.propertyID(for: propertyKeyPath) else {
            return nil
        }

        return try flatMap(for: identifier, transform: transform)
    }
}
