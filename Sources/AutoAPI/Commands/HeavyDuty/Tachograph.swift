//
// AutoAPITests
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
//  Tachograph.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 30/04/2018.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct Tachograph: AAFullStandardCommand {

    public let driversCards: [DriverCard]?
    public let driversTimeStates: [DriverTimeState]?
    public let driversWorkingStates: [DriverWorkingState]?
    public let vehicleDirection: Direction?
    public let vehicleMotionState: AAMovingState?
    public let vehicleOverspeedActive: AAActiveState?
    public let vehicleSpeed: Int16?


    // MARK: AAFullStandardCommand

    public let properties: AAProperties


    init?(properties: AAProperties) {
        // Ordered by the ID
        driversWorkingStates = properties.flatMap(for: 0x01) { DriverWorkingState($0.value) }
        driversTimeStates = properties.flatMap(for: 0x02) { DriverTimeState($0.value) }
        driversCards = properties.flatMap(for: 0x03) { DriverCard($0.value) }
        vehicleDirection = Direction(rawValue: properties.first(for: 0x06)?.monoValue)
        vehicleMotionState = AAMovingState(rawValue: properties.first(for: 0x04)?.monoValue)
        vehicleOverspeedActive = AAActiveState(rawValue: properties.first(for: 0x05)?.monoValue)
        vehicleSpeed = properties.value(for: 0x07)

        // Properties
        self.properties = properties
    }
}

extension Tachograph: AAIdentifiable {

    public static var identifier: AACommandIdentifier = AACommandIdentifier(0x0064)
}

extension Tachograph: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getState = 0x00
        case state    = 0x01
    }
}

public extension Tachograph {

    static var getState: [UInt8] {
        return commandPrefix(for: .getState)
    }
}
