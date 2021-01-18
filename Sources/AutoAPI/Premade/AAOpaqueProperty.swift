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
//  AAOpaqueProperty.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 15.06.20.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation
import HMUtilities


public class AAOpaqueProperty: Encodable, HMBytesConvertable {

    let components: [AAPropertyComponent]
    

    public var id: UInt8 {
        bytes[0]
    }

    public var valueBytes: [UInt8]? {
        components.first(type: .data)?.value
    }


    func property<P>() -> AAProperty<P>? where P: HMBytesConvertable {
        AAProperty(id: id, value: P(bytes: valueBytes), components: components)
    }


    init(id: UInt8, components: [AAPropertyComponent]) {
        let componentBytes = components.flatMap { $0.bytes }

        self.bytes = id.bytes + componentBytes.sizeBytes(amount: 2) + componentBytes
        self.components = components
    }


    // MARK: HMBytesConvertable

    public let bytes: [UInt8]


    public required init?(bytes: [UInt8]) {
        guard bytes.count >= 3 else {
            return nil
        }

        let size = 3 + Int(UInt16(bytes: bytes[1...2])!)

        guard bytes.count >= size else {
            return nil
        }

        self.bytes = bytes.prefix(size).bytes
        self.components = self.bytes.suffix(from: 3).bytes.generatePropertyComponents()
    }
}
