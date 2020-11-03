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
//  AAProperty.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 15.06.20.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation
import HMUtilities


public class AAProperty<ValueType>: AAOpaqueProperty where ValueType: HMBytesConvertable {

    public var opaque: AAOpaqueProperty {
        self as AAOpaqueProperty
    }

    public var value: ValueType? {
        ValueType(bytes: components.first(type: .data)?.value)
    }


    init?(id: UInt8, value: ValueType?, components: [AAPropertyComponent] = []) {
        guard let value = value else {
            return nil
        }

        let dataComponent = AAPropertyComponent(type: .data, value: value.bytes)
        let otherComponents = components.filter { $0.type != .data }

        super.init(id: id, components: [dataComponent] + otherComponents)
    }


    // MARK: AAOpaqueProperty

    public required init?(bytes: [UInt8]) {
        super.init(bytes: bytes)
    }
}

extension AAProperty {

    convenience init?<R>(id: R, value: ValueType?, components: [AAPropertyComponent] = []) where R: RawRepresentable, R.RawValue == UInt8 {
        self.init(id: id.rawValue, value: value, components: components)
    }
}
