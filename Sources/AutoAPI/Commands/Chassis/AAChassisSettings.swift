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
//  AAChassisSettings.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct AAChassisSettings: AAFullStandardCommand {

    public let currentChassisPosition: UInt8?
    public let currentSpringRates: [AASpringRateValue]?
    public let drivingMode: AADrivingMode?
    public let maximumChassisPosition: Int8?
    public let maximumSpringRates: [AASpringRateValue]?
    public let minimumChassisPosition: Int8?
    public let minimumSpringRates: [AASpringRateValue]?
    public let sportChronoState: AAActiveState?


    // MARK: AAFullStandardCommand

    public let properties: AAProperties


    init?(properties: AAProperties) {
        // Ordered by the ID
        drivingMode = AADrivingMode(rawValue: properties.first(for: 0x01)?.monoValue)
        sportChronoState = properties.value(for: 0x02)
        springRates = properties.flatMap(for: 0x03) { AASpringRate($0.value) }  // Deprecated
        chassisPosition = AAChassisPosition(bytes: properties.first(for: 0x04)?.value)    // Deprecated
        /* Level 8 */
        currentSpringRates = properties.flatMap(for: 0x05) { AASpringRateValue($0.value) }
        maximumSpringRates = properties.flatMap(for: 0x06) { AASpringRateValue($0.value) }
        minimumSpringRates = properties.flatMap(for: 0x07) { AASpringRateValue($0.value) }
        currentChassisPosition = properties.value(for: 0x08)
        maximumChassisPosition = properties.value(for: 0x09)
        minimumChassisPosition = properties.value(for: 0x0A)

        // Convert deprecated properties to new ones


        // Properties
        self.properties = properties
    }


    // MARK: Deprecated

    @available(*, deprecated, message: "Split into .currentChassisPosition, .maximumChassisPosition, .minimumChassisPosition")
    public let chassisPosition: AAChassisPosition?

    @available(*, deprecated, message: "Split into .currentSpringRates, .maximumSpringRates, .minimumSpringRates")
    public let springRates: [AASpringRate]?

    @available(*, deprecated, renamed: "sportChronoState")
    public var isSportChroneActive: Bool? {
        return sportChronoState == .active
    }
}

extension AAChassisSettings: AAIdentifiable {

    public static var identifier: AACommandIdentifier = 0x0053
}

extension AAChassisSettings: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getChassisSettings     = 0x00
        case chassisSettings        = 0x01
        case setDrivingMode         = 0x02
        case startStopSportChrono   = 0x03
        case setSpringRates         = 0x04
        case setChassisPosition     = 0x05


        // MARK: Deprecated

        @available(*, deprecated, renamed: "setSpringRates")
        static let setSpringRate = MessageTypes.setSpringRates
    }
}

public extension AAChassisSettings {

    static var getChassisSettings: [UInt8] {
        return commandPrefix(for: .getChassisSettings)
    }

    static func setChassisPosition(_ position: UInt8) -> [UInt8] {
        return commandPrefix(for: .setChassisPosition) + position.propertyBytes(0x01)
    }

    static func setDrivingMode(_ mode: AADrivingMode) -> [UInt8] {
        return commandPrefix(for: .setDrivingMode) + mode.propertyBytes(0x01)
    }

    static func setSpringRates(_ rates: [AASpringRateValue]) -> [UInt8] {
        return commandPrefix(for: .setSpringRates) + rates.reduceToByteArray { $0.propertyBytes(0x01) }
    }

    static func startStopSportChrono(_ startStop: AAStartStopChrono) -> [UInt8] {
        return commandPrefix(for: .startStopSportChrono) + startStop.propertyBytes(0x01)
    }


    // MARK: Deprecated

    @available(*, deprecated, renamed: "setSpringRates")
    static var setSpringRate: (AAAxle, UInt8) -> [UInt8] {
        return {
            return setSpringRates([AASpringRateValue(axle: $0, value: $1)])
        }
    }
}
