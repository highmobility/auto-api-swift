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
//  RemoteControl.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 12/12/2017.
//  Copyright © 2017 High Mobility. All rights reserved.
//

import Foundation


public struct RemoteControl: FullStandardCommand {

    public let angle: Int16?
    public let controlMode: ControlMode?


    // MARK: FullStandardCommand

    public let properties: Properties


    init?(properties: Properties) {
        // Ordered by the ID
        controlMode = ControlMode(rawValue: properties.first(for: 0x01)?.monoValue)
        angle = properties.value(for: 0x02)

        // Properties
        self.properties = properties
    }
}

extension RemoteControl: Identifiable {

    public static var identifier: Identifier = Identifier(0x0027)
}

extension RemoteControl: MessageTypesGettable {

    public enum MessageTypes: UInt8, MessageTypesType {

        case getControlMode     = 0x00
        case controlMode        = 0x01
        case startControlMode   = 0x02
        case stopControlMode    = 0x03
        case controlCommand     = 0x04


        public static let getState = MessageTypes.getControlMode
        public static let state = MessageTypes.controlMode

        public static var all: [UInt8] {
            return [self.getControlMode.rawValue,
                    self.controlMode.rawValue,
                    self.startControlMode.rawValue,
                    self.stopControlMode.rawValue,
                    self.controlCommand.rawValue]
        }
    }
}

public extension RemoteControl {

    struct Control {
        public let speed: Int8?
        public let angle: Int16?

        public init(speed: Int8?, angle: Int16?) {
            self.speed = speed
            self.angle = angle
        }
    }


    static var controlCommand: (Control) -> [UInt8] {
        return {
            let speedBytes: [UInt8] = $0.speed?.propertyBytes(0x01) ?? []
            let angleBytes: [UInt8] = $0.angle?.propertyBytes(0x02) ?? []

            return identifier.bytes + [0x04] + speedBytes + angleBytes
        }
    }

    static var getControlMode: [UInt8] {
        return getState
    }

    static var startControlMode: [UInt8] {
        return identifier.bytes + [0x02]
    }

    static var stopControlMode: [UInt8] {
        return identifier.bytes + [0x03]
    }
}
