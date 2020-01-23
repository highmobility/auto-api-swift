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
//  RemoteControl.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 12/12/2017.
//

import Foundation


public struct RemoteControl: FullStandardCommand {

    public let angle: Int16?
    public let controlMode: ControlMode?


    // MARK: FullStandardCommand

    public let properties: Properties


    init?(properties: Properties) {
        // Ordered by the ID
        controlMode = ControlMode(rawValue: properties.first(for: 0x01)?.monoValue)
        angle = properties.value(for: 0x02)

        // Properties
        self.properties = properties
    }
}

extension RemoteControl: Identifiable {

    public static var identifier: Identifier = Identifier(0x0027)
}

extension RemoteControl: MessageTypesGettable {

    public enum MessageTypes: UInt8, MessageTypesKind {

        case getControlMode     = 0x00
        case controlMode        = 0x01
        case startControlMode   = 0x02
        case stopControlMode    = 0x03
        case controlCommand     = 0x04


        public static var all: [RemoteControl.MessageTypes] {
            return [self.getControlMode,
                    self.controlMode,
                    self.startControlMode,
                    self.stopControlMode,
                    self.controlCommand]
        }
    }
}

public extension RemoteControl {

    struct Control {
        public let speed: Int8?
        public let angle: Int16?

        public init(speed: Int8?, angle: Int16?) {
            self.speed = speed
            self.angle = angle
        }
    }


    static var controlCommand: (Control) -> [UInt8] {
        return {
            let speedBytes: [UInt8] = $0.speed?.propertyBytes(0x01) ?? []
            let angleBytes: [UInt8] = $0.angle?.propertyBytes(0x02) ?? []

            return commandPrefix(for: .controlCommand) + speedBytes + angleBytes
        }
    }

    static var getControlMode: [UInt8] {
        return commandPrefix(for: .getControlMode)
    }

    static var startControlMode: [UInt8] {
        return commandPrefix(for: .startControlMode)
    }

    static var stopControlMode: [UInt8] {
        return commandPrefix(for: .stopControlMode)
    }
}
