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
//  CapabilitiesIterator.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 27/11/2017.
//

import Foundation


public struct CapabilitiesIterator: IteratorProtocol, PropertiesInitable {

    private let commandTypes = AAAutoAPI.commands.compactMap { $0 as? Command.Type }


    // MARK: IteratorProtocol

    public typealias Element = Capability


    public mutating func next() -> Capability? {
        guard let property = propertiesIterator.next() else {
            return nil
        }

        let identifier = Identifier(property.value.prefix(2))

        guard let command = commandTypes.first(where: { $0.identifier == identifier }) else {
            return nil
        }

        return Capability(binary: property.value, command: command)
    }


    // MARK: PropertiesInitable

    var propertiesIterator: PropertiesIterator
}
