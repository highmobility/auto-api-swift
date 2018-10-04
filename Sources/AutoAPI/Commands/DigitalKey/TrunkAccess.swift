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
//  TrunkAccess.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 24/11/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct TrunkAccess: AAFullStandardCommand {

    public let lock: AALockState?
    public let position: AAPositionState?


    // MARK: AAFullStandardCommand

    public let properties: AAProperties


    init?(properties: AAProperties) {
        // Ordered by the ID
        lock = AALockState(rawValue: properties.first(for: 0x01)?.monoValue)
        position = AAPositionState(rawValue: properties.first(for: 0x02)?.monoValue)

        // Properties
        self.properties = properties
    }
}

extension TrunkAccess: AAIdentifiable {

    public static var identifier: AACommandIdentifier = AACommandIdentifier(0x0021)
}

extension TrunkAccess: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getState   = 0x00
        case state      = 0x01
        case setState   = 0x02
    }
}

public extension TrunkAccess {

    struct Settings {
        public let lock: AALockState?
        public let position: AAPositionState?

        public init(lock: AALockState?, position: AAPositionState?) {
            self.lock = lock
            self.position = position
        }
    }


    static var getState: [UInt8] {
        return commandPrefix(for: .getState)
    }

    static var openClose: (Settings) -> [UInt8] {
        return {
            let lockBytes: [UInt8] = $0.lock?.propertyBytes(0x01) ?? []
            let positionBytes: [UInt8] = $0.position?.propertyBytes(0x02) ?? []

            return commandPrefix(for: .setState) + lockBytes + positionBytes
        }
    }
}
