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

extension AAPriceTariff: AABytesConvertable {

    public var bytes: [UInt8] {
        return type.bytes + price.bytes + currency.bytes.count.uint8.bytes + currency.bytes
    }
    

    public init?(bytes: [UInt8]) {
        guard bytes.count >= 6 else {
            return nil
        }

        let currencySize = bytes[5].int

        // Check the byte count
        guard bytes.count == (6 + currencySize) else {
            return nil
        }

        guard let type = AAPricingType(bytes: bytes[0..<1]),
            let price = Float(bytes: bytes[1...4]),
            let currency = String(bytes: bytes[6..<(6 + currencySize)]) else {
                return nil
        }

        self.type = type
        self.price = price
        self.currency = currency
    }
}

extension AAPriceTariff: Equatable {

}
