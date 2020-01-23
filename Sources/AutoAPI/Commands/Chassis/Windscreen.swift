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
//  Windscreen.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 01/12/2017.
//

import Foundation


public struct Windscreen: FullStandardCommand {

    public typealias ZonePosition = Zone


    // MARK: Properties

    public let damage: WindscreenDamage?
    public let damageConfidence: PercentageInt?
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
