//
// AutoAPI
// Copyright (C) 2020 High-Mobility GmbH
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
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation


public struct AAAutoAPI {

    static let capabilities: [AACapability.Type] = [AABrowser.self,
                                                    AACapabilities.self,
                                                    AACharging.self,
                                                    AAChassisSettings.self,
                                                    AAClimate.self,
                                                    AACruiseControl.self,
                                                    AADashboardLights.self,
                                                    AADiagnostics.self,
                                                    AADoors.self,
                                                    AADriverFatigue.self,
                                                    AAEngine.self,
                                                    AAEngineStartStop.self,
                                                    AAFailureMessage.self,
                                                    AAFirmwareVersion.self,
                                                    AAFueling.self,
                                                    AAGraphics.self,
                                                    AAHeartRate.self,
                                                    AAHistorical.self,
                                                    AAHomeCharger.self,
                                                    AAHonkHornFlashLights.self,
                                                    AAHood.self,
                                                    AAIgnition.self,
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
                                                    AATachograph.self,
                                                    AATextInput.self,
                                                    AATheftAlarm.self,
                                                    AATrunk.self,
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

    static let protocolVersion: UInt8 = 11


    // MARK: Type Methods

    /// Parse the input binary to a capability.
    ///
    /// This is the *main* access point for parsing binary data into an easily usable capability.
    ///
    /// After a capability is parsed, it should be cast into the desired type.
    ///
    /// ```
    /// if let charging = AAAutoAPI.parseBinary(binaryData) as? AACharging {
    ///     // code
    /// }
    /// ```
    ///
    /// - parameters:
    ///    - binary: Bytes of a capability's *state* as a `UInt8-Collection` (i.e. `Array<UInt8>` or `Data`)
    /// - returns: The parsed capability (if a match is found) as `AACapability`
    public static func parseBinary<C>(_ binary: C) -> AACapability? where C: Collection, C.Element == UInt8 {
        guard binary.count >= 3 else {
            return nil
        }
    
        // For 1-3ms gain...
        let bytes: Array<UInt8>
    
        if let bytesArray = binary as? Array<UInt8> {
            bytes = bytesArray
        }
        else {
            bytes = Array(binary)
        }
    
        // Check if the data has the correct version
        guard AAProtocolVersion(bytes[0]) == protocolVersion else {
            return nil
        }
    
        // UInt16 initialiser can't create an invalid value with 2 bytes
        let capabilityIdentifier = UInt16(bytes: bytes[1...2])!
    
        return capabilities.first { $0.identifier == capabilityIdentifier }?.init(bytes: bytes)
    }
}