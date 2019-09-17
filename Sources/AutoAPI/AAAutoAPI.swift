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
//  AAAutoAPI.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 23/11/2017.
//  Copyright © 2019 High Mobility GmbH. All rights reserved.
//

import Foundation


public typealias AACapabilityIdentifier = UInt16
public typealias AANetworkSSID = String
public typealias AAPercentage = Double
public typealias AAPropertyIdentifier = UInt8


public struct AAAutoAPI {

    static let capabilities: [AACapability.Type] = [AABrowser.self,
                                                    AACapabilities.self,
                                                    AACharging.self,
                                                    AAChassisSettings.self,
                                                    AAClimate.self,
                                                    AACruiseControl.self,
                                                    AADashboardLights.self,
                                                    AADiagnostics.self,
                                                    AADoorLocks.self,
                                                    AADriverFatigue.self,
                                                    AAEngine.self,
                                                    AAFailureMessage.self,
                                                    AAFirmwareVersion.self,
                                                    AAFueling.self,
                                                    AAGraphics.self,
                                                    AAHeartRate.self,
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
                                                    AAMultiCommand.self,
                                                    AANaviDestination.self,
                                                    AANotifications.self,
                                                    AAOffroad.self,
                                                    AAParkingBrake.self,
                                                    AAParkingTicket.self,
                                                    AAPowerTakeoff.self,
                                                    AARace.self,
                                                    AARemoteControl.self,
                                                    AARooftopControl.self,
                                                    AASeats.self,
                                                    AAStartStop.self,
                                                    AATachograph.self,
                                                    AATextInput.self,
                                                    AATheftAlarm.self,
                                                    AATrunkAccess.self,
                                                    AAUsage.self,
                                                    AAValetMode.self,
                                                    AAVehicleLocation.self,
                                                    AAVehicleStatus.self,
                                                    AAVehicleTime.self,
                                                    AAVideoHandover.self,
                                                    AAWakeUp.self,
                                                    AAWeatherConditions.self,
                                                    AAWiFi.self,
                                                    AAWindows.self,
                                                    AAWindscreen.self]


    // MARK: Type Methods

    public static func parseBinary<C>(_ binary: C) -> AACapability? where C: Collection, C.Element == UInt8 {
        guard binary.count >= 2 else {
            return nil
        }

        // For 1-3ms gain...
        let bytes: [UInt8]

        if let bytesArray = binary as? [UInt8] {
            bytes = bytesArray
        }
        else {
            bytes = Array(binary)
        }

        // UInt16 initialiser can't create an invalid value with 2 bytes
        let capabilityIdentifier = AACapabilityIdentifier(bytes: bytes.prefix(2))!

        return capabilities.first { $0.identifier == capabilityIdentifier }?.init(bytes: bytes)
    }
}
