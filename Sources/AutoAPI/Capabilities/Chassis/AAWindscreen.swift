//
// AutoAPI
// Copyright (C) 2019 High-Mobility GmbH
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
//  Copyright © 2019 High Mobility GmbH. All rights reserved.
//

import Foundation


public class AAWindscreen: AACapabilityClass, AACapability {

    public let damage: AAProperty<AAWindscreenDamage>?
    public let damageConfidence: AAProperty<AAPercentage>?
    public let damageDetectionTime: AAProperty<Date>?

    /// The *position* of the *damage* on the Windscreen.
    public let damageZone: AAProperty<AAZone>?
    public let needsReplacement: AAProperty<AANeedsReplacement>?

    /// The *size* of *zones* on the Windscreen.
    public let zoneMatrix: AAProperty<AAZone>?
    public let wipersIntensity: AAProperty<AAWipersIntensity>?
    public let wipersState: AAProperty<AAWipersState>?


    // MARK: AACapability

    public static var identifier: AACommandIdentifier = 0x0042


    required init(properties: AAProperties) {
        // Ordered by the ID
        wipersState = properties.property(forIdentifier: 0x01)
        wipersIntensity = properties.property(forIdentifier: 0x02)
        damage = properties.property(forIdentifier: 0x03)
        zoneMatrix = properties.property(forIdentifier: 0x04)
        damageZone = properties.property(forIdentifier: 0x05)
        needsReplacement = properties.property(forIdentifier: 0x06)
        damageConfidence = properties.property(forIdentifier: 0x07)
        damageDetectionTime = properties.property(forIdentifier: 0x08)

        super.init(properties: properties)
    }
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

public extension AAWindscreen {

    static var getWindscreenState: AACommand {
        return command(forMessageType: .getWindscreenState)
    }


    static func controlWipers(_ state: AAWipersState, intensity: AAWipersIntensity?) -> AACommand {
        let properties = [state.property(forIdentifier: 0x01),
                          intensity?.property(forIdentifier: 0x02)]

        return command(forMessageType: .activateWipers, properties: properties)
    }

    static func setDamage(_ damage: AAWindscreenDamage, in zone: AAZone) -> AACommand {
        let properties = [damage.property(forIdentifier: 0x01),
                          zone.property(forIdentifier: 0x02)]

        return command(forMessageType: .setDamage, properties: properties)
    }

    static func setNeedsReplacement(_ needsReplacement: AANeedsReplacement) -> AACommand {
        let properties = [needsReplacement.property(forIdentifier: 0x01)]

        return command(forMessageType: .setNeedsReplacement, properties: properties)
    }
}
