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
//  Windows.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 01/12/2017.
//

import Foundation


public struct Windows: FullStandardCommand, Sequence {

    public let windows: [Window]?


    // MARK: FullStandardCommand

    public let properties: Properties


    init?(properties: Properties) {
        // Ordered by the ID
        windows = properties.flatMap(for: 0x01) { Window($0.value) }

        // Properties
        self.properties = properties
    }


    // MARK: Sequence

    public typealias Iterator = WindowsIterator


    public func makeIterator() -> WindowsIterator {
        return WindowsIterator(properties.filter(for: 0x01).flatMap { $0.bytes })
    }
}

extension Windows: Identifiable {

    public static var identifier: Identifier = Identifier(0x0045)
}

extension Windows: MessageTypesGettable {

    public enum MessageTypes: UInt8, MessageTypesKind {

        case getWindowsState    = 0x00
        case windowsState       = 0x01
        case openCloseWindows   = 0x02


        public static var all: [Windows.MessageTypes] {
            return [self.getWindowsState,
                    self.windowsState,
                    self.openCloseWindows]
        }
    }
}

public extension Windows {

    static var getWindowsState: [UInt8] {
        return commandPrefix(for: .getWindowsState)
    }

    static var openClose: ([Window]) -> [UInt8] {
        return {
            return commandPrefix(for: .openCloseWindows) + $0.flatMap { $0.propertyBytes(0x01) }
        }
    }
}
