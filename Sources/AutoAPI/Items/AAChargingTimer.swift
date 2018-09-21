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
//  AAChargingTimer.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 30/01/2018.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct AAChargingTimer {

    public let type: AATimerType
    public let time: Date


    // MARK: Init

    public init(type: AATimerType, time: Date) {
        self.type = type
        self.time = time
    }
}

extension AAChargingTimer: BinaryInitable {

    init?<C>(_ binary: C) where C : Collection, C.Element == UInt8 {
        guard !binary.isEmpty else {
            return nil
        }

        guard let timerType = AATimerType(rawValue: binary.bytes[0]) else {
            return nil
        }
        
        guard let date = Date(binary.dropFirst().bytes) else {
            return nil
        }

        type = timerType
        time = date
    }
}

extension AAChargingTimer: Equatable {

    public static func ==(lhs: AAChargingTimer, rhs: AAChargingTimer) -> Bool {
        return (lhs.type == rhs.type) && (lhs.time == rhs.time)
    }
}

extension AAChargingTimer: PropertyConvertable {

    var propertyValue: [UInt8] {
        return [type.rawValue] + time.propertyValue
    }
}
