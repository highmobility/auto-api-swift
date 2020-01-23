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
//  Door.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 29/11/2017.
//

import Foundation


public struct Door: Item {

    public typealias Location = Position


    public let location: Location
    public let lock: LockState
    public let position: PositionState


    // MARK: Item

    static let size: Int = 3
}

extension Door: BinaryInitable {

    init?(bytes: [UInt8]) {
        guard let location = Location(rawValue: bytes[0]),
            let position = PositionState(rawValue: bytes[1]),
            let lock = LockState(rawValue: bytes[2]) else {
                return nil
        }

        self.location = location
        self.lock = lock
        self.position = position
    }
}
