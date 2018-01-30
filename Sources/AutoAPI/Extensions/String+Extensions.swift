//
// AutoAPI
// Copyright (C) 2017 High-Mobility GmbH
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program. If not, see http://www.gnu.org/licenses/.
//
// Please inquire about commercial licensing options at
// licensing@high-mobility.com
//
//
//  String+Extensions.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 12/12/2017.
//  Copyright © 2017 High Mobility. All rights reserved.
//

import Foundation


extension String {

    var bytes: [UInt8] {
        return characterPairs.flatMap { UInt8($0, radix: 16) }
    }

    var characterPairs: [String] {
        let startEmptyStringPairsArray: [String] = []

        return enumerated().reduce(startEmptyStringPairsArray) { (midResult, enumerationTuple) in
            var result = midResult

            if (enumerationTuple.offset % 2) == 1 {
                result[result.endIndex - 1] = midResult.last! + enumerationTuple.element.description
            }
            else {
                result.append(enumerationTuple.element.description)
            }

            return result
        }
    }


    init(format: String, _ arguments: CVarArg?...) {
        if arguments.contains(where: { $0 == nil }) {
            self.init("nil")
        }
        else {
            self.init(format: format, arguments: arguments.flatMap { $0 })
        }
    }

    init?<S>(bytes: S?, encoding: String.Encoding) where S : Sequence, S.Element == UInt8 {
        guard let bytes = bytes else {
            return nil
        }

        self.init(bytes: bytes, encoding: encoding)
    }
}

extension String: PropertyConvertable {

    var propertyValue: [UInt8] {
        return data(using: .utf8)?.bytesArray ?? []
    }
}
