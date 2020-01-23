//
//  The MIT License
//
//  Copyright (c) 2014- High-Mobility GmbH (https://high-mobility.com)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//
//
//  ParkingTicket.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 12/12/2017.
//

import Foundation


public struct ParkingTicket: FullStandardCommand {

    public let endTime: YearTime?
    public let operatorName: String?
    public let startTime: YearTime?
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

    public enum MessageTypes: UInt8, MessageTypesKind {

        case getParkingTicket   = 0x00
        case parkingTicket      = 0x01
        case startParking       = 0x02
        case endParking         = 0x03


        public static var all: [ParkingTicket.MessageTypes] {
            return [self.getParkingTicket,
                    self.parkingTicket,
                    self.startParking,
                    self.endParking]
        }
    }
}

public extension ParkingTicket {

    struct Settings {
        public let operatorName: String?
        public let ticketID: String
        public let startTime: YearTime
        public let endTime: YearTime?

        public init(operatorName: String?, ticketID: String, startTime: YearTime, endTime: YearTime?) {
            self.operatorName = operatorName
            self.ticketID = ticketID
            self.startTime = startTime
            self.endTime = endTime
        }
    }


    static var endParking: [UInt8] {
        return commandPrefix(for: .endParking)
    }

    static var getParkingTicket: [UInt8] {
        return commandPrefix(for: .getParkingTicket)
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
