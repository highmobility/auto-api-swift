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
//  AAWindscreen.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 01/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct AAWindscreen: AAFullStandardCommand {

    public let damage: AAProperty<AAWindscreenDamage>?
    public let damageConfidence: AAProperty<AAPercentageInt>?
    public let damageDetectionTime: AAProperty<Date>?

    /// The *position* of the *damage* on the Windscreen.
    public let damageZone: AAProperty<AAZone>?
    public let needsReplacement: AAProperty<AANeedsReplacement>?

    /// The *size* of *zones* on the Windscreen.
    public let zoneMatrix: AAProperty<AAZone>?
    public let wipersIntensity: AAProperty<AAWipersIntensity>?
    public let wipersState: AAProperty<AAWipersState>?


    // MARK: AAFullStandardCommand

    public let properties: AAProperties


    init?(properties: AAProperties) {
        // Ordered by the ID
        wipersState = properties.property(for: \AAWindscreen.wipersState)
        wipersIntensity = properties.property(for: \AAWindscreen.wipersIntensity)
        damage = properties.property(for: \AAWindscreen.damage)
        zoneMatrix = properties.property(for: \AAWindscreen.zoneMatrix)
        damageZone = properties.property(for: \AAWindscreen.damageZone)
        needsReplacement = properties.property(for: \AAWindscreen.needsReplacement)
        damageConfidence = properties.property(for: \AAWindscreen.damageConfidence)
        damageDetectionTime = properties.property(for: \AAWindscreen.damageDetectionTime)

        // Properties
        self.properties = properties
    }
}

extension AAWindscreen: AAIdentifiable {

    public static var identifier: AACommandIdentifier = 0x0042
}

extension AAWindscreen: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getWindscreenState     = 0x00
        case windscreenState        = 0x01
        case setDamage              = 0x12
        case setNeedsReplacement    = 0x13
        case activateWipers         = 0x14
    }
}

extension AAWindscreen: AAPropertyIdentifierGettable {

    static func propertyID<Type>(for keyPath: KeyPath<AAWindscreen, Type>) -> AAPropertyIdentifier? {
        switch keyPath {
        case \AAWindscreen.wipersState:         return 0x01
        case \AAWindscreen.wipersIntensity:     return 0x02
        case \AAWindscreen.damage:              return 0x03
        case \AAWindscreen.zoneMatrix:          return 0x04
        case \AAWindscreen.damageZone:          return 0x05
        case \AAWindscreen.needsReplacement:    return 0x06
        case \AAWindscreen.damageConfidence:    return 0x07
        case \AAWindscreen.damageDetectionTime: return 0x08

        default:
            return nil
        }
    }
}

public extension AAWindscreen {

    static var getWindscreenState: [UInt8] {
        return commandPrefix(for: .getWindscreenState)
    }


    static func controlWipers(_ state: AAWipersState, intensity: AAWipersIntensity?) -> [UInt8] {
        return commandPrefix(for: .activateWipers) + [state.propertyBytes(0x01),
                                                      intensity?.propertyBytes(0x02)].propertiesValuesCombined
    }

    static func setDamage(_ damage: AAWindscreenDamage, in zone: AAZone) -> [UInt8] {
        return commandPrefix(for: .setDamage) + [damage.propertyBytes(0x01),
                                                 zone.propertyBytes(0x02)].propertiesValuesCombined
    }

    static func setNeedsReplacement(_ needsReplacement: AANeedsReplacement) -> [UInt8] {
        return commandPrefix(for: .setNeedsReplacement) + needsReplacement.propertyBytes(0x01)
    }
}
