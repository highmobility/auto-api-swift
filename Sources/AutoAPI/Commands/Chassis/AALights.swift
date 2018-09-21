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
//  AALights.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 30/11/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation

#if os(iOS) || os(tvOS)
    import UIKit
#endif


public struct AALights: AAFullStandardCommand {

    public let ambientColour: AAColour?
    public let emergencyBrakeState: AAActiveState?
    public let frontExterior: AAFrontLightState?
    public let interiorState: AAActiveState?
    public let rearExteriorState: AAActiveState?
    public let reverseState: AAActiveState?


    // MARK: AAFullStandardCommand

    public let properties: AAProperties


    init?(properties: AAProperties) {
        // Ordered by the ID
        frontExterior = AAFrontLightState(rawValue: properties.first(for: 0x01)?.monoValue)
        rearExteriorState = AAActiveState(rawValue: properties.first(for: 0x02)?.monoValue)
        interiorState = AAActiveState(rawValue: properties.first(for: 0x03)?.monoValue)
        ambientColour = properties.first(for: 0x04)?.value.colour
        reverseState = AAActiveState(rawValue: properties.first(for: 0x05)?.monoValue)
        emergencyBrakeState = AAActiveState(rawValue: properties.first(for: 0x06)?.monoValue)

        // Properties
        self.properties = properties
    }


    // MARK: Methods

    private static func getColour(from bytes: [UInt8]?) -> AAColour? {
        guard let bytes = bytes, bytes.count == 3 else {
            return nil
        }

        let red = CGFloat(bytes[0]) / 255.0
        let green = CGFloat(bytes[1]) / 255.0
        let blue = CGFloat(bytes[2]) / 255.0

        return AAColour(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

extension AALights: AAIdentifiable {

    public static var identifier: AACommandIdentifier = AACommandIdentifier(0x0036)
}

extension AALights: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getLightsState = 0x00
        case lightsState    = 0x01
        case controlLights  = 0x02
    }
}

public extension AALights {

    static var getLightsState: [UInt8] {
        return commandPrefix(for: .getLightsState)
    }

    static func controlLights(frontExterior: AAFrontLightState? = nil,
                              rearExterior: AAActiveState? = nil,
                              interior: AAActiveState? = nil,
                              ambientColour: AAColour? = nil) -> [UInt8] {

        return commandPrefix(for: .controlLights) + [frontExterior?.propertyBytes(0x01),
                                                     rearExterior?.propertyBytes(0x02),
                                                     interior?.propertyBytes(0x03),
                                                     ambientColour?.propertyBytes(0x04)].propertiesValuesCombined
    }


    // MARK: Deprecated

    @available(*, deprecated, message: "Use the method .controlLights(frontExterior:rearExterior:interior:ambientColour:)")
    typealias Control = (frontExterior: AAFrontLightState?, rearExteriorState: AAActiveState?, interiorState: AAActiveState, ambientColour: AAColour?)

    @available(*, deprecated, renamed: "controlLights(frontExterior:rearExterior:interior:ambientColour:)")
    static var controlLights: (Control) -> [UInt8] {
        return {
            return controlLights(frontExterior: $0.frontExterior,
                                 rearExterior: $0.rearExteriorState,
                                 interior: $0.interiorState,
                                 ambientColour: $0.ambientColour)
        }
    }
}

private extension Collection where Element == UInt8 {

    var colour: AAColour? {
        guard count == 3 else {
            return nil
        }

        let red = CGFloat(bytes[0]) / 255.0
        let green = CGFloat(bytes[1]) / 255.0
        let blue = CGFloat(bytes[2]) / 255.0

        return AAColour(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
