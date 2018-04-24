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
//  Windscreen.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 01/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct Windscreen: FullStandardCommand {

    public typealias ZonePosition = Zone


    // MARK: Properties

    public let damage: WindscreenDamage?
    public let damageConfidence: UInt8?
    public let damageDetectionTime: YearTime?
    /// The *position* of the *damage* on the Windscreen.
    public let damageZone: ZonePosition?
    public let needsReplacement: NeedsReplacement?
    /// The *size* of *zones* on the Windscreen.
    public let zoneMatrix: Zone?
    public let wipersIntensity: WipersLevel?
    public let wipersState: WipersState?


    // MARK: FullStandardCommand

    public let properties: Properties


    init?(properties: Properties) {
        // Ordered by the ID
        wipersState = WipersState(rawValue: properties.first(for: 0x01)?.monoValue)
        wipersIntensity = WipersLevel(rawValue: properties.first(for: 0x02)?.monoValue)
        damage = WindscreenDamage(rawValue: properties.first(for: 0x03)?.monoValue)
        zoneMatrix = Zone(rawValue: properties.first(for: 0x04)?.monoValue)
        damageZone = ZonePosition(rawValue: properties.first(for: 0x05)?.monoValue)
        needsReplacement = NeedsReplacement(rawValue: properties.first(for: 0x06)?.monoValue)
        damageConfidence = properties.value(for: 0x07)
        damageDetectionTime = properties.value(for: 0x08)

        // Properties
        self.properties = properties
    }
}

extension Windscreen: Identifiable {

    public static var identifier: Identifier = Identifier(0x0042)
}

extension Windscreen: MessageTypesGettable {

    public enum MessageTypes: UInt8, MessageTypesKind {

        case getWindscreenState     = 0x00
        case windscreenState        = 0x01
        case setWindscreenDamage    = 0x02


        public static var all: [Windscreen.MessageTypes] {
            return [self.getWindscreenState,
                    self.windscreenState,
                    self.setWindscreenDamage]
        }
    }
}

public extension Windscreen {

    struct Damage {
        public let damage: WindscreenDamage
        public let zone: ZonePosition
        public let needsReplacement: NeedsReplacement

        public init(damage: WindscreenDamage, zone: ZonePosition, needsReplacement: NeedsReplacement) {
            self.damage = damage
            self.zone = zone
            self.needsReplacement = needsReplacement
        }
    }


    static var getWindscreenState: [UInt8] {
        return commandPrefix(for: .getWindscreenState)
    }

    static var setWindscreenDamage: (Damage) -> [UInt8] {
        return {
            let damageBytes = $0.damage.propertyBytes(0x03)
            let zoneBytes = $0.zone.propertyBytes(0x05)
            let replacementBytes = $0.needsReplacement.propertyBytes(0x06)

            return commandPrefix(for: .setWindscreenDamage) + damageBytes + zoneBytes + replacementBytes
        }
    }
}
