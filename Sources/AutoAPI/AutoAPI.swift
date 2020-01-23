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
//  AutoAPI.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 23/11/2017.
//

import Foundation
import HMUtilities


public typealias PercentageInt = UInt8


public struct AAAutoAPI {

    static var commands: [Any] {
        return [Browser.self,
                Capabilities.self,
                Charging.self,
                ChassisSettings.self,
                Climate.self,
                CruiseControl.self,
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
                KeyfobPosition.self,
                LightConditions.self,
                Lights.self,
                Maintenance.self,
                Messaging.self,
                MultiCommand.self,
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
