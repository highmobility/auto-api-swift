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
//  AAHonkHornFlashLights.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 12/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public class AAHonkHornFlashLights: AACapabilityClass, AACapability {

    public let flasherState: AAProperty<AAFlasherState>?


    // MARK: AACapability

    public static var identifier: AACommandIdentifier = 0x0026


    required init(properties: AAProperties) {
        // Ordered by the ID
        flasherState = properties.property(forIdentifier: 0x01)

        super.init(properties: properties)
    }
}

extension AAHonkHornFlashLights: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getFlasherState    = 0x00
        case flasherState       = 0x01
        case honkFlash          = 0x12
        case emergencyFlasher   = 0x13
    }
}

public extension AAHonkHornFlashLights {

    static var getFlasherState: AACommand {
        return command(forMessageType: .getFlasherState)
    }


    static func activateEmergencyFlasher(_ state: AAActiveState) -> AACommand {
        let properties = [state.property(forIdentifier: 0x01)]

        return command(forMessageType: .emergencyFlasher, properties: properties)
    }

    /// At least *one* value needs to be entered, instead of both being `nil`.
    static func honkHorn(seconds: UInt8?, flashLightsXTimes xTimes: UInt8?) -> AACommand? {
        guard (seconds != nil) || (xTimes != nil) else {
            return nil
        }

        let properties = [seconds?.property(forIdentifier: 0x01),
                          xTimes?.property(forIdentifier: 0x02)]

        return command(forMessageType: .honkFlash, properties: properties)
    }
}
