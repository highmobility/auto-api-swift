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
//  Tachograph.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 30/04/2018.
//

import Foundation


public struct Tachograph: FullStandardCommand {

    public let driversCards: [DriverCard]?
    public let driversTimeStates: [DriverTimeState]?
    public let driversWorkingStates: [DriverWorkingState]?
    public let isVehicleMotionDetected: Bool?
    public let isVehicleOverspeed: Bool?
    public let vehicleDirection: Direction?
    public let vehicleSpeed: Int16?


    // MARK: FullStandardCommand

    public var properties: Properties


    init?(properties: Properties) {
        // Ordered by the ID
        driversWorkingStates = properties.flatMap(for: 0x01) { DriverWorkingState($0.value) }
        driversTimeStates = properties.flatMap(for: 0x02) { DriverTimeState($0.value) }
        driversCards = properties.flatMap(for: 0x03) { DriverCard($0.value) }
        isVehicleMotionDetected = properties.value(for: 0x04)
        isVehicleOverspeed = properties.value(for: 0x05)
        vehicleDirection = Direction(rawValue: properties.first(for: 0x06)?.monoValue)
        vehicleSpeed = properties.value(for: 0x07)

        // Properties
        self.properties = properties
    }
}

extension Tachograph: Identifiable {

    public static var identifier: Identifier = Identifier(0x0064)
}

extension Tachograph: MessageTypesGettable {

    public enum MessageTypes: UInt8, MessageTypesKind {

        case getTachographState = 0x00
        case tachographState    = 0x01


        public static var all: [Tachograph.MessageTypes] {
            return [self.getTachographState,
                    self.tachographState]
        }
    }
}

public extension Tachograph {

    static var getTachographState: [UInt8] {
        return commandPrefix(for: .getTachographState)
    }
}
