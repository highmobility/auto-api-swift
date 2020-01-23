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
//  DoorLocks.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 24/11/2017.
//

import Foundation


public struct DoorLocks: FullStandardCommand {

    public let doors: [Door]?
    public let insideLocks: [DoorLock]?
    public let outsideLocks: [DoorLock]?


    // MARK: FullStandardCommand

    public let properties: Properties


    init?(properties: Properties) {
        // Ordered by the ID
        doors = properties.flatMap(for: 0x01) { Door($0.value) }
        insideLocks = properties.flatMap(for: 0x02) { DoorLock($0.value) }
        outsideLocks = properties.flatMap(for: 0x03) { DoorLock($0.value) }

        // Properties
        self.properties = properties
    }
}

extension DoorLocks: Identifiable {

    public static var identifier: Identifier = Identifier(0x0020)
}

extension DoorLocks: MessageTypesGettable {

    public enum MessageTypes: UInt8, MessageTypesKind {

        case getLockState       = 0x00
        case lockState          = 0x01
        case lockUnlockDoors    = 0x02


        public static var all: [DoorLocks.MessageTypes] {
            return [self.getLockState,
                    self.lockState,
                    self.lockUnlockDoors]
        }
    }
}

public extension DoorLocks {

    static var getLockState: [UInt8] {
        return commandPrefix(for: .getLockState)
    }

    static var lockUnlock: (LockState) -> [UInt8] {
        return {
            return commandPrefix(for: .lockUnlockDoors, additionalBytes: $0.rawValue)
        }
    }
}
