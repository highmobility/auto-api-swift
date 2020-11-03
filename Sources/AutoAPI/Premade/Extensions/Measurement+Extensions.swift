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
//  Measurement+Extensions.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 15.06.20.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation
import HMUtilities


extension Measurement: HMBytesConvertable where UnitType: AAUnitType {

    public var bytes: [UInt8] {
        if let ids = unit.identifiers {
            return ids + value.bytes
        }
        else {
            return converted(to: type(of: unit).baseUnit() ).bytes
        }
    }

    public init?(bytes: [UInt8]) {
        guard bytes.count >= 10 else {
            return nil
        }

        let msrByte = bytes[0]
        let unitByte = bytes[1]
        let valBytes = bytes[2..<10]

        guard let val = Double(bytes: valBytes),
            let msrType = AAMeasurement.types.first(where: { $0.measurementID == msrByte }),
            let unit = msrType.create(id: unitByte) else {
                return nil
        }

        self = Measurement(value: val, unit: unit as! UnitType)
    }
}
