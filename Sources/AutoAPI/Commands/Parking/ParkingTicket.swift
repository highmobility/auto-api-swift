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
//  ParkingTicket.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 12/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct ParkingTicket: FullStandardCommand {

    public let endTime: Date?
    public let operatorName: String?
    public let startTime: Date?
    public let state: ParkingTicketState?
    public let ticketID: String?


    // MARK: FullStandardCommand

    public let properties: Properties


    init?(properties: Properties) {
        // Ordered by the ID
        state = ParkingTicketState(rawValue: properties.first(for: 0x01)?.monoValue)
        operatorName = properties.value(for: 0x02)
        ticketID = properties.value(for: 0x03)
        startTime = properties.value(for: 0x04)
        endTime = properties.value(for: 0x05)

        // Properties
        self.properties = properties
    }
}

extension ParkingTicket: Identifiable {

    public static var identifier: Identifier = Identifier(0x0047)
}

extension ParkingTicket: MessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getTicket      = 0x00
        case parkingTicket  = 0x01
        case startParking   = 0x02
        case endParking     = 0x03
    }
}

public extension ParkingTicket {

    struct Settings {
        public let operatorName: String?
        public let ticketID: String
        public let startTime: Date
        public let endTime: Date?

        public init(operatorName: String?, ticketID: String, startTime: Date, endTime: Date?) {
            self.operatorName = operatorName
            self.ticketID = ticketID
            self.startTime = startTime
            self.endTime = endTime
        }
    }


    static var endParking: [UInt8] {
        return commandPrefix(for: .endParking)
    }

    static var getTicket: [UInt8] {
        return commandPrefix(for: .getTicket)
    }

    static var startParking: (Settings) -> [UInt8] {
        return {
            // Strings return [] from .propertyBytes if the String couldn't be converted to Data
            let nameBytes: [UInt8] = $0.operatorName?.propertyBytes(0x01) ?? []
            let ticketBytes = $0.ticketID.propertyBytes(0x02)
            let startBytes = $0.startTime.propertyBytes(0x03)
            let endBytes: [UInt8] = $0.endTime?.propertyBytes(0x04) ?? []

            return commandPrefix(for: .startParking) + nameBytes + ticketBytes + startBytes + endBytes
        }
    }
}
