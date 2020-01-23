//
//  The MIT License
//
//  Copyright (c) 2014- High-Mobility GmbH (https://high-mobility.com)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//
//
//  Properties.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 24/11/2017.
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
