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
//  AACruiseControl.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 24/04/2018.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct AACruiseControl: AAFullStandardCommand {

    public let state: AAActiveState?
    public let adaptiveState: AAActiveState?
    public let adaptiveTargetSpeed: Int16?
    public let limiter: AACruiseControlLimiter?
    public let targetSpeed: Int16?


    @available(*, deprecated, renamed: "state")
    public var activeState: AAActiveState? {
        return state
    }


    // MARK: AAFullStandardCommand

    public let properties: AAProperties


    init?(properties: AAProperties) {
        // Ordered by the ID
        state = properties.value(for: 0x01)
        limiter = AACruiseControlLimiter(rawValue: properties.first(for: 0x02)?.monoValue)
        targetSpeed = properties.value(for: 0x03)
        adaptiveState = properties.value(for: 0x04)
        adaptiveTargetSpeed = properties.value(for: 0x05)

        // Properties
        self.properties = properties
    }
}

extension AACruiseControl: AAIdentifiable {

    public static var identifier: AACommandIdentifier = 0x0062
}

extension AACruiseControl: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getControlState        = 0x00
        case controlState           = 0x01
        case activateCruiseControl  = 0x02


        @available(*, deprecated, renamed: "getControlState")
        static let getCruiseControlState = MessageTypes.getControlState

        @available(*, deprecated, renamed: "controlState")
        static let cruiseControlState = MessageTypes.controlState

        @available(*, deprecated, renamed: "activateCruiseControl")
        static let controlCruiseControl = MessageTypes.activateCruiseControl
    }
}

public extension AACruiseControl {

    static func activateCruiseControl(_ settings: AACruiseControlSettings) -> [UInt8] {
        return commandPrefix(for: .activateCruiseControl) + settings.propertiesValuesCombined
    }

    static var getCruiseControlState: [UInt8] {
        return commandPrefix(for: .getControlState)
    }
}
