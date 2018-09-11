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
//  ChassisSettings.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct ChassisSettings: FullStandardCommand {

    public let chassisPosition: ChassisPosition?
    public let drivingMode: DrivingMode?
    public let sportChroneState: ActiveState?
    public let springRates: [SpringRate]?


    // MARK: FullStandardCommand

    public let properties: Properties


    init?(properties: Properties) {
        // Ordered by the ID
        drivingMode = DrivingMode(rawValue: properties.first(for: 0x01)?.monoValue)
        sportChroneState = ActiveState(rawValue: properties.first(for: 0x02)?.monoValue)
        springRates = properties.flatMap(for: 0x03) { SpringRate($0.value) }
        chassisPosition = ChassisPosition(bytes: properties.first(for: 0x04)?.value)

        // Properties
        self.properties = properties
    }
}

extension ChassisSettings: Identifiable {

    public static var identifier: Identifier = Identifier(0x0053)
}

extension ChassisSettings: MessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getChassisSettings     = 0x00
        case chassisSettings        = 0x01
        case setDrivingMode         = 0x02
        case startStopSportChrono   = 0x03
        case setSpringRate          = 0x04
        case setChassisPosition     = 0x05
    }
}

public extension ChassisSettings {

    static var getChassisSettings: [UInt8] {
        return commandPrefix(for: .getChassisSettings)
    }

    static var setChassisPosition: (UInt8) -> [UInt8] {
        return {
            return commandPrefix(for: .setChassisPosition, additionalBytes: $0)
        }
    }

    static var setDrivingMode: (DrivingMode) -> [UInt8] {
        return {
            return commandPrefix(for: .setDrivingMode, additionalBytes: $0.rawValue)
        }
    }

    static var setSpringRate: (Axle, UInt8) -> [UInt8] {
        return {
            return commandPrefix(for: .setSpringRate, additionalBytes: $0.rawValue, $1)
        }
    }

    static var startStopSportChrono: (StartStopChrono) -> [UInt8] {
        return {
            return commandPrefix(for: .startStopSportChrono, additionalBytes: $0.rawValue)
        }
    }
}
