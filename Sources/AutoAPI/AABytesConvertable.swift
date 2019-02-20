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
//  AABytesConvertable.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 17/02/2019.
//  Copyright © 2019 High Mobility GmbH. All rights reserved.
//

import Foundation
import HMUtilities


public protocol AABytesConvertable: HMBytesConvertable {

}

extension AABytesConvertable {

    func property(forIdentifier identifier: AAPropertyIdentifier) -> AAProperty<Self>? {
        return AAProperty(identifier: identifier, value: self)
    }
}


// Decimals
extension Float: AABytesConvertable {

}

extension Double: AABytesConvertable {

}

// Unsigned ints
extension UInt: AABytesConvertable {

}

extension UInt8: AABytesConvertable {

}

extension UInt16: AABytesConvertable {

}

extension UInt32: AABytesConvertable {

}

extension UInt64: AABytesConvertable {

}

// Signed ints
extension Int: AABytesConvertable {

}

extension Int8: AABytesConvertable {

}

extension Int16: AABytesConvertable {

}

extension Int32: AABytesConvertable {

}

extension Int64: AABytesConvertable {

}

// Others
extension Date: AABytesConvertable {

}

extension String: AABytesConvertable {

}

extension URL: AABytesConvertable {
    
}
