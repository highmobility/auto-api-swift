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
//  AAPropertyTimestamp.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 04/10/2018.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct AAPropertyTimestamp {

    public let date: Date
    public let propertyID: AAPropertyIdentifier

    let propertyFullValue: [UInt8]
}

extension AAPropertyTimestamp: AAItemDynamicSize {

    static var greaterOrEqualSize: Int = 9


    var bytes: [UInt8] {
        return date.propertyValue + [propertyID] + propertyFullValue
    }


    init?(bytes: [UInt8]) {
        guard let date = Date(bytes[0...7]) else {
            return nil
        }

        self.date = date
        self.propertyID = bytes[8]
        self.propertyFullValue = bytes.suffix(from: 9).bytes
    }
}

extension AAPropertyTimestamp: AAPropertyConvertable {

    var propertyValue: [UInt8] {
        return date.propertyValue + [propertyID] + propertyFullValue
    }
}
