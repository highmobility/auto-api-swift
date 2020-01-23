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
//  Window.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 01/12/2017.
//

import Foundation


public struct Window: Item {

    public typealias OpenClosed = PositionState


    public let openClosed: OpenClosed
    public let position: Position


    // MARK: Item

    static let size: Int = 2


    // MARK: Init

    public init(openClosed: OpenClosed, position: Position) {
        self.openClosed = openClosed
        self.position = position
    }
}

extension Window: BinaryInitable {

    init?(bytes: [UInt8]) {
        guard let position = Position(rawValue: bytes[0]),
            let openClosed = OpenClosed(rawValue: bytes[1]) else {
                return nil
        }

        self.openClosed = openClosed
        self.position = position
    }
}

extension Window: Equatable {

    public static func ==(lhs: Window, rhs: Window) -> Bool {
        return (lhs.openClosed == rhs.openClosed) && (lhs.position == rhs.position)
    }
}

extension Window: PropertyConvertable {

    var propertyValue: [UInt8] {
        return [position.rawValue, openClosed.rawValue]
    }
}
