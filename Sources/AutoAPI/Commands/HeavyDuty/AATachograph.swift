//
// AutoAPITests
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
//  AATachograph.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 30/04/2018.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct AATachograph: AAFullStandardCommand {

    public let driversCards: [AAProperty<AADriverCard>]?
    public let driversTimeStates: [AAProperty<AADriverTimeState>]?
    public let driversWorkingStates: [AAProperty<AADriverWorkingState>]?
    public let vehicleDirection: AAProperty<AADirection>?
    public let vehicleMotionState: AAProperty<AAMovingState>?
    public let vehicleOverspeedActive: AAProperty<AAActiveState>?
    public let vehicleSpeed: AAProperty<Int16>?


    // MARK: AAFullStandardCommand

    public let properties: AAProperties


    init?(properties: AAProperties) {
        // Ordered by the ID
        driversWorkingStates = properties.properties(for: \AATachograph.driversWorkingStates)
        driversTimeStates = properties.properties(for: \AATachograph.driversTimeStates)
        driversCards = properties.properties(for: \AATachograph.driversCards)
        vehicleDirection = properties.property(for: \AATachograph.vehicleDirection)
        vehicleMotionState = properties.property(for: \AATachograph.vehicleMotionState)
        vehicleOverspeedActive = properties.property(for: \AATachograph.vehicleOverspeedActive)
        vehicleSpeed = properties.property(for: \AATachograph.vehicleSpeed)

        // Properties
        self.properties = properties
    }
}

extension AATachograph: AAIdentifiable {

    public static var identifier: AACommandIdentifier = 0x0064
}

extension AATachograph: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getState = 0x00
        case state    = 0x01
    }
}

extension AATachograph: AAPropertyIdentifierGettable {

    static func propertyID<Type>(for keyPath: KeyPath<AATachograph, Type>) -> AAPropertyIdentifier? {
        switch keyPath {
        case \AATachograph.driversWorkingStates:    return 0x01
        case \AATachograph.driversTimeStates:       return 0x02
        case \AATachograph.driversCards:            return 0x03
        case \AATachograph.vehicleDirection:        return 0x06
        case \AATachograph.vehicleMotionState:      return 0x04
        case \AATachograph.vehicleOverspeedActive:  return 0x05
        case \AATachograph.vehicleSpeed:            return 0x07

        default:
            return nil
        }
    }
}

public extension AATachograph {

    static var getState: [UInt8] {
        return commandPrefix(for: .getState)
    }
}
