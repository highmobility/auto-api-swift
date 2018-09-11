//
// AutoAPI
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
//  CheckControlMessage.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 28/08/2018.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


/*

 {
    "name":"bmwcardata_checkControlMessages",
    "timestamp":"Thu Aug 31 14:21:53 CEST 2017",
    "unit":"- ",
    "value":"[{
        "id":143,
        "messageType":"CCM",
        "status":"ZERO",
        "text":"Tyre pressure loss. Caution stop",
        "unitOfLengthRemaining":"105592"
    }]
 "}

 */

public struct CheckControlMessage {

//    public let id: Int        // Not sure if this is useful here
//    public let type: String   // CCM denotes Check Control Message
    public let status: String
    public let text: String
    public let remainingLength: Int
}

extension CheckControlMessage: BinaryInitable {

    init?<C>(_ binary: C) where C : Collection, C.Element == UInt8 {
        // TODO: This won't work – there's NO FIXED bytes for them strings
        // TODO: Might need to concot a sub-property structure for these kinds of things
        return nil
    }
}
