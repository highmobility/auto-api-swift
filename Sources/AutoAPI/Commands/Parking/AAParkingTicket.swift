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
//  AAParkingTicket.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 12/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct AAParkingTicket: AAFullStandardCommand {

    public let endTime: AAProperty<Date>?
    public let operatorName: AAProperty<String>?
    public let startTime: AAProperty<Date>?
    public let state: AAProperty<AAParkingTicketState>?
    public let ticketID: AAProperty<String>?


    // MARK: AAFullStandardCommand

    public let properties: AAProperties


    init?(properties: AAProperties) {
        // Ordered by the ID
        state = properties.property(forIdentifier: 0x01)
        operatorName = properties.property(forIdentifier: 0x02)
        ticketID = properties.property(forIdentifier: 0x03)
        startTime = properties.property(forIdentifier: 0x04)
        endTime = properties.property(forIdentifier: 0x05)

        // Properties
        self.properties = properties
    }
}

extension AAParkingTicket: AAIdentifiable {

    public static var identifier: AACommandIdentifier = 0x0047
}

extension AAParkingTicket: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getTicket      = 0x00
        case parkingTicket  = 0x01
        case startParking   = 0x02
        case endParking     = 0x03
    }
}

public extension AAParkingTicket {

    static var getTicket: [UInt8] {
        return commandPrefix(for: .getTicket)
    }


    static func endParking() -> [UInt8] {
        return commandPrefix(for: .endParking)
    }

    static func startParking(ticketID: String, startTime: Date, endTime: Date?, operatorName: String?) -> [UInt8] {
        return commandPrefix(for: .startParking)
            // TODO: + [ticketID.propertyBytes(0x02), startTime.propertyBytes(0x03), endTime?.propertyBytes(0x04), operatorName?.propertyBytes(0x01)].propertiesValuesCombined
    }
}
