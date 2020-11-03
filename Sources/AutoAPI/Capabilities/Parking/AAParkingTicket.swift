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
//  AAParkingTicket.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation
import HMUtilities


public class AAParkingTicket: AACapability {

    /// Status
    public enum Status: UInt8, AABytesConvertable {
        case ended = 0x00
        case started = 0x01
    
        static let end = Self.ended
        static let start = Self.started
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
    public static func startParking(operatorTicketID: String, ticketStartTime: Date, operatorName: String? = nil, ticketEndTime: Date? = nil) -> Array<UInt8> {
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
