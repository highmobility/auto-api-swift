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
//  AAMaintenance.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation
import HMUtilities


public class AAMaintenance: AACapability {

    /// Teleservice availability
    public enum TeleserviceAvailability: UInt8, AABytesConvertable {
        case pending = 0x00
        case idle = 0x01
        case successful = 0x02
        case error = 0x03
    }


    /// Property Identifiers for `AAMaintenance` capability.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case daysToNextService = 0x01
        case kilometersToNextService = 0x02
        case cbsReportsCount = 0x03
        case monthsToExhaustInspection = 0x04
        case teleserviceAvailability = 0x05
        case serviceDistanceThreshold = 0x06
        case serviceTimeThreshold = 0x07
        case automaticTeleserviceCallDate = 0x08
        case teleserviceBatteryCallDate = 0x09
        case nextInspectionDate = 0x0a
        case conditionBasedServices = 0x0b
        case brakeFluidChangeDate = 0x0c
    }


    // MARK: Properties
    
    /// Milliseconds since UNIX Epoch time
    ///
    /// - returns: `Date` wrapped in `AAProperty<Date>`
    public var automaticTeleserviceCallDate: AAProperty<Date>? {
        properties.property(forID: PropertyIdentifier.automaticTeleserviceCallDate)
    }
    
    /// Milliseconds since UNIX Epoch time
    ///
    /// - returns: `Date` wrapped in `AAProperty<Date>`
    public var brakeFluidChangeDate: AAProperty<Date>? {
        properties.property(forID: PropertyIdentifier.brakeFluidChangeDate)
    }
    
    /// The number of CBS reports
    ///
    /// - returns: `UInt8` wrapped in `AAProperty<UInt8>`
    public var cbsReportsCount: AAProperty<UInt8>? {
        properties.property(forID: PropertyIdentifier.cbsReportsCount)
    }
    
    /// Condition based services
    ///
    /// - returns: Array of `AAConditionBasedService`-s wrapped in `[AAProperty<AAConditionBasedService>]`
    public var conditionBasedServices: [AAProperty<AAConditionBasedService>]? {
        properties.properties(forID: PropertyIdentifier.conditionBasedServices)
    }
    
    /// Number of days until next servicing of the car, whereas negative is overdue
    ///
    /// - returns: `Int16` wrapped in `AAProperty<Int16>`
    public var daysToNextService: AAProperty<Int16>? {
        properties.property(forID: PropertyIdentifier.daysToNextService)
    }
    
    /// The amount of kilometers until next servicing of the car
    ///
    /// - returns: `UInt32` wrapped in `AAProperty<UInt32>`
    public var kilometersToNextService: AAProperty<UInt32>? {
        properties.property(forID: PropertyIdentifier.kilometersToNextService)
    }
    
    /// Number of months until exhaust inspection
    ///
    /// - returns: `UInt8` wrapped in `AAProperty<UInt8>`
    public var monthsToExhaustInspection: AAProperty<UInt8>? {
        properties.property(forID: PropertyIdentifier.monthsToExhaustInspection)
    }
    
    /// Milliseconds since UNIX Epoch time
    ///
    /// - returns: `Date` wrapped in `AAProperty<Date>`
    public var nextInspectionDate: AAProperty<Date>? {
        properties.property(forID: PropertyIdentifier.nextInspectionDate)
    }
    
    /// Distance threshold for Service
    ///
    /// - returns: `UInt16` wrapped in `AAProperty<UInt16>`
    public var serviceDistanceThreshold: AAProperty<UInt16>? {
        properties.property(forID: PropertyIdentifier.serviceDistanceThreshold)
    }
    
    /// Time threshold, in weeks, for Service
    ///
    /// - returns: `UInt8` wrapped in `AAProperty<UInt8>`
    public var serviceTimeThreshold: AAProperty<UInt8>? {
        properties.property(forID: PropertyIdentifier.serviceTimeThreshold)
    }
    
    /// Teleservice availability
    ///
    /// - returns: `TeleserviceAvailability` wrapped in `AAProperty<TeleserviceAvailability>`
    public var teleserviceAvailability: AAProperty<TeleserviceAvailability>? {
        properties.property(forID: PropertyIdentifier.teleserviceAvailability)
    }
    
    /// Milliseconds since UNIX Epoch time
    ///
    /// - returns: `Date` wrapped in `AAProperty<Date>`
    public var teleserviceBatteryCallDate: AAProperty<Date>? {
        properties.property(forID: PropertyIdentifier.teleserviceBatteryCallDate)
    }


    // MARK: AAIdentifiable
    
    /// Capability's Identifier
    ///
    /// - returns: `UInt16` combining the MSB and LSB
    public override class var identifier: UInt16 {
        0x0034
    }


    // MARK: Getters
    
    /// Bytes for getting the `AAMaintenance` state.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *request* the state of `AAMaintenance`.
    ///
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func getMaintenanceState() -> Array<UInt8> {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.get.rawValue]
    }
    
    /// Bytes for getting the `AAMaintenance` state's **specific** properties.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *request* **specific** state properties of `AAMaintenance`.
    ///
    /// - parameters:
    ///   - propertyIDs: Array of requested property identifiers
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func getMaintenanceProperties(propertyIDs: PropertyIdentifier...) -> Array<UInt8> {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.get.rawValue] + propertyIDs.map { $0.rawValue }
    }


    // MARK: AADebugTreeCapable
    
    public override var propertyNodes: [HMDebugTree] {
        [
            .node(label: "Automatic teleservice call date", property: automaticTeleserviceCallDate),
            .node(label: "Brake fluid change date", property: brakeFluidChangeDate),
            .node(label: "CBS reports count", property: cbsReportsCount),
            .node(label: "Condition based services", properties: conditionBasedServices),
            .node(label: "Days to next service", property: daysToNextService),
            .node(label: "Kilometers to next service", property: kilometersToNextService),
            .node(label: "Months to exhaust inspection", property: monthsToExhaustInspection),
            .node(label: "Next inspection date", property: nextInspectionDate),
            .node(label: "Service distance threshold", property: serviceDistanceThreshold),
            .node(label: "Service time threshold", property: serviceTimeThreshold),
            .node(label: "Teleservice availability", property: teleserviceAvailability),
            .node(label: "Teleservice battery call date", property: teleserviceBatteryCallDate)
        ]
    }
}