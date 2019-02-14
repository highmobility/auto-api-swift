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
//  AAItem.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 01/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation
import HMUtilities


//protocol AAItem: AABinaryInitable {
//
//    static var size: Int { get }
//
//
//    init?(bytes: [UInt8]?)
//}
//
//extension AAItem {
//
//    init?<C>(_ binary: C) where C : Collection, C.Element == UInt8 {
//        guard binary.count == Self.size else {
//            return nil
//        }
//
//        self.init(bytes: binary.bytes)
//    }
//
//    init?(bytes: [UInt8]?) {
//        guard let bytes = bytes else {
//            return nil
//        }
//
//        self.init(bytes: bytes)
//    }
//}
//
//
//protocol AAItemDynamicSize: AAItem {
//
//    static var greaterOrEqualSize: Int { get }
//}
//
//extension AAItemDynamicSize {
//
//    static var size: Int {
//        return greaterOrEqualSize
//    }
//
//
//    init?<C>(_ binary: C) where C : Collection, C.Element == UInt8 {
//        guard binary.count >= Self.size else {
//            return nil
//        }
//
//        self.init(bytes: binary.bytes)
//    }
//}
