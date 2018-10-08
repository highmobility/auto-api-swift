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
//  AASeats.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 07/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct AASeats: AAFullStandardCommand {

    public let personsDetected: [AASeat.PersonDetected]?
    public let seatbeltsFastened: [AASeat.SeatbeltFastened]?


    // MARK: AAFullStandardCommand

    public let properties: AAProperties


    init?(properties: AAProperties) {
        // Ordered by the ID
        /* Level 8 */
        personsDetected = properties.flatMap(for: \AASeats.personsDetected) { AASeat.PersonDetected($0.value) }
        seatbeltsFastened = properties.flatMap(for: \AASeats.seatbeltsFastened) { AASeat.SeatbeltFastened($0.value) }

        // Properties
        self.properties = properties
    }
}

extension AASeats: AAIdentifiable {

    public static var identifier: AACommandIdentifier = 0x0056
}

extension AASeats: AALegacyGettable {

    public struct Legacy: AALegacyType {

        public let seats: [AASeat]?


        // MARK: AALegacyType

        public enum MessageTypes: UInt8, CaseIterable {

            case getSeatsState  = 0x00
            case seatsState     = 0x01
        }


        public init(properties: AAProperties) {
            seats = properties.flatMap(for: 0x01) { AASeat($0.value) }
        }
    }
}

extension AASeats: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getSeatsState  = 0x00
        case seatsState     = 0x01
    }
}

extension AASeats: AAPropertyIdentifierGettable {

    static func propertyID(for keyPath: PartialKeyPath<AASeats>) -> AAPropertyIdentifier {
        switch keyPath {
        case \AASeats.personsDetected:      return 0x02
        case \AASeats.seatbeltsFastened:    return 0x03

        default:
            return 0x00
        }
    }
}


// MARK: Commands

public extension AASeats {

    static var getSeatsState: [UInt8] {
        return commandPrefix(for: .getSeatsState)
    }
}

public extension AASeats.Legacy {

    static var getSeatsState: [UInt8] {
        return commandPrefix(for: AASeats.self, messageType: .getSeatsState)
    }
}
