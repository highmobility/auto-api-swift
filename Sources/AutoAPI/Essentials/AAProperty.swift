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
//  AAProperty.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/07/2019.
//  Copyright © 2019 High-Mobility. All rights reserved.
//

import Foundation


public class AAProperty<ValueType>: AAOpaqueProperty where ValueType: AABytesConvertable {

    public let value: ValueType?


    static func multiple<R>(identifier: R, values: [ValueType]?) -> [AAProperty<ValueType>] where R: RawRepresentable, R.RawValue == UInt8 {
        values?.map { AAProperty(identifier: identifier, value: $0) } ?? []
    }


    func transformValue<T>(transform: (ValueType?) -> T?) -> AAProperty<T>? {
        AAProperty<T>(identifier: identifier, value: transform(value), components: components)
    }


    init(identifier: AAPropertyIdentifier, value: ValueType?, components: [AAPropertyComponent] = []) {
        // TODO: Change this to be a failable init

        guard let value = value else {
            self.value = nil
            super.init(bytes: identifier.bytes + [0x00, 0x00])!

            return
        }

        // This will replace the data component
        let dataComponent = AAPropertyComponent(type: .data, value: value.bytes)
        let otherComponentsBytes = components.filter { $0.type != .data }.flatMap { $0.bytes }
        let componentsBytes = dataComponent.bytes + otherComponentsBytes
        let size = componentsBytes.count.sizeBytes(amount: 2)

        self.value = value

        super.init(bytes: identifier.bytes + size + componentsBytes)!
    }

    convenience init<R>(identifier: R, value: ValueType?, components: [AAPropertyComponent] = []) where R: RawRepresentable, R.RawValue == UInt8 {
        self.init(identifier: identifier.rawValue, value: value, components: components)
    }


    // MARK: AAOpaqueProperty

    public required init?(bytes: [UInt8]) {
        guard bytes.count >= 3 else {
            return nil
        }

        let components = bytes.suffix(from: 3).generatePropertyComponents()

        value = ValueType(bytes: components.first { $0.type == .data }?.value)

        super.init(bytes: bytes)
    }
}
