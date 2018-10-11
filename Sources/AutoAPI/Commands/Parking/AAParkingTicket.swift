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

    public let endTime: Date?
    public let operatorName: String?
    public let startTime: Date?
    public let state: AAParkingTicketState?
    public let ticketID: String?


    // MARK: AAFullStandardCommand

    public let properties: AAProperties


    init?(properties: AAProperties) {
        // Ordered by the ID
        state = AAParkingTicketState(properties: properties, keyPath: \AAParkingTicket.state)
        operatorName = properties.value(for: \AAParkingTicket.operatorName)
        ticketID = properties.value(for: \AAParkingTicket.ticketID)
        startTime = properties.value(for: \AAParkingTicket.startTime)
        endTime = properties.value(for: \AAParkingTicket.endTime)

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

extension AAParkingTicket: AAPropertyIdentifierGettable {

    static func propertyID<Type>(for keyPath: KeyPath<AAParkingTicket, Type>) -> AAPropertyIdentifier {
        switch keyPath {
        case \AAParkingTicket.state:        return 0x01
        case \AAParkingTicket.operatorName: return 0x02
        case \AAParkingTicket.ticketID:     return 0x03
        case \AAParkingTicket.startTime:    return 0x04
        case \AAParkingTicket.endTime:      return 0x05

        default:
            return 0x00
        }
    }
}


// MARK: Commands

public extension AAParkingTicket {

    static var getTicket: [UInt8] {
        return commandPrefix(for: .getTicket)
    }


    static func endParking() -> [UInt8] {
        return commandPrefix(for: .endParking)
    }

    static func startParking(ticketID: String, startTime: Date, endTime: Date?, operatorName: String?) -> [UInt8] {
        return commandPrefix(for: .startParking) + [ticketID.propertyBytes(0x02),
                                                    startTime.propertyBytes(0x03),
                                                    endTime?.propertyBytes(0x04),
                                                    operatorName?.propertyBytes(0x01)].propertiesValuesCombined
    }
}

public extension AAParkingTicket {

    struct Legacy: AAMessageTypesGettable {

        public enum MessageTypes: UInt8, CaseIterable {

            case getTicket      = 0x00
            case parkingTicket  = 0x01
            case startParking   = 0x02
            case endParking     = 0x03
        }


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
            return commandPrefix(for: AAParkingTicket.self, messageType: .endParking)
        }

        static var getTicket: [UInt8] {
            return commandPrefix(for: AAParkingTicket.self, messageType: .getTicket)
        }

        static var startParking: (Settings) -> [UInt8] {
            return {
                // Strings return [] from .propertyBytes if the String couldn't be converted to Data
                let nameBytes: [UInt8] = $0.operatorName?.propertyBytes(0x01) ?? []
                let ticketBytes = $0.ticketID.propertyBytes(0x02)
                let startBytes = $0.startTime.propertyBytes(0x03)
                let endBytes: [UInt8] = $0.endTime?.propertyBytes(0x04) ?? []

                return commandPrefix(for: AAParkingTicket.self, messageType: .startParking) + nameBytes + ticketBytes + startBytes + endBytes
            }
        }
    }
}
