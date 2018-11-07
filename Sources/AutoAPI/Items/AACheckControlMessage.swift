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
//  AACheckControlMessage.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 28/08/2018.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct AACheckControlMessage {

    public let id: UInt16
    public let remainingMinutes: UInt32
    public let status: String
    public let text: String
}

extension AACheckControlMessage: AAItemDynamicSize {

    static var greaterOrEqualSize: Int = 9


    init?(bytes: [UInt8]) {
        let id = UInt16(bytes[0...1])
        let remainingMinutes = UInt32(bytes[2...5])
        let textSize = UInt16(bytes[6...7]).int

        // Need to check to prevent a crash
        guard bytes.count >= (8 + textSize) else {
            return nil
        }

        let statusSize = bytes[8 + textSize].int

        // Check for enough bytes
        guard bytes.count == (9 + textSize + statusSize) else {
            return nil
        }

        let textBytes = bytes[8 ..< (8 + textSize)]
        let statusBytes = bytes[(9 + textSize) ..< (9 + textSize + statusSize)]

        // Create strings
        guard let text = String(bytes: textBytes, encoding: .utf8),
            let status = String(bytes: statusBytes, encoding: .utf8) else {
                return nil
        }

        // Set the iVars
        self.id = id
        self.remainingMinutes = remainingMinutes
        self.status = status
        self.text = text
    }
}

extension AACheckControlMessage: AAPropertyConvertable {

    var propertyValue: [UInt8] {
        var textBytes = text.propertyValue
        var statusBytes = status.propertyValue

        textBytes.insert(contentsOf: UInt16(textBytes.count).bytes, at: 0)
        statusBytes.insert(statusBytes.count.uint8, at: 0)

        return id.bytes + remainingMinutes.bytes + textBytes + statusBytes
    }
}
