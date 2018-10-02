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
//  AAPricingTariff.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 30/01/2018.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct AAPricingTariff {

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

extension AAPricingTariff: AAItemDynamicSize {

    static var greaterOrEqualSize: Int = 8
    

    init?(bytes: [UInt8]) {
        guard let type = AAPricingType(rawValue: bytes[0]),
            let currency = String(bytes: bytes.suffix(from: 5), encoding: .utf8) else {
                return nil
        }

        self.type = type
        self.price = Float(bytes[1 ... 4])
        self.currency = currency
    }
}

extension AAPricingTariff: Equatable {

    public static func ==(lhs: AAPricingTariff, rhs: AAPricingTariff) -> Bool {
        return (lhs.type == rhs.type) &&
            (lhs.currency == rhs.currency) &&
            (lhs.price == rhs.price)
    }
}

extension AAPricingTariff: AAPropertyConvertable {

    var propertyValue: [UInt8] {
        return [type.rawValue] + price.propertyValue + currency.propertyValue
    }
}
