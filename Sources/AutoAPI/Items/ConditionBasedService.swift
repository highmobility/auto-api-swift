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
//  ConditionBasedService.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 28/08/2018.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


/*

 date:2017-09
 description:Next change at specified date at the latest.

 id:3
 messageType:CBS
 status:OK
 text:Brake fluid
 date:2017- 09
 description:Next visual inspection after specified distance travelled or on given date.

 id:17
 messageType:CBS
 status:OK
 text:Vehicle check
 date:2018-10
 description:Next mandatory vehicle inspection on specified date.

 id:32
 messageType:CBS
 status:OK
 text:§ Vehicle inspection


 Possible status values:
 OK means “Service not due“.
 PENDING means “Service imminently due“.
 OVERDUE means “Service overdue“.


 pane property'sse sisse stringide suurused ja kõik kokku ühe alla

 */

public struct ConditionBasedService {

    public let status: DueStatus
    public let text: String
    public let date: Date
    public let description: Stream
}

extension ConditionBasedService: BinaryInitable {

    init?<C>(_ binary: C) where C : Collection, C.Element == UInt8 {
        // TODO: This won't work – there's NO FIXED bytes for them strings
        // TODO: Might need to concot a sub-property structure for these kinds of things
        return nil
    }
}
