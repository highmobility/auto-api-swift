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
//  AAUsage.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation
import HMUtilities


public class AAUsage: AACapability {

    /// Property Identifiers for `AAUsage` capability.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case averageWeeklyDistance = 0x01
        case averageWeeklyDistanceLongRun = 0x02
        case accelerationEvaluation = 0x03
        case drivingStyleEvaluation = 0x04
        case drivingModesActivationPeriods = 0x05
        case drivingModesEnergyConsumptions = 0x06
        case lastTripEnergyConsumption = 0x07
        case lastTripFuelConsumption = 0x08
        case mileageAfterLastTrip = 0x09
        case lastTripElectricPortion = 0x0a
        case lastTripAverageEnergyRecuperation = 0x0b
        case lastTripBatteryRemaining = 0x0c
        case lastTripDate = 0x0d
        case averageFuelConsumption = 0x0e
        case currentFuelConsumption = 0x0f
    }


    // MARK: Properties
    
    /// Acceleration evaluation percentage
    ///
    /// - returns: `AAPercentage` wrapped in `AAProperty<AAPercentage>`
    public var accelerationEvaluation: AAProperty<AAPercentage>? {
        properties.property(forID: PropertyIdentifier.accelerationEvaluation)
    }
    
    /// Average fuel consumption for current trip in liters / 100 km
    ///
    /// - returns: `Float` wrapped in `AAProperty<Float>`
    public var averageFuelConsumption: AAProperty<Float>? {
        properties.property(forID: PropertyIdentifier.averageFuelConsumption)
    }
    
    /// Average weekly distance in km
    ///
    /// - returns: `UInt16` wrapped in `AAProperty<UInt16>`
    public var averageWeeklyDistance: AAProperty<UInt16>? {
        properties.property(forID: PropertyIdentifier.averageWeeklyDistance)
    }
    
    /// Average weekyl distance, over long term, in km
    ///
    /// - returns: `UInt16` wrapped in `AAProperty<UInt16>`
    public var averageWeeklyDistanceLongRun: AAProperty<UInt16>? {
        properties.property(forID: PropertyIdentifier.averageWeeklyDistanceLongRun)
    }
    
    /// Current fuel consumption in liters / 100 km
    ///
    /// - returns: `Float` wrapped in `AAProperty<Float>`
    public var currentFuelConsumption: AAProperty<Float>? {
        properties.property(forID: PropertyIdentifier.currentFuelConsumption)
    }
    
    /// Driving modes activation periods
    ///
    /// - returns: Array of `AADrivingModeActivationPeriod`-s wrapped in `[AAProperty<AADrivingModeActivationPeriod>]`
    public var drivingModesActivationPeriods: [AAProperty<AADrivingModeActivationPeriod>]? {
        properties.properties(forID: PropertyIdentifier.drivingModesActivationPeriods)
    }
    
    /// Driving modes energy consumptions
    ///
    /// - returns: Array of `AADrivingModeEnergyConsumption`-s wrapped in `[AAProperty<AADrivingModeEnergyConsumption>]`
    public var drivingModesEnergyConsumptions: [AAProperty<AADrivingModeEnergyConsumption>]? {
        properties.properties(forID: PropertyIdentifier.drivingModesEnergyConsumptions)
    }
    
    /// Driving style evaluation percentage
    ///
    /// - returns: `AAPercentage` wrapped in `AAProperty<AAPercentage>`
    public var drivingStyleEvaluation: AAProperty<AAPercentage>? {
        properties.property(forID: PropertyIdentifier.drivingStyleEvaluation)
    }
    
    /// Energy recuperation rate for last trip, in kWh / 100 km
    ///
    /// - returns: `Float` wrapped in `AAProperty<Float>`
    public var lastTripAverageEnergyRecuperation: AAProperty<Float>? {
        properties.property(forID: PropertyIdentifier.lastTripAverageEnergyRecuperation)
    }
    
    /// Battery % remaining after last trip
    ///
    /// - returns: `AAPercentage` wrapped in `AAProperty<AAPercentage>`
    public var lastTripBatteryRemaining: AAProperty<AAPercentage>? {
        properties.property(forID: PropertyIdentifier.lastTripBatteryRemaining)
    }
    
    /// Milliseconds since UNIX Epoch time
    ///
    /// - returns: `Date` wrapped in `AAProperty<Date>`
    public var lastTripDate: AAProperty<Date>? {
        properties.property(forID: PropertyIdentifier.lastTripDate)
    }
    
    /// Portion of the last trip used in electric mode
    ///
    /// - returns: `AAPercentage` wrapped in `AAProperty<AAPercentage>`
    public var lastTripElectricPortion: AAProperty<AAPercentage>? {
        properties.property(forID: PropertyIdentifier.lastTripElectricPortion)
    }
    
    /// Energy consumption in the last trip in kWh
    ///
    /// - returns: `Float` wrapped in `AAProperty<Float>`
    public var lastTripEnergyConsumption: AAProperty<Float>? {
        properties.property(forID: PropertyIdentifier.lastTripEnergyConsumption)
    }
    
    /// Fuel consumption in the last trip in L
    ///
    /// - returns: `Float` wrapped in `AAProperty<Float>`
    public var lastTripFuelConsumption: AAProperty<Float>? {
        properties.property(forID: PropertyIdentifier.lastTripFuelConsumption)
    }
    
    /// Mileage after the last trip in km
    ///
    /// - returns: `UInt32` wrapped in `AAProperty<UInt32>`
    public var mileageAfterLastTrip: AAProperty<UInt32>? {
        properties.property(forID: PropertyIdentifier.mileageAfterLastTrip)
    }


    // MARK: AAIdentifiable
    
    /// Capability's Identifier
    ///
    /// - returns: `UInt16` combining the MSB and LSB
    public override class var identifier: UInt16 {
        0x0068
    }


    // MARK: Getters
    
    /// Bytes for getting the `AAUsage` state.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *request* the state of `AAUsage`.
    ///
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func getUsage() -> Array<UInt8> {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.get.rawValue]
    }
    
    /// Bytes for getting the `AAUsage` state's **specific** properties.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *request* **specific** state properties of `AAUsage`.
    ///
    /// - parameters:
    ///   - propertyIDs: Array of requested property identifiers
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func getUsageProperties(propertyIDs: PropertyIdentifier...) -> Array<UInt8> {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.get.rawValue] + propertyIDs.map { $0.rawValue }
    }


    // MARK: AADebugTreeCapable
    
    public override var propertyNodes: [HMDebugTree] {
        [
            .node(label: "Acceleration evaluation", property: accelerationEvaluation),
            .node(label: "Average fuel consumption", property: averageFuelConsumption),
            .node(label: "Average weekly distance", property: averageWeeklyDistance),
            .node(label: "Average weekly distance long run", property: averageWeeklyDistanceLongRun),
            .node(label: "Current fuel consumption", property: currentFuelConsumption),
            .node(label: "Driving modes activation periods", properties: drivingModesActivationPeriods),
            .node(label: "Driving modes energy consumptions", properties: drivingModesEnergyConsumptions),
            .node(label: "Driving style evaluation", property: drivingStyleEvaluation),
            .node(label: "Last trip average energy recuperation", property: lastTripAverageEnergyRecuperation),
            .node(label: "Last trip battery remaining", property: lastTripBatteryRemaining),
            .node(label: "Last trip date", property: lastTripDate),
            .node(label: "Last trip electric portion", property: lastTripElectricPortion),
            .node(label: "Last trip energy consumption", property: lastTripEnergyConsumption),
            .node(label: "Last trip fuel consumption", property: lastTripFuelConsumption),
            .node(label: "Mileage after last trip", property: mileageAfterLastTrip)
        ]
    }
}