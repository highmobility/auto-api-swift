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
//  AAChassisSettings.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/12/2017.
//  Copyright © 2019 High Mobility GmbH. All rights reserved.
//

import Foundation


public class AAChassisSettings: AACapabilityClass, AACapability {

    public let currentChassisPosition: AAProperty<Int8>?
    public let currentSpringRates: [AAProperty<AASpringRateValue>]?
    public let drivingMode: AAProperty<AADrivingMode>?
    public let maximumChassisPosition: AAProperty<Int8>?
    public let maximumSpringRates: [AAProperty<AASpringRateValue>]?
    public let minimumChassisPosition: AAProperty<Int8>?
    public let minimumSpringRates: [AAProperty<AASpringRateValue>]?
    public let sportChronoState: AAProperty<AAActiveState>?


    // MARK: AACapability

    public static var identifier: AACommandIdentifier = 0x0053


    required init(properties: AAProperties) {
        // Ordered by the ID
        drivingMode = properties.property(forIdentifier: 0x01)
        sportChronoState = properties.property(forIdentifier: 0x02)
        /* Level 8 */
        currentSpringRates = properties.allOrNil(forIdentifier: 0x05)
        maximumSpringRates = properties.allOrNil(forIdentifier: 0x06)
        minimumSpringRates = properties.allOrNil(forIdentifier: 0x07)
        currentChassisPosition = properties.property(forIdentifier: 0x08)
        maximumChassisPosition = properties.property(forIdentifier: 0x09)
        minimumChassisPosition = properties.property(forIdentifier: 0x0A)

        super.init(properties: properties)
    }
}

extension AAChassisSettings: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getChassisSettings     = 0x00
        case chassisSettings        = 0x01
        case setDrivingMode         = 0x12
        case startStopSportChrono   = 0x13
        case setSpringRates         = 0x14
        case setChassisPosition     = 0x15
    }
}

public extension AAChassisSettings {

    static var getChassisSettings: AACommand {
        return command(forMessageType: .getChassisSettings)
    }


    static func setChassisPosition(_ position: Int8) -> AACommand {
        let properties = [position.property(forIdentifier: 0x01)]

        return command(forMessageType: .setChassisPosition, properties: properties)
    }

    static func setDrivingMode(_ mode: AADrivingMode) -> AACommand {
        let properties = [mode.property(forIdentifier: 0x01)]

        return command(forMessageType: .setDrivingMode, properties: properties)
    }

    static func setSpringRates(_ rates: [AASpringRateValue]) -> AACommand {
        let properties = rates.map { $0.property(forIdentifier: 0x01) }

        return command(forMessageType: .setSpringRates, properties: properties)
    }

    static func startStopSportChrono(_ startStop: AAStartStopState) -> AACommand {
        let properties = [startStop.property(forIdentifier: 0x01)]

        return command(forMessageType: .startStopSportChrono, properties: properties)
    }
}
