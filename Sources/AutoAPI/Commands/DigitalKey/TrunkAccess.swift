//
// AutoAPI
// Copyright (C) 2017 High-Mobility GmbH
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
//  Copyright © 2017 High Mobility. All rights reserved.
//

import Foundation


public struct TrunkAccess: FullStandardCommand {

    public let lock: LockState?
    public let position: PositionState?


    // MARK: FullStandardCommand

    public let properties: Properties


    init?(properties: Properties) {
        // Ordered by the ID
        lock = LockState(rawValue: properties.first(for: 0x01)?.monoValue)
        position = PositionState(rawValue: properties.first(for: 0x02)?.monoValue)

        // Properties
        self.properties = properties
    }
}

extension TrunkAccess: Identifiable {

    public static var identifier: Identifier = Identifier(0x0021)
}

extension TrunkAccess: MessageTypesGettable {

    public enum MessageTypes: UInt8, MessageTypesType {

        case getTrunkState  = 0x00
        case trunkState     = 0x01
        case openCloseTrunk = 0x02


        public static let getState = MessageTypes.getTrunkState
        public static let state = MessageTypes.trunkState

        public static var all: [UInt8] {
            return [self.getTrunkState.rawValue,
                    self.trunkState.rawValue,
                    self.openCloseTrunk.rawValue]
        }
    }
}

public extension TrunkAccess {

    struct Settings {
        public let lock: LockState?
        public let position: PositionState?

        public init(lock: LockState?, position: PositionState?) {
            self.lock = lock
            self.position = position
        }
    }


    static var getTrunkState: [UInt8] {
        return getState
    }

    static var openClose: (Settings) -> [UInt8] {
        return {
            let lockBytes: [UInt8] = $0.lock?.propertyBytes(0x01) ?? []
            let positionBytes: [UInt8] = $0.position?.propertyBytes(0x02) ?? []

            return TrunkAccess.identifier.bytes + [MessageTypes.openCloseTrunk.rawValue] + lockBytes + positionBytes
        }
    }
}
