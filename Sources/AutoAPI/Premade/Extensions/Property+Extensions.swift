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
//  Property+Extensions.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 01.07.20.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation
import HMUtilities


extension Collection where Element == AAOpaqueProperty {

    func property<R, P>(id: R) -> AAProperty<P>? where P: HMBytesConvertable, R: RawRepresentable, R.RawValue == UInt8 {
        first { $0.id == id.rawValue }?.property()
    }

    func properties<R, P>(id: R) -> [AAProperty<P>]? where P: HMBytesConvertable, R: RawRepresentable, R.RawValue == UInt8 {
        let properties: [AAProperty<P>] = filter { $0.id == id.rawValue }.compactMap { $0.property() }

        return properties.isEmpty ? nil : properties
    }
}

extension Collection where Element == AAPropertyComponent {

    func first(type: AAPropertyComponentType) -> AAPropertyComponent? {
        first { $0.type == type }
    }
}
