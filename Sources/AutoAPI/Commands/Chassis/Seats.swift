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
//  Seats.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 07/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct Seats: AAFullStandardCommand, Sequence {

    public let personsDetected: [Seat.PersonDetected]?
    public let seatbeltsFastened: [Seat.SeatbeltFastened]?


    @available(*, deprecated, message: "Use the new .personsDetected or .seatbeltsFastened iVars")
    public let seats: [Seat]?


    // MARK: AAFullStandardCommand

    public let properties: AAProperties


    init?(properties: AAProperties) {
        // Ordered by the ID
        seats = properties.flatMap(for: 0x01) { Seat($0.value) }    // Deprecated

        personsDetected = properties.flatMap(for: 0x02) { Seat.PersonDetected($0.value) }
        seatbeltsFastened = properties.flatMap(for: 0x03) { Seat.SeatbeltFastened($0.value) }

        // Properties
        self.properties = properties
    }


    // MARK: Sequence

    public typealias Iterator = SeatsIterator


    public func makeIterator() -> SeatsIterator {
        return SeatsIterator(properties.filter(for: 0x01).flatMap { $0.bytes })
    }
}

extension Seats: AAIdentifiable {

    public static var identifier: AACommandIdentifier = AACommandIdentifier(0x0056)
}

extension Seats: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getSeatsState  = 0x00
        case seatsState     = 0x01
    }
}

public extension Seats {

    static var getSeatsState: [UInt8] {
        return commandPrefix(for: .getSeatsState)
    }
}
