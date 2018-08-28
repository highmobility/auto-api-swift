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
//  WeatherConditions.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 07/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct WeatherConditions: FullStandardCommand {

    public let rainIntensity: PercentageInt?


    // MARK: FullStandardCommand

    public let properties: Properties


    init?(properties: Properties) {
        // Ordered by the ID
        rainIntensity = properties.value(for: 0x01)

        // Properties
        self.properties = properties
    }
}

extension WeatherConditions: Identifiable {

    public static var identifier: Identifier = Identifier(0x0055)
}

extension WeatherConditions: MessageTypesGettable {

    public enum MessageTypes: UInt8, MessageTypesKind {

        case getWeatherConditions   = 0x00
        case weatherConditions      = 0x01


        public static var all: [WeatherConditions.MessageTypes] {
            return [self.getWeatherConditions,
                    self.weatherConditions]
        }
    }
}

public extension WeatherConditions {

    static var getWeatherConditions: [UInt8] {
        return commandPrefix(for: .getWeatherConditions)
    }
}
