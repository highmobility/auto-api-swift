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
//  AASDKVersion.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 28/11/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct AASDKVersion {

    public let major: UInt8
    public let minor: UInt8
    public let patch: UInt8

    public var string: String {
        return "\(major).\(minor).\(patch)"
    }
}

extension AASDKVersion: AAItem {

    static var size: Int = 3


    init?(bytes: [UInt8]) {
        major = bytes.bytes[0]
        minor = bytes.bytes[1]
        patch = bytes.bytes[2]
    }
}

extension AASDKVersion: AAPropertyConvertable {

    var propertyValue: [UInt8] {
        return [major, minor, patch]
    }
}
