//
// AutoAPI
// Copyright (C) 2018 High-Mobility GmbH
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
//  Created by Mikk Rätsep on 30/01/2018.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct AAPriceTariff {

    public let currency: String
    public let price: Float
    public let type: AAPricingType


    // MARK: Init

    public init(currency: String, price: Float, type: AAPricingType) {
        self.currency = currency
        self.price = price
        self.type = type
    }
}

extension AAPriceTariff: AAItemDynamicSize {

    static var greaterOrEqualSize: Int = 6
    

    init?(bytes: [UInt8]) {
        let currencySize = bytes[5].int

        // Check the byte count
        guard bytes.count == (6 + currencySize) else {
            return nil
        }

        guard let type = AAPricingType(rawValue: bytes[0]),
            let currency = String(bytes: bytes[6 ..< (6 + currencySize)], encoding: .utf8) else {
                return nil
        }

        self.type = type
        self.price = Float(bytes[1 ... 4])
        self.currency = currency
    }
}

extension AAPriceTariff: Equatable {

    public static func ==(lhs: AAPriceTariff, rhs: AAPriceTariff) -> Bool {
        return (lhs.type == rhs.type) &&
            (lhs.currency == rhs.currency) &&
            (lhs.price == rhs.price)
    }
}

extension AAPriceTariff: AAPropertyConvertable {

    var propertyValue: [UInt8] {
        return [type.rawValue] + price.propertyValue + [currency.propertyValue.count.uint8] + currency.propertyValue
    }
}


public struct AALegacyPricingTariff: AAItem {

    public let type: AAPricingType
    public let currency: String
    public let price: Float


    // MARK: Item

    static var size: Int = 8


    // MARK: Init

    public init(type: AAPricingType, currency: String, price: Float) {
        self.type = type
        self.currency = currency
        self.price = price
    }
}

extension AALegacyPricingTariff: AABinaryInitable {

    init?(bytes: [UInt8]) {
        guard let type = AAPricingType(rawValue: bytes[0]) else {
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

extension AALegacyPricingTariff: Equatable {

    public static func ==(lhs: AALegacyPricingTariff, rhs: AALegacyPricingTariff) -> Bool {
        return (lhs.type == rhs.type) &&
            (lhs.currency == rhs.currency) &&
            (lhs.price == rhs.price)
    }
}

extension AALegacyPricingTariff: AAPropertyConvertable {

    var propertyValue: [UInt8] {
        return [type.rawValue] + currency.propertyValue + price.propertyValue
    }
}
