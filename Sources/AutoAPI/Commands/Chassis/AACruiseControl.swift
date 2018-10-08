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
//  AACruiseControl.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 24/04/2018.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct AACruiseControl: AAFullStandardCommand {

    public let state: AAActiveState?
    public let adaptiveState: AAActiveState?
    public let adaptiveTargetSpeed: Int16?
    public let limiter: AACruiseControlLimiter?
    public let targetSpeed: Int16?


    // MARK: AAFullStandardCommand

    public let properties: AAProperties


    init?(properties: AAProperties) {
        // Ordered by the ID
        state = properties.value(for: \AACruiseControl.state)
        limiter = AACruiseControlLimiter(properties: properties, keyPath: \AACruiseControl.limiter)
        targetSpeed = properties.value(for: \AACruiseControl.targetSpeed)
        adaptiveState = properties.value(for: \AACruiseControl.adaptiveState)
        adaptiveTargetSpeed = properties.value(for: \AACruiseControl.adaptiveTargetSpeed)

        // Properties
        self.properties = properties
    }
}

extension AACruiseControl: AAIdentifiable {

    public static var identifier: AACommandIdentifier = 0x0062
}

extension AACruiseControl: AALegacyGettable {

    public struct Legacy: AALegacyType {

        public enum MessageTypes: UInt8, CaseIterable {

            case getCruiseControlState  = 0x00
            case cruiseControlState     = 0x01
            case controlCruiseControl   = 0x02
        }


        public init(properties: AAProperties) {

        }
    }
}

extension AACruiseControl: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getControlState        = 0x00
        case controlState           = 0x01
        case activateCruiseControl  = 0x12
    }
}

extension AACruiseControl: AAPropertyIdentifierGettable {

    static func propertyID(for keyPath: PartialKeyPath<AACruiseControl>) -> AAPropertyIdentifier {
        switch keyPath {
        case \AACruiseControl.state:                    return 0x01
        case \AACruiseControl.limiter:               return 0x02
        case \AACruiseControl.targetSpeed:           return 0x03
        case \AACruiseControl.adaptiveState:         return 0x04
        case \AACruiseControl.adaptiveTargetSpeed:   return 0x05

        default:
            return 0x00
        }
    }
}


// MARK: Commands

public extension AACruiseControl {

    static var getCruiseControlState: [UInt8] {
        return commandPrefix(for: .getControlState)
    }


    /// If *state* is `.inactivate` – *targetSpeed* is ignored.
    static func activateCruiseControl(state: AAActiveState, targetSpeed: Int16? = nil) -> [UInt8] {
        let targetSpeedBytes = (state != .inactivate) ? targetSpeed?.propertyBytes(0x02) : []

        return commandPrefix(for: .activateCruiseControl) + [state.propertyBytes(0x01),
                                                             targetSpeedBytes].propertiesValuesCombined
    }
}

public extension AACruiseControl.Legacy {

    struct Control {
        public let isActive: Bool
        public let targetSpeed: Int16?

        public init(isActive: Bool, targetSpeed: Int16?) {
            self.isActive = isActive
            self.targetSpeed = targetSpeed
        }
    }


    static var activateCruiseControl: (Control) -> [UInt8] {
        return {
            let activationBytes = $0.isActive.propertyBytes(0x01)
            let speedBytes: [UInt8] = $0.targetSpeed?.propertyBytes(0x02) ?? []

            return commandPrefix(for: AACruiseControl.self, messageType: .controlCruiseControl) + activationBytes + speedBytes
        }
    }

    static var getCruiseControlState: [UInt8] {
        return commandPrefix(for: AACruiseControl.self, messageType: .getCruiseControlState)
    }
}
