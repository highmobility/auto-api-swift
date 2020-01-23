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
//  ChassisSettings.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/12/2017.
//

import Foundation


public struct ChassisSettings: FullStandardCommand {

    public let chassisPosition: ChassisPosition?
    public let drivingMode: DrivingMode?
    public let isSportChroneActive: Bool?
    public let springRates: [SpringRate]?


    // MARK: FullStandardCommand

    public let properties: Properties


    init?(properties: Properties) {
        // Ordered by the ID
        drivingMode = DrivingMode(rawValue: properties.first(for: 0x01)?.monoValue)
        isSportChroneActive = properties.value(for: 0x02)
        springRates = properties.flatMap(for: 0x03) { SpringRate($0.value) }
        chassisPosition = ChassisPosition(bytes: properties.first(for: 0x04)?.value)

        // Properties
        self.properties = properties
    }
}

extension ChassisSettings: Identifiable {

    public static var identifier: Identifier = Identifier(0x0053)
}

extension ChassisSettings: MessageTypesGettable {

    public enum MessageTypes: UInt8, MessageTypesKind {

        case getChassisSettings     = 0x00
        case chassisSettings        = 0x01
        case setDrivingMode         = 0x02
        case startStopSportChrono   = 0x03
        case setSpringRate          = 0x04
        case setChassisPosition     = 0x05


        public static var all: [ChassisSettings.MessageTypes] {
            return [self.getChassisSettings,
                    self.chassisSettings,
                    self.setDrivingMode,
                    self.startStopSportChrono,
                    self.setSpringRate,
                    self.setChassisPosition]
        }
    }
}

public extension ChassisSettings {

    static var getChassisSettings: [UInt8] {
        return commandPrefix(for: .getChassisSettings)
    }

    static var setChassisPosition: (UInt8) -> [UInt8] {
        return {
            return commandPrefix(for: .setChassisPosition, additionalBytes: $0)
        }
    }

    static var setDrivingMode: (DrivingMode) -> [UInt8] {
        return {
            return commandPrefix(for: .setDrivingMode, additionalBytes: $0.rawValue)
        }
    }

    static var setSpringRate: (Axle, UInt8) -> [UInt8] {
        return {
            return commandPrefix(for: .setSpringRate, additionalBytes: $0.rawValue, $1)
        }
    }

    static var startStopSportChrono: (StartStopChrono) -> [UInt8] {
        return {
            return commandPrefix(for: .startStopSportChrono, additionalBytes: $0.rawValue)
        }
    }
}
