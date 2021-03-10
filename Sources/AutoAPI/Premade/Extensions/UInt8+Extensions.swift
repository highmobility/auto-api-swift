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
//  UInt8+Extensions.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 11.06.20.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation
import HMUtilities


extension Array where Element == UInt8 {

    func extract(bytesFrom idx: Int) -> [UInt8]? {
        guard count >= (idx + 1) else {
            return nil
        }

        // UInt16 initialiser can't create an invalid value with 2 bytes
        let size = Int(UInt16(bytes: self[idx ... (idx + 1)].bytes)!)

        guard count >= (idx + 2 + size) else {
            return nil
        }

        return self[(idx + 2) ..< (idx + 2 + size)].bytes
    }

    func extract(stringFrom idx: Int) -> String? {
        guard let bytes = extract(bytesFrom: idx) else {
            return nil
        }

        return String(bytes: bytes)
    }


    func generateProperties() -> [AAOpaqueProperty] {
        var bytes = self
        var properties: [AAOpaqueProperty] = []

        while let property = AAOpaqueProperty(bytes: bytes) {
            bytes.removeFirst(property.bytes.count)
            properties.append(property)
        }

        return properties
    }

    func generatePropertyComponents() -> [AAPropertyComponent] {
        var bytes = self
        var components: [AAPropertyComponent] = []

        while let component = AAPropertyComponent(bytes: bytes) {
            bytes.removeFirst(component.bytes.count)
            components.append(component)
        }

        return components
    }


    func sizeBytes(amount: Int) -> [UInt8] {
        (0..<amount).map {
            (self.count >> ($0 * 8)).uint8
        }.reversed()
    }
}


extension Array: HMBytesConvertable where Element == UInt8 {

    public var bytes: [UInt8] {
        flatMap(\.bytes)
    }


    public init?(bytes: [UInt8]) {
        self = Array(bytes)
    }
}
