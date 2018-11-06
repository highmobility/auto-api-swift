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
//  AAConditionBasedService.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 28/08/2018.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct AAConditionBasedService {

    public let date: Date
    public let description: String
    public let id: UInt16
    public let status: AADueStatus
    public let text: String
}

extension AAConditionBasedService: AABinaryInitable {

    init?<C>(_ binary: C) where C : Collection, C.Element == UInt8 {
        guard binary.count >= 9 else {
            return nil
        }

        // Gather some values
        let bytes = binary.bytes
        let year = bytes[0].int + 2000
        let month = bytes[1].int
        let id = UInt16(bytes[2...3])
        let textSize = UInt16(bytes[5...6]).int
        let descSize = UInt16(bytes[(7 + textSize) ... (8 + textSize)]).int

        guard let date = DateComponents(year: year, month: month).date,
            let status = AADueStatus(rawValue: bytes[4]) else {
                return nil
        }

        // Check there's enough bytes
        guard bytes.count == (9 + textSize + descSize) else {
            return nil
        }

        // Create strings
        let textBytes = bytes[7 ..< (7 + textSize)]
        let descBytes = bytes[(9 + textSize) ..< (9 + textSize + descSize)]

        guard let text = String(bytes: textBytes, encoding: .utf8),
            let description = String(bytes: descBytes, encoding: .utf8) else {
                return nil
        }

        // Set the iVars
        self.date = date
        self.id = id
        self.status = status
        self.text = text
        self.description = description
    }
}
