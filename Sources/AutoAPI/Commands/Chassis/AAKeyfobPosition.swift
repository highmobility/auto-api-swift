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
//  AAKeyfobPosition.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 12/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct AAKeyfobPosition: AAFullStandardCommand {

    public let relativePosition: AAKeyfobRelativePosition?


    // MARK: AAFullStandardCommand

    public let properties: AAProperties


    init?(properties: AAProperties) {
        // Ordered by the ID
        relativePosition = AAKeyfobRelativePosition(properties: properties, keyPath: \AAKeyfobPosition.relativePosition)

        // Properties
        self.properties = properties
    }
}

extension AAKeyfobPosition: AALegacyGettable {

    public struct Legacy: AALegacyType {

        public enum MessageTypes: UInt8, CaseIterable {

            case getKeyfobPosition  = 0x00
            case keyfobPosition     = 0x01
        }


        public init(properties: AAProperties) {

        }
    }
}

extension AAKeyfobPosition: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getPosition  = 0x00
        case position     = 0x01
    }
}

extension AAKeyfobPosition: AAIdentifiable {

    public static var identifier: AACommandIdentifier = 0x0048
}

extension AAKeyfobPosition: AAPropertyIdentifierGettable {

    static func propertyID(for keyPath: PartialKeyPath<AAKeyfobPosition>) -> AAPropertyIdentifier {
        switch keyPath {
        case \AAKeyfobPosition.relativePosition:    return 0x01

        default:
            return 0x00
        }
    }
}


// MARK: Commands

public extension AAKeyfobPosition {

    static var getKeyfobPosition: [UInt8] {
        return commandPrefix(for: .getPosition)
    }
}

public extension AAKeyfobPosition.Legacy {

    static var getKeyfobPosition: [UInt8] {
        return commandPrefix(for: AAKeyfobPosition.self, messageType: .getKeyfobPosition)
    }
}
