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
//  AATrunkAccess.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 24/11/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public class AATrunkAccess: AACapabilityClass, AACapability {

    public let lock: AAProperty<AALockState>?
    public let position: AAProperty<AAPositionState>?


    // MARK: AACapability

    public static var identifier: AACommandIdentifier = 0x0021


    required init(properties: AAProperties) {
        // Ordered by the ID
        lock = properties.property(forIdentifier: 0x01)
        position = properties.property(forIdentifier: 0x02)

        super.init(properties: properties)
    }
}

extension AATrunkAccess: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getState   = 0x00
        case state      = 0x01
        case lockOpen   = 0x12
    }
}

public extension AATrunkAccess {

    static var getState: AACommand {
        return command(forMessageType: .getState)
    }


    static func controlTrunk(_ lockUnlock: AALockState?, changePosition position: AAPositionState?) -> AACommand {
        let properties = [lockUnlock?.property(forIdentifier: 0x01),
                          position?.property(forIdentifier: 0x02)]

        return command(forMessageType: .lockOpen, properties: properties)
    }
}
