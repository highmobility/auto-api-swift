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
//  AAAutoAPI.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/01/2020.
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