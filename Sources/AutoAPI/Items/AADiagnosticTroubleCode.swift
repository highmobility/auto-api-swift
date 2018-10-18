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
//  AADiagnosticTroubleCode.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 18/10/2018.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct AADiagnosticTroubleCode {

    public let ecuID: String
    public let id: String
    public let occurences: UInt8
    public let status: String
}

extension AADiagnosticTroubleCode: AAItemDynamicSize {

    static var greaterOrEqualSize: Int = 3


    init?(bytes: [UInt8]) {
        let minSize = AADiagnosticTroubleCode.greaterOrEqualSize
        let occurences = bytes[0]
        let idSize = bytes[1].int
        let ecuIDSize = bytes[2].int

        // Check the byte count
        guard bytes.count >= (minSize + idSize + ecuIDSize) else {
            return nil
        }

        // Get strings' bytes
        let idBytes = bytes[minSize ..< (minSize + idSize)]
        let ecuIDBytes = bytes[(minSize + idSize) ..< (minSize + idSize + ecuIDSize)]
        let statusBytes = bytes.dropFirstBytes(minSize + idSize + ecuIDSize)

        // Create the strings
        guard let id = String(bytes: idBytes, encoding: .utf8),
            let ecuID = String(bytes: ecuIDBytes, encoding: .utf8),
            let status = String(bytes: statusBytes, encoding: .utf8) else {
                return nil
        }

        self.ecuID = ecuID
        self.id = id
        self.occurences = occurences
        self.status = status
    }
}

extension AADiagnosticTroubleCode: AAPropertyConvertable {

    var propertyValue: [UInt8] {
        let idBytes = id.propertyValue
        let ecuIDBytes = ecuID.propertyValue

        return [occurences, idBytes.count.uint8, ecuIDBytes.count.uint8] +
            idBytes +
            ecuIDBytes +
            status.propertyValue
    }
}
