//
// AutoAPI
// Copyright (C) 2017 High-Mobility GmbH
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
//  Copyright © 2017 High Mobility. All rights reserved.
//

import Foundation


public struct AutoAPI {

    static var commands: [Any] {
        return [Browser.self,
                Capabilities.self,
                Charging.self,
                ChassisSettings.self,
                Climate.self,
                Diagnostics.self,
                DoorLocks.self,
                DriverFatigue.self,
                Engine.self,
                FailureMessage.self,
                FirmwareVersion.self,
                Fueling.self,
                Graphics.self,
                HeartRate.self,
                HonkHornFlashFlights.self,
                KeyfobPosition.self,
                LightConditions.self,
                Lights.self,
                Maintenance.self,
                Messaging.self,
                NaviDestination.self,
                Notifications.self,
                Offroad.self,
                ParkingBrake.self,
                ParkingTicket.self,
                Race.self,
                RemoteControl.self,
                RooftopControl.self,
                Seats.self,
                TextInput.self,
                TheftAlarm.self,
                TrunkAccess.self,
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


    public static func parseBinary<C: Collection>(_ binary: C) -> Command? where C.Element == UInt8 {
        return commands.flatMap { $0 as? BinaryInitable.Type }.flatMapFirst { $0.init(binary) as? Command }
    }
}
