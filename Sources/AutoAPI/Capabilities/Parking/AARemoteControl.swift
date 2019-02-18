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
//  AARemoteControl.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 12/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public class AARemoteControl: AACapabilityClass, AACapability {

    public let angle: AAProperty<Int16>?
    public let controlMode: AAProperty<AAControlMode>?


    // MARK: AACapability

    public static var identifier: AACommandIdentifier = 0x0027


    required init(properties: AAProperties) {
        // Ordered by the ID
        controlMode = properties.property(forIdentifier: 0x01)
        angle = properties.property(forIdentifier: 0x02)

        super.init(properties: properties)
    }
}

extension AARemoteControl: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getControlState    = 0x00
        case controlMode        = 0x01
        case controlCommand     = 0x04
        case startStopControl   = 0x12
    }
}

public extension AARemoteControl {

    static var getControlState: AACommand {
        return command(forMessageType: .getControlState)
    }


    static func controlCommand(angle: Int16?, speed: Int8?) -> AACommand {
        let properties = [speed?.property(forIdentifier: 0x01),
                          angle?.property(forIdentifier: 0x02)]

        return command(forMessageType: .controlCommand, properties: properties)
    }

    /// `.reset` is not supported
    static func startStopControl(_ startStop: AAStartStopState) -> AACommand? {
        guard startStop != .reset else {
            return nil
        }

        let properties = [startStop.property(forIdentifier: 0x01)]

        return command(forMessageType: .startStopControl, properties: properties)
    }
}
