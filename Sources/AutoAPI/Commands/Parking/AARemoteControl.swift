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


public struct AARemoteControl: AAFullStandardCommand {

    public let angle: Int16?
    public let controlMode: AAControlMode?


    // MARK: AAFullStandardCommand

    public let properties: AAProperties


    init?(properties: AAProperties) {
        // Ordered by the ID
        controlMode = AAControlMode(properties: properties, keyPath: \AARemoteControl.controlMode)
        angle = properties.value(for: \AARemoteControl.angle)

        // Properties
        self.properties = properties
    }
}

extension AARemoteControl: AAIdentifiable {

    public static var identifier: AACommandIdentifier = 0x0027
}

extension AARemoteControl: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getControlState    = 0x00
        case controlMode        = 0x01
        case controlCommand     = 0x04
        case startStopControl   = 0x12
    }
}

extension AARemoteControl: AAPropertyIdentifierGettable {

    static func propertyID<Type>(for keyPath: KeyPath<AARemoteControl, Type>) -> AAPropertyIdentifier {
        switch keyPath {
        case \AARemoteControl.controlMode:  return 0x01
        case \AARemoteControl.angle:        return 0x02

        default:
            return 0x00
        }
    }
}


// MARK: Commands

public extension AARemoteControl {

    static var getControlState: [UInt8] {
        return commandPrefix(for: .getControlState)
    }


    static func controlCommand(angle: Int16?, speed: Int8?) -> [UInt8] {
        return commandPrefix(for: .controlCommand) + [angle?.propertyBytes(0x02),
                                                      speed?.propertyBytes(0x01)].propertiesValuesCombined
    }

    /// `.reset` is not supported
    static func startStopControl(_ startStop: AAStartStopState) -> [UInt8]? {
        guard startStop != .reset else {
            return nil
        }

        return commandPrefix(for: .startStopControl) + startStop.propertyBytes(0x01)
    }
}

public extension AARemoteControl {

    struct Legacy: AAMessageTypesGettable {

        public enum MessageTypes: UInt8, CaseIterable {

            case getControlMode     = 0x00
            case controlMode        = 0x01
            case startControlMode   = 0x02
            case stopControlMode    = 0x03
            case controlCommand     = 0x04
        }


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

                return commandPrefix(for: AARemoteControl.self, messageType: .controlCommand) + speedBytes + angleBytes
            }
        }

        static var getControlMode: [UInt8] {
            return commandPrefix(for: AARemoteControl.self, messageType: .getControlMode)
        }

        static var startControlMode: [UInt8] {
            return commandPrefix(for: AARemoteControl.self, messageType: .startControlMode)
        }

        static var stopControlMode: [UInt8] {
            return commandPrefix(for: AARemoteControl.self, messageType: .stopControlMode)
        }
    }
}
