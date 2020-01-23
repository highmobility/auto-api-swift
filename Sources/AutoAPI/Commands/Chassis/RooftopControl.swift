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
//  RooftopControl.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 01/12/2017.
//

import Foundation


public struct RooftopControl: FullStandardCommand {

    public let dimming: PercentageInt?
    public let position: PercentageInt?


    // MARK: FullStandardCommand

    public let properties: Properties


    init?(properties: Properties) {
        // Ordered by the ID
        dimming = properties.value(for: 0x01)
        position = properties.value(for: 0x02)

        // Properties
        self.properties = properties
    }
}

extension RooftopControl: Identifiable {

    public static var identifier: Identifier = Identifier(0x0025)
}

extension RooftopControl: MessageTypesGettable {

    public enum MessageTypes: UInt8, MessageTypesKind {

        case getRooftopState    = 0x00
        case rooftopState       = 0x01
        case controlRooftop     = 0x02


        public static var all: [RooftopControl.MessageTypes] {
            return [self.getRooftopState,
                    self.rooftopState,
                    self.controlRooftop]
        }
    }
}

public extension RooftopControl {

    struct Control {
        public let dimming: PercentageInt?
        public let openClose: PercentageInt?

        public init(dimming: PercentageInt?, openClose: PercentageInt?) {
            self.dimming = dimming
            self.openClose = openClose
        }
    }


    static var controlRooftop: (Control) -> [UInt8] {
        return {
            let dimmingBytes: [UInt8] = $0.dimming?.propertyBytes(0x01) ?? []
            let openCloseBytes: [UInt8] = $0.openClose?.propertyBytes(0x02) ?? []

            return commandPrefix(for: .controlRooftop) + dimmingBytes + openCloseBytes
        }
    }

    static var getRooftopState: [UInt8] {
        return commandPrefix(for: .getRooftopState)
    }
}
