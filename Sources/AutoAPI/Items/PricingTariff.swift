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
//  PricingTariff.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 30/01/2018.
//

import Foundation


public struct PricingTariff: Item {

    public let type: PricingType
    public let currency: String
    public let price: Float


    // MARK: Item

    static var size: Int = 8


    // MARK: Init

    public init(type: PricingType, currency: String, price: Float) {
        self.type = type
        self.currency = currency
        self.price = price
    }
}

extension PricingTariff: BinaryInitable {

    init?(bytes: [UInt8]) {
        guard let type = PricingType(rawValue: bytes[0]) else {
            return nil
        }

        guard let currency = String(bytes: bytes[1..<4], encoding: .utf8) else {
            return nil
        }

        self.type = type
        self.currency = currency
        self.price = Float(bytes.suffix(from: 4))
    }
}

extension PricingTariff: Equatable {

    public static func ==(lhs: PricingTariff, rhs: PricingTariff) -> Bool {
        return (lhs.type == rhs.type) &&
            (lhs.currency == rhs.currency) &&
            (lhs.price == rhs.price)
    }
}

extension PricingTariff: PropertyConvertable {

    var propertyValue: [UInt8] {
        return [type.rawValue] + currency.propertyValue + price.propertyValue
    }
}
