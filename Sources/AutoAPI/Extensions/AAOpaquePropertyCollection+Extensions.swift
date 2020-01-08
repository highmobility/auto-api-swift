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
//  AAOpaquePropertyCollection+Extensions.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 18/09/2019.
//  Copyright © 2019 High-Mobility. All rights reserved.
//

import Foundation


extension Collection where Element == AAOpaqueProperty {

    func property<R, B>(forID id: R) -> AAProperty<B>? where R: RawRepresentable, R.RawValue == UInt8, B: AABytesConvertable {
        first { $0.identifier == id.rawValue }?.property()
    }

    func properties<R, B>(forID id: R) -> [AAProperty<B>]? where R: RawRepresentable, R.RawValue == UInt8, B: AABytesConvertable {
        let properties: [AAProperty<B>] = filter { $0.identifier == id.rawValue }.compactMap { $0.property() }

        return properties.isEmpty ? nil : properties
    }
}
