//
// AutoAPI CLT
// Copyright (C) 2018 High-Mobility GmbH
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
//  Misc.swift
//  AutoAPI CLT
//
//  Created by Mikk Rätsep on 11/01/2018.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


func developerCenterBytes(_ input: String) -> [UInt8] {
    let filteredComponents = input.components(separatedBy: " ").filter { $0.contains("0x") }
    let items: [String] = filteredComponents.compactMap {
        guard let range = $0.range(of: "0x") else {
            return nil
        }

        let additionalOffset = ($0.last == ",") ? -1 : 0
        let offset = $0.count - range.upperBound.encodedOffset + additionalOffset
        let newRange = Range<String.Index>(uncheckedBounds: (lower: range.upperBound, upper: $0.index(range.upperBound, offsetBy: offset)))

        return String($0[newRange])
    }

    return items.joined().bytes
}

func defaultBytes(_ input: String) -> [UInt8] {
    let hexString = input
        .replacingOccurrences(of: "0x", with: "")
        .replacingOccurrences(of: ",", with: "")
        .replacingOccurrences(of: " ", with: "")
        .replacingOccurrences(of: "\n", with: "")

    return hexString.bytes
}


func printHelp() {
    print("  Enter HEX data after the command to parse it.")
    print()
    print("\tAllowed besides HEX:")
    print("\t - 0x")
    print("\t - commas")
    print("\t - spaces")
    print("\t - new line (i.e. when inside \"...\", or a var)")
    print()
    print("\tFlags:")
    print("\t -b64: input is in Base64")
    print("\t -dc:  input is like in Developer Center (0x00, 0x01 # Comment)")
    print("\t -ep:  expand properties")
    print()
    print("  Example: 10938A1 12B9C9 1239 0x1b, 0xc0ca")
}
