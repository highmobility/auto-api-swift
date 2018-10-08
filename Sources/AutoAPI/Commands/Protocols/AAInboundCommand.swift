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
//  AAInboundCommand.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 14/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


protocol AAInboundCommand: AACommand, AABinaryInitable, AAMessageTypesGettable, AAPropertiesCapable, AAPropertiesTimestampGettable, AAPropertyIdentifierGettable {

    init?(_ messageType: UInt8, properties: AAProperties)
}

extension AAInboundCommand {

    // MARK: AABinaryInitable

    init?<C>(_ binary: C) where C : Collection, C.Element == UInt8 {
        guard binary.count >= 3 else {
            return nil
        }

        guard AACommandIdentifier(binary) == Self.identifier else {
            return nil
        }

        let messageType = binary.bytes[2]
        let properties = AAProperties(binary.dropFirstBytes(3))

        self.init(messageType, properties: properties)
    }


    // MARK: AAPropertiesCapable

    public var carSignature: [UInt8]? {
        return properties.carSignature
    }

    public var milliseconds: TimeInterval? {
        return properties.milliseconds
    }

    public var nonce: [UInt8]? {
        return properties.nonce
    }

    public var timestamp: Date? {
        return properties.timestamp
    }

    public var propertiesTimestamps: [AAPropertyTimestamp]? {
        return properties.propertiesTimestamps
    }

    /// Retrieve the `AAPropertyTimestamp` value for a specific property,
    /// if there is one.
    ///
    /// To retrieve a timestamp for a property in an *array*,
    /// the specific *value* needs to be supplied as well.
    ///
    /// - Parameters:
    ///   - keyPath: The property's (variable's) `PartialKeyPath`
    ///   - property: If the property (variable) represent an *array*, this needs to include the **specific** value (i.e. a specific door).
    /// - Returns: `AAPropertyTimestamp` that has the *date* for a given property.
    public func propertyTimestamp<Type>(for keyPath: KeyPath<Self, Type>, specificProperty property: Any?) -> AAPropertyTimestamp? {
        if let property = property as? AAPropertyConvertable {
            return propertiesTimestamps?.first {
                ($0.propertyID == Self.propertyID(for: keyPath)) &&
                ($0.propertyFullValue == property.propertyValue)
            }
        }
        else {
            return propertiesTimestamps?.first(for: Self.propertyID(for: keyPath))
        }
    }
}
