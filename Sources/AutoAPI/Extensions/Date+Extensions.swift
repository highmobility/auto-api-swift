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


extension Date: AABinaryInitable {

    // TODO: Convert to our own byte-implementation
    init?<C>(_ binary: C) where C : Collection, C.Element == UInt8 {
        guard let string = String(bytes: binary, encoding: .utf8) else {
            return nil
        }

        // TODO: create a Linux implementation (probably not implemented there yet)
        #if os(Linux)
            return nil
        #endif

        guard let date = ISO8601DateFormatter().date(from: string) else {
            return nil
        }

        self = date
    }
}

extension Date: AAPropertyConvertable {

    // TODO: Convert to our own byte-implementation
    var propertyValue: [UInt8] {
        // TODO: Make the propertyValue Optional to avoid this stuff
        return ISO8601DateFormatter().string(from: self).data(using: .utf8)?.bytes ?? []
    }
}
