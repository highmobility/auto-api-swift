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
//  AAWindows.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 01/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct AAWindows: AAFullStandardCommand {

    public let openPercentages: [AAWindowOpenPercentage]?
    public let positions: [AAWindowPosition]?


    // MARK: AAFullStandardCommand

    public let properties: AAProperties


    init?(properties: AAProperties) {
        // Ordered by the ID
        /* Level 8 */
        openPercentages = properties.flatMap(for: \AAWindows.openPercentages) { AAWindowOpenPercentage($0.value) }
        positions = properties.flatMap(for: \AAWindows.positions) { AAWindowPosition($0.value) }

        // Properties
        self.properties = properties
    }
}

extension AAWindows: AAIdentifiable {

    public static var identifier: AACommandIdentifier = 0x0045
}

extension AAWindows: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getWindowsState    = 0x00
        case windowsState       = 0x01
        case control            = 0x12
    }
}

extension AAWindows: AAPropertyIdentifierGettable {

    static func propertyID<Type>(for keyPath: KeyPath<AAWindows, Type>) -> AAPropertyIdentifier {
        switch keyPath {
        case \AAWindows.openPercentages:    return 0x02
        case \AAWindows.positions:          return 0x03

        default:
            return 0x00
        }
    }
}

public extension AAWindows {

    static var getWindowsState: [UInt8] {
        return commandPrefix(for: .getWindowsState)
    }


    static func controlWindows(openPercentages: [AAWindowOpenPercentage]?, positions: [AAWindowPosition]?) -> [UInt8] {
        return commandPrefix(for: .control) + [openPercentages?.reduceToByteArray { $0.propertyBytes(0x01) },
                                               positions?.reduceToByteArray { $0.propertyBytes(0x02) }].propertiesValuesCombined
    }
}
