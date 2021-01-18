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
//  AAPropertyComponent.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 15.06.20.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation
import HMUtilities


struct AAPropertyComponent: Encodable, HMBytesConvertable {

    let type: AAPropertyComponentType

    var value: [UInt8] {
        bytes.suffix(from: 3).bytes
    }


    init(type: AAPropertyComponentType, value: [UInt8]) {
        self.bytes = type.bytes + value.sizeBytes(amount: 2) + value
        self.type = type
    }


    // MARK: HMBytesConvertable

    let bytes: [UInt8]


    init?(bytes: [UInt8]) {
        guard bytes.count >= 3 else {
            return nil
        }

        let size = 3 + Int(UInt16(bytes: bytes[1...2])!)

        guard bytes.count >= size,
            let type = AAPropertyComponentType(rawValue: bytes[0]) else {
                return nil
        }

        self.bytes = bytes.prefix(upTo: size).bytes
        self.type = type
    }
}
