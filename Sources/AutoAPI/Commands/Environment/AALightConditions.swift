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
//  AALightConditions.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 07/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct AALightConditions: AAFullStandardCommand {

    /// Value in *lux*.
    public let insideLight: AAProperty<Float>?

    /// Value in *lux*.
    public let outsideLight: AAProperty<Float>?


    // MARK: AAFullStandardCommand

    public let properties: AAProperties


    init?(properties: AAProperties) {
        // Ordered by the ID
        outsideLight = properties.property(for: \AALightConditions.outsideLight)
        insideLight = properties.property(for: \AALightConditions.insideLight)

        // Properties
        self.properties = properties
    }
}

extension AALightConditions: AAIdentifiable {

    public static var identifier: AACommandIdentifier = 0x0054
}

extension AALightConditions: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getConditions  = 0x00
        case conditions     = 0x01
    }
}

extension AALightConditions: AAPropertyIdentifierGettable {

    static func propertyID<Type>(for keyPath: KeyPath<AALightConditions, Type>) -> AAPropertyIdentifier? {
        switch keyPath {
        case \AALightConditions.outsideLight:   return 0x01
        case \AALightConditions.insideLight:    return 0x02

        default:
            return nil
        }
    }
}

public extension AALightConditions {

    static var getConditions: [UInt8] {
        return commandPrefix(for: .getConditions)
    }
}
