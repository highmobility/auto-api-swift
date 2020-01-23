//
//  The MIT License
//
//  Copyright (c) 2014- High-Mobility GmbH (https://high-mobility.com)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//
//
//  DashboardLightName.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 24/04/2018.
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
