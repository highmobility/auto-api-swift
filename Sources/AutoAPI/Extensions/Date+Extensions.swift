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
//  Date+Extensions.swift
//  AutoAPICLT
//
//  Created by Mikk Rätsep on 07/09/2018.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


extension Date: AABytesConvertable {

    public var bytes: [UInt8] {
        return UInt64(timeIntervalSince1970 * 1e3).bytes
    }


    public init?(bytes: [UInt8]) {
        guard bytes.count == 8 else {
            return nil
        }

        guard let uint64 = UInt64(bytes: bytes) else {
            return nil
        }

        self.init(timeIntervalSince1970: TimeInterval(uint64) * 1e3)
    }
}
