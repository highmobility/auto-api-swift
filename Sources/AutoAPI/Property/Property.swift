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
//  Property.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 23/11/2017.
//

import Foundation


public struct Property {

    public let identifier: UInt8
    public let size: UInt16
    public let value: [UInt8]

    public var bytes: [UInt8] {
        return [identifier] + size.bytes + value.bytes
    }

    
    var monoValue: UInt8? {
        return value.first
    }
}

extension Property: BinaryInitable {

    init?<C: Collection>(_ binary: C) where C.Element == UInt8 {
        guard binary.count >= 3 else {
            return nil
        }

        /*
         This is a workaround for a Swift Compiler problem/bug? that doesn't let to subscript with an Int.
         Which should work, as it inherits Comparable from (BinaryInteger -> Stridable).
         */
        let bytes = binary.bytes

        identifier = bytes[0]
        size = UInt16(bytes[1...2])

        guard binary.count == (3 + size) else {
            return nil
        }

        value = bytes.suffix(from: 3).bytes
    }
}

extension Property: CustomStringConvertible {

    public var description: String {
        let id = String(format: "0x%02X", identifier)
        let size = String(format: "%3d", self.size)
        let value = self.value.map { String(format: "%02X", $0) }.joined()

        return "id: " + id + ", size: " + size + ", val: 0x" + value
    }
}
