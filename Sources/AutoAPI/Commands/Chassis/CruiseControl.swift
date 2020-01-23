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
//  CruiseControl.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 24/04/2018.
//

import Foundation


public struct CruiseControl: FullStandardCommand {

    public let adaptiveTargetSpeed: Int16?
    public let isActive: Bool?
    public let isAdaptiveActive: Bool?
    public let limiter: CruiseControlLimiter?
    public let targetSpeed: Int16?


    // MARK: FullStandardCommand

    public var properties: Properties


    init?(properties: Properties) {
        // Ordered by the ID
        isActive = properties.value(for: 0x01)
        limiter = CruiseControlLimiter(rawValue: properties.first(for: 0x02)?.monoValue)
        targetSpeed = properties.value(for: 0x03)
        isAdaptiveActive = properties.value(for: 0x04)
        adaptiveTargetSpeed = properties.value(for: 0x05)

        // Properties
        self.properties = properties
    }
}

extension CruiseControl: Identifiable {

    public static var identifier: Identifier = Identifier(0x0062)
}

extension CruiseControl: MessageTypesGettable {

    public enum MessageTypes: UInt8, MessageTypesKind {

        case getCruiseControlState  = 0x00
        case cruiseControlState     = 0x01
        case controlCruiseControl   = 0x02


        public static var all: [CruiseControl.MessageTypes] {
            return [self.getCruiseControlState,
                    self.cruiseControlState,
                    self.controlCruiseControl]
        }
    }
}

public extension CruiseControl {

    struct Control {
        public let isActive: Bool
        public let targetSpeed: Int16?

        public init(isActive: Bool, targetSpeed: Int16?) {
            self.isActive = isActive
            self.targetSpeed = targetSpeed
        }
    }


    static var activateCruiseControl: (Control) -> [UInt8] {
        return {
            let activationBytes = $0.isActive.propertyBytes(0x01)
            let speedBytes: [UInt8] = $0.targetSpeed?.propertyBytes(0x02) ?? []

            return commandPrefix(for: .controlCruiseControl) + activationBytes + speedBytes
        }
    }

    static var getCruiseControlState: [UInt8] {
        return commandPrefix(for: .getCruiseControlState)
    }
}
