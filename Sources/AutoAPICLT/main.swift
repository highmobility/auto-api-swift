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
//  main.swift
//  AutoAPI CLT
//
//  Created by Mikk Rätsep on 21/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import AutoAPI
import Foundation
import HMUtilities


var expandProperties = false


func main() {
    let arguments = CommandLine.arguments

    // Verify required input count
    guard arguments.count >= 2 else {
        return printHelp()
    }

    let flags = arguments[1...].filter { $0.starts(with: "-") }
    let input = arguments[1...].filter { !$0.starts(with: "-") }.joined()
    var bytes: [UInt8]

    // Check for flags
    if flags.contains("-b64") {
        guard let data = Data(base64Encoded: input) else {
            return print(" INVALID INPUT - base64 data can't be extracted")
        }

        bytes = data.bytes
    }
    else if flags.contains("-dc") {
        bytes = developerCenterBytes(input)
    }
    else {
        bytes = defaultBytes(input)
    }

    if flags.contains("-ep") {
        expandProperties = true
    }

    // If the Secure Custom Container is used as input – remove the non AutoAPI bytes
    if bytes.prefix(2) == [0x36, 0x01] {
        bytes.removeFirst(4)
        bytes.removeLast(32)
    }

    guard let parsed = AutoAPI.parseBinary(bytes) else {
        return print(" INVALID AUTOAPI DATA")
    }

    print(parsed.debugTree.stringValue)
}


print()
main()
print()
