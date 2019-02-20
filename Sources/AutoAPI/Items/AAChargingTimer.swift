//
// AutoAPI
// Copyright (C) 2019 High-Mobility GmbH
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
//  Copyright © 2019 High Mobility GmbH. All rights reserved.
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

extension AAChargingTimer: AABytesConvertable {

    public var bytes: [UInt8] {
        return type.bytes + time.bytes
    }


    public init?(bytes: [UInt8]) {
        guard bytes.count == 9 else {
            return nil
        }

        guard let type = AATimerType(bytes: bytes[0..<1]),
            let time = Date(bytes: bytes[1...8]) else {
                return nil
        }

        self.init(type: type, time: time)
    }
}

extension AAChargingTimer: Equatable {

}
