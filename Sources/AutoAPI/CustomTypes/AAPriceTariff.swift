//
// AutoAPI
// Copyright (C) 2020 High-Mobility GmbH
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program. If not, see http://www.gnu.org/licenses/.
//
// Please inquire about commercial licensing options at
// licensing@high-mobility.com
//
//
//  AAPriceTariff.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
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