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
public typealias AAChargingMethod = PlugType
public typealias AACommandIdentifier = UInt16
public typealias AAPercentageInt = UInt8

typealias AAPropertyIdentifier = UInt8


public struct AutoAPI {

    static var commands: [Any] {
        return [Browser.self,
                Capabilities.self,
                AACharging.self,
                AAChassisSettings.self,
                AAClimate.self,
                AACruiseControl.self,
                DashboardLights.self,
                Diagnostics.self,
                DoorLocks.self,
                DriverFatigue.self,
                Engine.self,
                FailureMessage.self,
                FirmwareVersion.self,
                Fueling.self,
                Graphics.self,
                HeartRate.self,
                HomeCharger.self,
                HonkHornFlashFlights.self,
                Hood.self,
                KeyfobPosition.self,
                LightConditions.self,
                Lights.self,
                Maintenance.self,
                Messaging.self,
                Mobile.self,
                NaviDestination.self,
                Notifications.self,
                Offroad.self,
                ParkingBrake.self,
                ParkingTicket.self,
                PowerTakeOff.self,
                Race.self,
                RemoteControl.self,
                RooftopControl.self,
                Seats.self,
                StartStop.self,
                Tachograph.self,
                TextInput.self,
                TheftAlarm.self,
                TrunkAccess.self,
                Usage.self,
                ValetMode.self,
                VehicleLocation.self,
                VehicleStatus.self,
                VehicleTime.self,
                VideoHandover.self,
                WakeUp.self,
                WeatherConditions.self,
                WiFi.self,
                Windows.self,
                Windscreen.self]
    }


    // MARK: Type Methods

    public static func parseBinary<C: Collection>(_ binary: C) -> Command? where C.Element == UInt8 {
        return commands.compactMap { $0 as? BinaryInitable.Type }.flatMapFirst { $0.init(binary) as? Command }
    }
}
