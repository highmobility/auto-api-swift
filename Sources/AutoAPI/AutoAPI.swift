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
//  AutoAPI.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 23/11/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation
import HMUtilities


// TODO: Move to a file for 'typealias'
public typealias AAGasFlapState = AAChargePortState
public typealias AAChargingMethod = AAPlugType
public typealias AACommandIdentifier = UInt16
public typealias AAPercentageInt = UInt8

typealias AAPropertyIdentifier = UInt8


public struct AutoAPI {

    static var commands: [Any] {
        return [AABrowser.self,
                Capabilities.self,
                AACharging.self,
                AAChassisSettings.self,
                AAClimate.self,
                AACruiseControl.self,
                AADashboardLights.self,
                AADiagnostics.self,
                AADoorLocks.self,
                DriverFatigue.self,
                AAEngine.self,
                FailureMessage.self,
                FirmwareVersion.self,
                Fueling.self,
                AAGraphics.self,
                HeartRate.self,
                AAHistorical.self,
                AAHomeCharger.self,
                AAHonkHornFlashLights.self,
                AAHood.self,
                AAKeyfobPosition.self,
                AALightConditions.self,
                AALights.self,
                AAMaintenance.self,
                AAMessaging.self,
                AAMobile.self,
                NaviDestination.self,
                AANotifications.self,
                AAOffroad.self,
                ParkingBrake.self,
                ParkingTicket.self,
                PowerTakeOff.self,
                AARace.self,
                RemoteControl.self,
                AARooftopControl.self,
                AASeats.self,
                AAStartStop.self,
                Tachograph.self,
                TextInput.self,
                TheftAlarm.self,
                AATrunkAccess.self,
                AAUsage.self,
                ValetMode.self,
                VehicleLocation.self,
                VehicleStatus.self,
                VehicleTime.self,
                VideoHandover.self,
                AAWakeUp.self,
                AAWeatherConditions.self,
                WiFi.self,
                AAWindows.self,
                AAWindscreen.self]
    }


    // MARK: Type Methods

    public static func parseBinary<C: Collection>(_ binary: C) -> AACommand? where C.Element == UInt8 {
        return commands.compactMap { $0 as? AABinaryInitable.Type }.flatMapFirst { $0.init(binary) as? AACommand }
    }
}
