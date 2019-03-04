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
//  DashboardLightName.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 24/04/2018.
//  Copyright © 2019 High Mobility. All rights reserved.
//

import Foundation


public enum DashboardLightName: UInt8 {

    case highMainBeam                       = 0x00
    case lowDippedBeam                      = 0x01
    case hazardWarning                      = 0x02
    case brakeFailureSystemMalfunction      = 0x03
    case hatchOpen                          = 0x04
    case fuelLevel                          = 0x05
    case engineCoolantTemperature           = 0x06
    case batteryChargingCondition           = 0x07
    case engineOil                          = 0x08
    case positionSideLights                 = 0x09
    case frontFogLight                      = 0x0A
    case rearFogLight                       = 0x0B
    case parkHeating                        = 0x0C
    case engineIndicator                    = 0x0D
    case serviceCallForMaintenance          = 0x0E
    case transmissionFluidTemperature       = 0x0F
    case transmissionFailureMalfunction     = 0x10
    case antilockBrakeSystemFailure         = 0x11
    case workBrakeLinings                   = 0x12
    case windscreenWindShieldWasherFluid    = 0x13
    case tireFailureMalfunction             = 0x14
    case engineOilLevel                     = 0x15
    case engineCoolantLevel                 = 0x16
    case steeringFailure                    = 0x17
    case electronicSpeedControllerIndiction = 0x18
    case brakeLights                        = 0x19
    case adBlueLevel                        = 0x1A
    case fuelFilterDifferentialPressure     = 0x1B
    case seatBelt                           = 0x1C
    case advancedEmergencyBrakingSystem     = 0x1D
    case autonomousCruiseControl            = 0x1E
    case trailerConnected                   = 0x1F
    case airbag                             = 0x20
    case escSwitchedOff                     = 0x21
    case laneDepartureWarningSwitchedOff    = 0x22
}
