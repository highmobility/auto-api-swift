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
//  AAClimate.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 30/11/2017.
//  Copyright © 2019 High Mobility GmbH. All rights reserved.
//

import Foundation


public class AAClimate: AACapabilityClass, AACapability {

    public let defrostingTemperature: AAProperty<Float>?
    public let defoggingState: AAProperty<AAActiveState>?
    public let defrostingState: AAProperty<AAActiveState>?
    public let driverTemperature: AAProperty<Float>?
    public let hvacState: AAProperty<AAActiveState>?
    public let insideTemperature: AAProperty<Float>?
    public let ionisingState: AAProperty<AAActiveState>?
    public let outsideTemperature: AAProperty<Float>?
    public let passengerTemperature: AAProperty<Float>?
    public let rearTemperature: AAProperty<Float>?
    public let weekdaysStartingTimes: [AAProperty<AAClimateWeekdayTime>]?


    // MARK: AACapability

    public static var identifier: AACapabilityIdentifier = 0x0024


    required init(properties: AAProperties) {
        // Ordered by the ID
        insideTemperature = properties.property(forIdentifier: 0x01)
        outsideTemperature = properties.property(forIdentifier: 0x02)
        driverTemperature = properties.property(forIdentifier: 0x03)
        passengerTemperature = properties.property(forIdentifier: 0x04)
        hvacState = properties.property(forIdentifier: 0x05)
        defoggingState = properties.property(forIdentifier: 0x06)
        defrostingState = properties.property(forIdentifier: 0x07)
        ionisingState = properties.property(forIdentifier: 0x08)
        defrostingTemperature = properties.property(forIdentifier: 0x09)
        /* Level 8 */
        weekdaysStartingTimes = properties.allOrNil(forIdentifier: 0x0B)
        rearTemperature = properties.property(forIdentifier: 0x0C)

        super.init(properties: properties)
    }
}

extension AAClimate: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getClimateState        = 0x00
        case climateState           = 0x01
        case changeStartingTimes    = 0x12
        case startStopHVAC          = 0x13
        case startStopDefogging     = 0x14
        case startStopDefrosting    = 0x15
        case startStopIonising      = 0x16
        case changeTemperatures     = 0x17
    }
}

public extension AAClimate {

    static var getClimateState: AACommand {
        return command(forMessageType: .getClimateState)
    }


    static func changeStartingTimes(_ times: [AAClimateWeekdayTime]) -> AACommand {
        let properties = times.map { $0.property(forIdentifier: 0x01) }

        return command(forMessageType: .changeStartingTimes, properties: properties)
    }

    static func changeTemperatures(driver: Float?, passenger: Float?, rear: Float?) -> AACommand {
        let properties = [driver?.property(forIdentifier: 0x01),
                          passenger?.property(forIdentifier: 0x02),
                          rear?.property(forIdentifier: 0x03)]

        return command(forMessageType: .changeTemperatures, properties: properties)
    }

    static func startStopDefogging(_ state: AAActiveState) -> AACommand {
        let properties = [state.property(forIdentifier: 0x01)]

        return command(forMessageType: .startStopDefogging, properties: properties)
    }

    static func startStopDefrosting(_ state: AAActiveState) -> AACommand {
        let properties = [state.property(forIdentifier: 0x01)]

        return command(forMessageType: .startStopDefrosting, properties: properties)
    }

    static func startStopHVAC(_ state: AAActiveState) -> AACommand {
        let properties = [state.property(forIdentifier: 0x01)]

        return command(forMessageType: .startStopHVAC, properties: properties)
    }

    static func startStopIonising(_ state: AAActiveState) -> AACommand {
        let properties = [state.property(forIdentifier: 0x01)]

        return command(forMessageType: .startStopIonising, properties: properties)
    }
}
