//
// AutoAPI
// Copyright (C) 2019 High-Mobility GmbH
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
//  Copyright © 2019 High Mobility GmbH. All rights reserved.
//

import Foundation


public struct AAPropertyFailure {

    public let reason: AAPropertyFailureReason
    public let description: String
}

extension AAPropertyFailure: AABytesConvertable {

    public var bytes: [UInt8] {
        return reason.bytes + description.bytes.count.sizeBytes(amount: 2) + description.bytes
    }


    public init?(bytes: [UInt8]) {
        guard bytes.count >= 3 else {
            return nil
        }

        // Int initialiser can't create an invalid value with 2 bytes
        let descriptionSize = Int(bytes: bytes[1...2])!

        guard bytes.count == (3 + descriptionSize) else {
            return nil
        }

        guard let reason = AAPropertyFailureReason(bytes: bytes[0..<1]),
            let description = String(bytes: bytes[3..<(3 + descriptionSize)], encoding: .utf8) else {
                return nil
        }

        self.reason = reason
        self.description = description
    }
}

extension AAPropertyFailure: Equatable {

    public static func ==(lhs: AAPropertyFailure, rhs: AAPropertyFailure) -> Bool {
        return lhs.bytes == rhs.bytes
    }
}
