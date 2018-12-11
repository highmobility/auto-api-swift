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
//  AAPropertyFailure.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 11/12/2018.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct AAPropertyFailure {

    public let propertyID: UInt8
    public let failureReason: AAPropertyFailureReason
    public let description: String
}

extension AAPropertyFailure: AAItemDynamicSize {

    static var greaterOrEqualSize: Int = 3


    init?(bytes: [UInt8]) {
        let descriptionSize = bytes[2].int

        guard bytes.count == (AAPropertyFailure.greaterOrEqualSize + descriptionSize) else {
            return nil
        }

        guard let reason = AAPropertyFailureReason(rawValue: bytes[1]),
            let description = String(bytes: bytes.suffix(from: 4), encoding: .utf8) else {
                return nil
        }

        self.propertyID = bytes[0]
        self.failureReason = reason
        self.description = description
    }
}

extension AAPropertyFailure: AAPropertyConvertable {

    var propertyValue: [UInt8] {
        let descriptionBytes = description.data(using: .utf8)?.bytes ?? []

        return [propertyID, failureReason.rawValue, descriptionBytes.count.uint8] + descriptionBytes
    }
}
