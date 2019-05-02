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
//  AADoorLocks.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 24/11/2017.
//  Copyright © 2019 High Mobility GmbH. All rights reserved.
//

import Foundation


public class AADoorLocks: AACapabilityClass, AACapability {

    public let insideLocks: [AAProperty<AADoorLock>]?
    public let locks: [AAProperty<AADoorLock>]?
    public let positions: [AAProperty<AADoorPosition>]?


    // MARK: AACapability

    public static var identifier: AACapabilityIdentifier = 0x0020


    required init(properties: AAProperties) {
        // Ordered by the ID
        /* Level 8 */
        insideLocks = properties.allOrNil(forIdentifier: 0x02)
        locks = properties.allOrNil(forIdentifier: 0x03)
        positions = properties.allOrNil(forIdentifier: 0x04)

        super.init(properties: properties)
    }
}

extension AADoorLocks: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getLocksState  = 0x00
        case locksState     = 0x01
        case lockUnlock     = 0x12
    }
}

public extension AADoorLocks {

    static var getLocksState: AACommand {
        return command(forMessageType: .getLocksState)
    }


    static func lockUnlock(_ state: AALockState) -> AACommand {
        let properties = [state.property(forIdentifier: 0x01)]

        return command(forMessageType: .lockUnlock, properties: properties)
    }
}
