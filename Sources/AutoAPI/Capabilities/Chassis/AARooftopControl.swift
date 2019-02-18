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
//  AARooftopControl.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 01/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public class AARooftopControl: AACapabilityClass, AACapability {

    public let convertibleRoofState: AAProperty<AAConvertibleRoofState>?
    public let dimming: AAProperty<AAPercentage>?
    public let position: AAProperty<AAPercentage>?
    public let sunroofTiltState: AAProperty<AATiltState>?
    public let sunroofState: AAProperty<AAPositionState>?


    // MARK: AACapability

    public static var identifier: AACommandIdentifier = 0x0025


    required init(properties: AAProperties) {
        // Ordered by the ID
        dimming = properties.property(forIdentifier: 0x01)
        position = properties.property(forIdentifier: 0x02)
        /* Level 8 */
        convertibleRoofState = properties.property(forIdentifier: 0x03)
        sunroofTiltState = properties.property(forIdentifier: 0x04)
        /* Level 9 */
        sunroofState = properties.property(forIdentifier: 0x05)

        super.init(properties: properties)
    }
}

extension AARooftopControl: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getRooftopState    = 0x00
        case rooftopState       = 0x01
        case controlRooftop     = 0x12
    }
}

public extension AARooftopControl {

    static var getRooftopState: AACommand {
        return command(forMessageType: .getRooftopState)
    }

    static func controlRooftop(dimming: AAPercentage?,
                               open: AAPercentage?,
                               convertibleRoof: AAConvertibleRoofState?,
                               sunroofTilt: AATiltState?,
                               sunroofState: AAPositionState?) -> AACommand {
        let properties = [dimming?.property(forIdentifier: 0x01),
                          open?.property(forIdentifier: 0x02),
                          convertibleRoof?.property(forIdentifier: 0x03),
                          sunroofTilt?.property(forIdentifier: 0x04),
                          sunroofState?.property(forIdentifier: 0x05)]

        return command(forMessageType: .controlRooftop, properties: properties)
    }
}
