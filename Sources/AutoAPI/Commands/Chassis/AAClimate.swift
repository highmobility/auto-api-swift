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
//  AAClimate.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 30/11/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct AAClimate: AAFullStandardCommand {

    public let climateProfile: AAClimateProfile?
    public let defrostingTemperature: Float?
    public let driverTemperature: Float?
    public let insideTemperature: Float?
    public let defoggingState: AAActiveState?
    public let defrostingState: AAActiveState?
    public let hvacState: AAActiveState?
    public let ionisingState: AAActiveState?
    public let outsideTemperature: Float?
    public let passengerTemperature: Float?


    @available(*, deprecated, renamed: "defoggingState")
    public var isDefoggingActive: Bool? {
        return defoggingState == .active
    }

    @available(*, deprecated, renamed: "defrostingState")
    public var isDefrostingActive: Bool? {
        return defrostingState == .active
    }

    @available(*, deprecated, renamed: "hvacState")
    public var isHVACActive: Bool? {
        return hvacState == .active
    }

    @available(*, deprecated, renamed: "ionisingState")
    public var isIonisingActive: Bool? {
        return ionisingState == .active
    }


    // MARK: AAFullStandardCommand

    public let properties: AAProperties


    init?(properties: AAProperties) {
        // Ordered by the ID
        insideTemperature = properties.value(for: 0x01)
        outsideTemperature = properties.value(for: 0x02)
        driverTemperature = properties.value(for: 0x03)
        passengerTemperature = properties.value(for: 0x04)
        hvacState = properties.value(for: 0x05)
        defoggingState = properties.value(for: 0x06)
        defrostingState = properties.value(for: 0x07)
        ionisingState = properties.value(for: 0x08)
        defrostingTemperature = properties.value(for: 0x09)
        climateProfile = AAClimateProfile(bytes: properties.first(for: 0x0A)?.value)

        // Properties
        self.properties = properties
    }
}

extension AAClimate: AAIdentifiable {

    public static var identifier: AACommandIdentifier = 0x0024
}

extension AAClimate: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getClimateState        = 0x00
        case climateState           = 0x01
        case setClimateProfile      = 0x02
        case startStopHVAC          = 0x03
        case startStopDefogging     = 0x04
        case startStopDefrosting    = 0x05
        case startStopIonising      = 0x06
        /* Level 8 */
        case changeTemperatures     = 0x07
    }
}

public extension AAClimate {

    static var getClimateState: [UInt8] {
        return commandPrefix(for: .getClimateState)
    }

    static func setClimateProfile(_ profile: AAClimateProfile) -> [UInt8] {
        return commandPrefix(for: .setClimateProfile) + profile.propertiesValuesCombined
    }

    static func startStopDefogging(_ state: AAActiveState) -> [UInt8] {
        return commandPrefix(for: .startStopDefogging) + state.propertyBytes(0x01)
    }

    static func startStopDefrosting(_ state: AAActiveState) -> [UInt8] {
            return commandPrefix(for: .startStopDefrosting) + state.propertyBytes(0x01)
    }

    static func startStopHVAC(_ state: AAActiveState) -> [UInt8] {
        return commandPrefix(for: .startStopHVAC) + state.propertyBytes(0x01)
    }

    static func startStopIonising(_ state: AAActiveState) -> [UInt8] {
        return commandPrefix(for: .startStopIonising) + state.propertyBytes(0x01)
    }

    static func changeTemperatures(driver: Float?, passenger: Float?, rear: Float?) -> [UInt8] {
        return commandPrefix(for: .changeTemperatures) + [driver?.propertyBytes(0x01),
                                                          passenger?.propertyBytes(0x02),
                                                          rear?.propertyBytes(0x03)].propertiesValuesCombined
    }


    // MARK: Deprecated

    @available(*, deprecated, renamed: "ClimateSettings")
    typealias Settings = AAClimateSettings

    @available(*, deprecated, renamed: "startStopDefogging")
    static var startDefogging: (Bool) -> [UInt8] {
        return {
            return startStopDefogging($0 ? .activate : .inactivate)
        }
    }

    @available(*, deprecated, renamed: "startStopDefrosting")
    static var startDefrosting: (Bool) -> [UInt8] {
        return {
            return startStopDefrosting($0 ? .activate : .inactivate)
        }
    }

    @available(*, deprecated, renamed: "startStopHVAC")
    static var startHVAC: (Bool) -> [UInt8] {
        return {
            return startStopHVAC($0 ? .activate : .inactivate)
        }
    }

    @available(*, deprecated, renamed: "startStopIonising")
    static var startIonising: (Bool) -> [UInt8] {
        return {
            return startStopIonising($0 ? .activate : .inactivate)
        }
    }
}
