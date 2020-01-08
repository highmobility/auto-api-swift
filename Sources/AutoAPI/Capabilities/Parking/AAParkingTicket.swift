//
// AutoAPI
// Copyright (C) 2020 High-Mobility GmbH
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
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation
import HMUtilities


public class AAParkingTicket: AACapability {

    /// Status
    public enum Status: UInt8, AABytesConvertable {
        case ended = 0x00
        case started = 0x01
    }


    /// Property Identifiers for `AAParkingTicket` capability.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case status = 0x01
        case operatorName = 0x02
        case operatorTicketID = 0x03
        case ticketStartTime = 0x04
        case ticketEndTime = 0x05
    }


    // MARK: Properties
    
    /// Operator name
    ///
    /// - returns: `String` wrapped in `AAProperty<String>`
    public var operatorName: AAProperty<String>? {
        properties.property(forID: PropertyIdentifier.operatorName)
    }
    
    /// Operator ticket ID
    ///
    /// - returns: `String` wrapped in `AAProperty<String>`
    public var operatorTicketID: AAProperty<String>? {
        properties.property(forID: PropertyIdentifier.operatorTicketID)
    }
    
    /// Status
    ///
    /// - returns: `Status` wrapped in `AAProperty<Status>`
    public var status: AAProperty<Status>? {
        properties.property(forID: PropertyIdentifier.status)
    }
    
    /// Milliseconds since UNIX Epoch time
    ///
    /// - returns: `Date` wrapped in `AAProperty<Date>`
    public var ticketEndTime: AAProperty<Date>? {
        properties.property(forID: PropertyIdentifier.ticketEndTime)
    }
    
    /// Milliseconds since UNIX Epoch time
    ///
    /// - returns: `Date` wrapped in `AAProperty<Date>`
    public var ticketStartTime: AAProperty<Date>? {
        properties.property(forID: PropertyIdentifier.ticketStartTime)
    }


    // MARK: AAIdentifiable
    
    /// Capability's Identifier
    ///
    /// - returns: `UInt16` combining the MSB and LSB
    public override class var identifier: UInt16 {
        0x0047
    }


    // MARK: Getters
    
    /// Bytes for getting the `AAParkingTicket` state.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *request* the state of `AAParkingTicket`.
    ///
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func getParkingTicket() -> Array<UInt8> {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.get.rawValue]
    }
    
    /// Bytes for getting the `AAParkingTicket` state's **specific** properties.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *request* **specific** state properties of `AAParkingTicket`.
    ///
    /// - parameters:
    ///   - propertyIDs: Array of requested property identifiers
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func getParkingTicketProperties(propertyIDs: PropertyIdentifier...) -> Array<UInt8> {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.get.rawValue] + propertyIDs.map { $0.rawValue }
    }


    // MARK: Setters
    
    /// Bytes for *start parking* command.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *start parking* in `AAParkingTicket`.
    /// 
    /// - parameters:
    ///   - operatorTicketID: Operator ticket ID as `String`
    ///   - ticketStartTime: Milliseconds since UNIX Epoch time as `Date`
    ///   - operatorName: Operator name as `String`
    ///   - ticketEndTime: Milliseconds since UNIX Epoch time as `Date`
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func startParking(operatorTicketID: String, ticketStartTime: Date, operatorName: String?, ticketEndTime: Date?) -> Array<UInt8> {
        let props1 = AAProperty(identifier: PropertyIdentifier.operatorTicketID, value: operatorTicketID).bytes + AAProperty(identifier: PropertyIdentifier.ticketStartTime, value: ticketStartTime).bytes + AAProperty(identifier: PropertyIdentifier.operatorName, value: operatorName).bytes
        let props2 = AAProperty(identifier: PropertyIdentifier.ticketEndTime, value: ticketEndTime).bytes + AAProperty(identifier: PropertyIdentifier.status, value: Status(bytes: [0x01])).bytes
    
        return AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.set.rawValue] + props1 + props2
    }
    
    /// Bytes for *end parking* command.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *end parking* in `AAParkingTicket`.
    /// 
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func endParking() -> Array<UInt8> {
        return AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.set.rawValue] + AAProperty(identifier: PropertyIdentifier.status, value: Status(bytes: [0x00])).bytes
    }


    // MARK: AADebugTreeCapable
    
    public override var propertyNodes: [HMDebugTree] {
        [
            .node(label: "Operator name", property: operatorName),
            .node(label: "Operator ticket ID", property: operatorTicketID),
            .node(label: "Status", property: status),
            .node(label: "Ticket end time", property: ticketEndTime),
            .node(label: "Ticket start time", property: ticketStartTime)
        ]
    }
}