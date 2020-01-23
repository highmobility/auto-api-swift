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
//  StartStop.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 24/04/2018.
//

import Foundation


public struct StartStop: FullStandardCommand {

    public let isActive: Bool?


    // MARK: FullStandardCommand

    public var properties: Properties


    init?(properties: Properties) {
        // Ordered by the ID
        isActive = properties.value(for: 0x01)

        // Properties
        self.properties = properties
    }
}

extension StartStop: Identifiable {

    public static var identifier: Identifier = Identifier(0x0063)
}

extension StartStop: MessageTypesGettable {

    public enum MessageTypes: UInt8, MessageTypesKind {

        case getStartStopState              = 0x00
        case startStopState                 = 0x01
        case activateDeactivateStartStop    = 0x02


        public static var all: [StartStop.MessageTypes] {
            return [self.getStartStopState,
                    self.startStopState,
                    self.activateDeactivateStartStop]
        }
    }
}

public extension StartStop {

    static var getStartStopState: [UInt8] {
        return commandPrefix(for: .getStartStopState)
    }

    /// Use `false` to *deactivate* the start-stop system.
    static var activateStartStop: (Bool) -> [UInt8] {
        return {
            return commandPrefix(for: .activateDeactivateStartStop) + $0.propertyBytes(0x01)
        }
    }
}
