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
//  Created by Mikk Rätsep on 12/02/2019.
//  Copyright © 2019 High Mobility GmbH. All rights reserved.
//

import Foundation


public class AAProperty<ValueType>: AABasicProperty where ValueType: AABytesConvertable {

    public var value: ValueType? {
        guard let valueBytes = valueBytes else {
            return nil
        }

        return ValueType(bytes: valueBytes)
    }


    // MARK: Init

    init?(identifier: AAPropertyIdentifier, value: ValueType) {
        let dataComponent = AAPropertyComponent(type: .data, value: value.bytes)
        let size = dataComponent.bytes.count.sizeBytes(amount: 2)

        super.init(bytes: [identifier] + size + dataComponent.value)
    }

    required init?(bytes: [UInt8]) {
        super.init(bytes: bytes)
    }
}

extension AAProperty: CustomStringConvertible {

    public var description: String {
        var description = "\(type(of: self))"

        description += ", id: 0x\(identifier.bytes.hex)"
        description += ", failure: \(String(describing: failure))"
        description += ", timestamp: \(String(describing: timestamp))"

        // Done so because "String(describing: value)" still produces an optional here
        if let value = value {
            description += ", value: \(String(describing: value))"
        }
        else {
            description += ", value: nil"
        }

        return description
    }
}
