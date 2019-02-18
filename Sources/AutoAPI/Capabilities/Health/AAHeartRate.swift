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
//  AAHeartRate.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 12/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public class AAHeartRate: AACapabilityClass, AACapability {

    public static var identifier: AACommandIdentifier = 0x0029
}

extension AAHeartRate: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case sendRate = 0x12
    }
}

public extension AAHeartRate {

    static func sendRate(_ rate: UInt8) -> AACommand {
        let properties = [rate.property(forIdentifier: 0x01)]

        return command(forMessageType: .sendRate, properties: properties)
    }
}
