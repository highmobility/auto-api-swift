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
//  Race.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 07/12/2017.
//

import Foundation


public struct Race: FullStandardCommand {

    public let accelerations: [Acceleration]?
    public let brakePedalPosition: PercentageInt?
    public let brakePressure: Float?
    public let brakeTorqueVectorings: [BrakeTorqueVectoring]?
    public let gasPedalPosition: PercentageInt?
    public let gearMode: GearMode?
    public let isAcceleratorPedalIdleSwitchActive: Bool?
    public let isAcceleratorPedalKickdownSwitchActive: Bool?
    public let isBrakePedalSwitchActive: Bool?
    public let isClutchPedalSwitchActive: Bool?
    public let isESPActive: Bool?
    public let oversteering: PercentageInt?
    public let rearSuspensionSteering: Int8?
    public let selectedGear: Int8?
    public let steeringAngle: Int8?
    public let understeering: PercentageInt?
    public let yawRate: Float?


    // MARK: FullStandardCommand

    public let properties: Properties


    init?(properties: Properties) {
        // Ordered by the ID
        accelerations = properties.flatMap(for: 0x01) { Acceleration($0.value) }
        understeering = properties.value(for: 0x02)
        oversteering = properties.value(for: 0x03)
        gasPedalPosition = properties.value(for: 0x04)
        steeringAngle = properties.value(for: 0x05)
        brakePressure = properties.value(for: 0x06)
        yawRate = properties.value(for: 0x07)
        rearSuspensionSteering = properties.value(for: 0x08)
        isESPActive = properties.value(for: 0x09)
        brakeTorqueVectorings = properties.flatMap(for: 0x0A) { BrakeTorqueVectoring($0.value) }
        gearMode = GearMode(rawValue: properties.first(for: 0x0B)?.monoValue)
        selectedGear = properties.value(for: 0x0C)
        brakePedalPosition = properties.value(for: 0x0D)
        isBrakePedalSwitchActive = properties.value(for: 0x0E)
        isClutchPedalSwitchActive = properties.value(for: 0x0F)
        isAcceleratorPedalIdleSwitchActive = properties.value(for: 0x10)
        isAcceleratorPedalKickdownSwitchActive = properties.value(for: 0x11)

        // Properties
        self.properties = properties
    }
}

extension Race: Identifiable {

    public static var identifier: Identifier = Identifier(0x0057)
}

extension Race: MessageTypesGettable {

    public enum MessageTypes: UInt8, MessageTypesKind {

        case getRaceState   = 0x00
        case raceState      = 0x01


        public static var all: [Race.MessageTypes] {
            return [self.getRaceState,
                    self.raceState]
        }
    }
}

public extension Race {

    static var getRaceState: [UInt8] {
        return commandPrefix(for: .getRaceState)
    }
}
