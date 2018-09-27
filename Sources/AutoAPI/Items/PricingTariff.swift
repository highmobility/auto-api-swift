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
//  PricingTariff.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 30/01/2018.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct PricingTariff: AAItem {

    public let type: PricingType
    public let currency: String
    public let price: Float


    // MARK: AAItem

    static var size: Int = 8


    // MARK: Init

    public init(type: PricingType, currency: String, price: Float) {
        self.type = type
        self.currency = currency
        self.price = price
    }
}

extension PricingTariff: AABinaryInitable {

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

extension PricingTariff: AAPropertyConvertable {

    var propertyValue: [UInt8] {
        return [type.rawValue] + currency.propertyValue + price.propertyValue
    }
}
