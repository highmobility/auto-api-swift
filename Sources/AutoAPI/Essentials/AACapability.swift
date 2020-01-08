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
//  AACapability.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/07/2019.
//  Copyright © 2019 High-Mobility. All rights reserved.
//

import Foundation
import HMUtilities


/// Hello my love.
///
/// This "master"-class shouldn't be used directly.
///
/// Subclasses **need** to override the `identifier`.
public class AACapability: AABytesConvertable, AAIdentifiable, AADebugTreeCapable {

    let properties: [AAOpaqueProperty]


    // MARK: AABytesConvertable

    public var bytes: [UInt8] {
        AAAutoAPI.protocolVersion.bytes +
        Self.identifier.bytes +
        AACommandType.set.rawValue.bytes +
        properties.flatMap { $0.bytes }
    }


    public required init?(bytes: [UInt8]) {
        guard bytes.count >= 4,
            bytes[3] == AACommandType.set.rawValue else {
                return nil
        }

        // Check the ID
        let id = UInt16(bytes: bytes[1...2])!

        guard Self.identifier == id else {
            return nil
        }

        self.properties = bytes.suffix(from: 4).generateProperties()
    }


    // MARK: AAIdentifiable

    public class var identifier: AACapabilityIdentifier {
        0x0000
    }


    // MARK: AADebugTreeCapable

    public var debugTree: HMDebugTree {
        .node(label: "\(type(of: self))", nodes: propertyNodes)
    }

    public var propertyNodes: [HMDebugTree] {
        []
    }
}


private extension Collection where Element == UInt8 {
    
    func generateProperties() -> [AAOpaqueProperty] {
        var bytes = self.bytes
        var properties: [AAOpaqueProperty] = []

        while let property = AAOpaqueProperty(bytes: bytes) {
            bytes.removeFirst(property.bytes.count)
            properties.append(property)
        }

        return properties
    }
}
