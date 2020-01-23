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
//  TrunkAccess.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 24/11/2017.
//

import Foundation


public struct TrunkAccess: FullStandardCommand {

    public let lock: LockState?
    public let position: PositionState?


    // MARK: FullStandardCommand

    public let properties: Properties


    init?(properties: Properties) {
        // Ordered by the ID
        lock = LockState(rawValue: properties.first(for: 0x01)?.monoValue)
        position = PositionState(rawValue: properties.first(for: 0x02)?.monoValue)

        // Properties
        self.properties = properties
    }
}

extension TrunkAccess: Identifiable {

    public static var identifier: Identifier = Identifier(0x0021)
}

extension TrunkAccess: MessageTypesGettable {

    public enum MessageTypes: UInt8, MessageTypesKind {

        case getTrunkState  = 0x00
        case trunkState     = 0x01
        case openCloseTrunk = 0x02


        public static var all: [TrunkAccess.MessageTypes] {
            return [self.getTrunkState,
                    self.trunkState,
                    self.openCloseTrunk]
        }
    }
}

public extension TrunkAccess {

    struct Settings {
        public let lock: LockState?
        public let position: PositionState?

        public init(lock: LockState?, position: PositionState?) {
            self.lock = lock
            self.position = position
        }
    }


    static var getTrunkState: [UInt8] {
        return commandPrefix(for: .getTrunkState)
    }

    static var openClose: (Settings) -> [UInt8] {
        return {
            let lockBytes: [UInt8] = $0.lock?.propertyBytes(0x01) ?? []
            let positionBytes: [UInt8] = $0.position?.propertyBytes(0x02) ?? []

            return commandPrefix(for: .openCloseTrunk) + lockBytes + positionBytes
        }
    }
}
