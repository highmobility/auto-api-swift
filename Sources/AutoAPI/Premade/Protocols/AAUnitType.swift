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
//  AAUnitType.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 11.06.20.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation


public protocol AAUnitType: Dimension, Codable {

    static var measurementID: UInt8 { get }
    static func create(id: UInt8) -> Self?

    var identifiers: [UInt8]? { get }
}


enum AAUnitTypeCodingKeys: String, CodingKey {
    case identifier
}


public extension AAUnitType {

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AAUnitTypeCodingKeys.self)
        let id = try container.decode(UInt8.self, forKey: .identifier)

        guard let me = Self.create(id: id) else {
            throw DecodingError.dataCorruptedError(forKey: AAUnitTypeCodingKeys.identifier,
                                                   in: container,
                                                   debugDescription: "Failed to create the Unit from an id: \(id)")
        }

        self.init(symbol: me.symbol, converter: me.converter)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: AAUnitTypeCodingKeys.self)

        try container.encodeIfPresent(self.identifiers?.last, forKey: .identifier)
    }
}
