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
//  AAPriceTariff.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation


/// Price tariff
public struct AAPriceTariff: AABytesConvertable, Equatable {

    /// Pricing type
    public enum PricingType: UInt8, AABytesConvertable {
        case startingFee = 0x00
        case perMinute = 0x01
        case perKwh = 0x02
    }


    /// Pricing type
    public let pricingType: PricingType

    /// The currency alphabetic code per ISO 4217 or crypto currency symbol
    public let currency: String

    /// The price
    public let price: Float


    /// Initialise `AAPriceTariff` with parameters.
    ///
    /// - parameters:
    ///   - pricingType: Pricing type as `PricingType`
    ///   - price: The price as `Float`
    ///   - currency: The currency alphabetic code per ISO 4217 or crypto currency symbol as `String`
    public init(pricingType: PricingType, price: Float, currency: String) {
        var bytes: Array<UInt8> = []
    
        bytes += pricingType.bytes
        bytes += price.bytes
        bytes += currency.bytes.count.sizeBytes(amount: 2) + currency.bytes
    
        self.bytes = bytes
        self.pricingType = pricingType
        self.price = price
        self.currency = currency
    }


    // MARK: AABytesConvertable
    
    /// `AAPriceTariff` bytes
    ///
    /// - returns: Bytes of `AAPriceTariff` in `Array<UInt8>`
    public let bytes: Array<UInt8>
    
    
    /// Initialise `AAPriceTariff` with bytes.
    ///
    /// - parameters:
    ///   - bytes: Array of bytes in `Array<UInt8>`
    public init?(bytes: Array<UInt8>) {
        guard bytes.count >= 7 else {
            return nil
        }
    
        guard let pricingType = PricingType(bytes: bytes[0..<1]),
            let price = Float(bytes: bytes[1..<5]),
            let currency = bytes.extractString(startingIdx: 5) else {
                return nil
        }
    
        self.bytes = bytes
        self.pricingType = pricingType
        self.price = price
        self.currency = currency
    }
}