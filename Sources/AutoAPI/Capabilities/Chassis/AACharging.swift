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
//  AACharging.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation
import HMUtilities


public class AACharging: AACapability {

    /// Charge mode
    public enum ChargeMode: UInt8, AABytesConvertable {
        case immediate = 0x00
        case timerBased = 0x01
        case inductive = 0x02
    }
    
    /// Charging window chosen
    public enum ChargingWindowChosen: UInt8, AABytesConvertable {
        case notChosen = 0x00
        case chosen = 0x01
    }
    
    /// Plug type
    public enum PlugType: UInt8, AABytesConvertable {
        case type1 = 0x00
        case type2 = 0x01
        case ccs = 0x02
        case chademo = 0x03
    }
    
    /// Plugged in
    public enum PluggedIn: UInt8, AABytesConvertable {
        case disconnected = 0x00
        case pluggedIn = 0x01
    }
    
    /// Status
    public enum Status: UInt8, AABytesConvertable {
        case notCharging = 0x00
        case charging = 0x01
        case chargingComplete = 0x02
        case initialising = 0x03
        case chargingPaused = 0x04
        case chargingError = 0x05
    
        static let stopCharging = Self.notCharging
        static let startCharging = Self.charging
    }


    /// Property Identifiers for `AACharging` capability.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case estimatedRange = 0x02
        case batteryLevel = 0x03
        case batteryCurrentAC = 0x04
        case batteryCurrentDC = 0x05
        case chargerVoltageAC = 0x06
        case chargerVoltageDC = 0x07
        case chargeLimit = 0x08
        case timeToCompleteCharge = 0x09
        case chargingRateKW = 0x0a
        case chargePortState = 0x0b
        case chargeMode = 0x0c
        case maxChargingCurrent = 0x0e
        case plugType = 0x0f
        case chargingWindowChosen = 0x10
        case departureTimes = 0x11
        case reductionTimes = 0x13
        case batteryTemperature = 0x14
        case timers = 0x15
        case pluggedIn = 0x16
        case status = 0x17
    }


    // MARK: Properties
    
    /// Battery active current
    ///
    /// - returns: `Float` wrapped in `AAProperty<Float>`
    public var batteryCurrentAC: AAProperty<Float>? {
        properties.property(forID: PropertyIdentifier.batteryCurrentAC)
    }
    
    /// Battery direct current
    ///
    /// - returns: `Float` wrapped in `AAProperty<Float>`
    public var batteryCurrentDC: AAProperty<Float>? {
        properties.property(forID: PropertyIdentifier.batteryCurrentDC)
    }
    
    /// Battery level percentage between 0.0-1.0
    ///
    /// - returns: `AAPercentage` wrapped in `AAProperty<AAPercentage>`
    public var batteryLevel: AAProperty<AAPercentage>? {
        properties.property(forID: PropertyIdentifier.batteryLevel)
    }
    
    /// Battery temperature in Celsius
    ///
    /// - returns: `Float` wrapped in `AAProperty<Float>`
    public var batteryTemperature: AAProperty<Float>? {
        properties.property(forID: PropertyIdentifier.batteryTemperature)
    }
    
    /// Charge limit percentage between 0.0-1.0
    ///
    /// - returns: `AAPercentage` wrapped in `AAProperty<AAPercentage>`
    public var chargeLimit: AAProperty<AAPercentage>? {
        properties.property(forID: PropertyIdentifier.chargeLimit)
    }
    
    /// Charge mode
    ///
    /// - returns: `ChargeMode` wrapped in `AAProperty<ChargeMode>`
    public var chargeMode: AAProperty<ChargeMode>? {
        properties.property(forID: PropertyIdentifier.chargeMode)
    }
    
    /// Charge port state
    ///
    /// - returns: `AAPosition` wrapped in `AAProperty<AAPosition>`
    public var chargePortState: AAProperty<AAPosition>? {
        properties.property(forID: PropertyIdentifier.chargePortState)
    }
    
    /// Charger voltage
    ///
    /// - returns: `Float` wrapped in `AAProperty<Float>`
    public var chargerVoltageAC: AAProperty<Float>? {
        properties.property(forID: PropertyIdentifier.chargerVoltageAC)
    }
    
    /// Charger voltage
    ///
    /// - returns: `Float` wrapped in `AAProperty<Float>`
    public var chargerVoltageDC: AAProperty<Float>? {
        properties.property(forID: PropertyIdentifier.chargerVoltageDC)
    }
    
    /// Charge rate in kW when charging
    ///
    /// - returns: `Float` wrapped in `AAProperty<Float>`
    public var chargingRateKW: AAProperty<Float>? {
        properties.property(forID: PropertyIdentifier.chargingRateKW)
    }
    
    /// Charging window chosen
    ///
    /// - returns: `ChargingWindowChosen` wrapped in `AAProperty<ChargingWindowChosen>`
    public var chargingWindowChosen: AAProperty<ChargingWindowChosen>? {
        properties.property(forID: PropertyIdentifier.chargingWindowChosen)
    }
    
    /// Departure times
    ///
    /// - returns: Array of `AADepartureTime`-s wrapped in `[AAProperty<AADepartureTime>]`
    public var departureTimes: [AAProperty<AADepartureTime>]? {
        properties.properties(forID: PropertyIdentifier.departureTimes)
    }
    
    /// Estimated range in km
    ///
    /// - returns: `UInt16` wrapped in `AAProperty<UInt16>`
    public var estimatedRange: AAProperty<UInt16>? {
        properties.property(forID: PropertyIdentifier.estimatedRange)
    }
    
    /// Maximum charging current
    ///
    /// - returns: `Float` wrapped in `AAProperty<Float>`
    public var maxChargingCurrent: AAProperty<Float>? {
        properties.property(forID: PropertyIdentifier.maxChargingCurrent)
    }
    
    /// Plug type
    ///
    /// - returns: `PlugType` wrapped in `AAProperty<PlugType>`
    public var plugType: AAProperty<PlugType>? {
        properties.property(forID: PropertyIdentifier.plugType)
    }
    
    /// Plugged in
    ///
    /// - returns: `PluggedIn` wrapped in `AAProperty<PluggedIn>`
    public var pluggedIn: AAProperty<PluggedIn>? {
        properties.property(forID: PropertyIdentifier.pluggedIn)
    }
    
    /// Reduction times
    ///
    /// - returns: Array of `AAReductionTime`-s wrapped in `[AAProperty<AAReductionTime>]`
    public var reductionTimes: [AAProperty<AAReductionTime>]? {
        properties.properties(forID: PropertyIdentifier.reductionTimes)
    }
    
    /// Status
    ///
    /// - returns: `Status` wrapped in `AAProperty<Status>`
    public var status: AAProperty<Status>? {
        properties.property(forID: PropertyIdentifier.status)
    }
    
    /// Time until charging completed in minutes
    ///
    /// - returns: `UInt8` wrapped in `AAProperty<UInt8>`
    public var timeToCompleteCharge: AAProperty<UInt8>? {
        properties.property(forID: PropertyIdentifier.timeToCompleteCharge)
    }
    
    /// Timers
    ///
    /// - returns: Array of `AATimer`-s wrapped in `[AAProperty<AATimer>]`
    public var timers: [AAProperty<AATimer>]? {
        properties.properties(forID: PropertyIdentifier.timers)
    }


    // MARK: AAIdentifiable
    
    /// Capability's Identifier
    ///
    /// - returns: `UInt16` combining the MSB and LSB
    public override class var identifier: UInt16 {
        0x0023
    }


    // MARK: Getters
    
    /// Bytes for getting the `AACharging` state.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *request* the state of `AACharging`.
    ///
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func getChargingState() -> Array<UInt8> {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.get.rawValue]
    }
    
    /// Bytes for getting the `AACharging` state's **specific** properties.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *request* **specific** state properties of `AACharging`.
    ///
    /// - parameters:
    ///   - propertyIDs: Array of requested property identifiers
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func getChargingProperties(propertyIDs: PropertyIdentifier...) -> Array<UInt8> {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.get.rawValue] + propertyIDs.map { $0.rawValue }
    }


    // MARK: Setters
    
    /// Bytes for *start stop charging* command.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *start stop charging* in `AACharging`.
    /// 
    /// - parameters:
    ///   - status: status as `Status`
    /// - returns: Command's bytes as `Array<UInt8>?`
    public static func startStopCharging(status: Status) -> Array<UInt8>? {
        guard [.chargingComplete, .initialising, .chargingPaused, .chargingError].doesNotContain(status) else {
            return nil
        }
    
        return AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.set.rawValue] + AAProperty(identifier: PropertyIdentifier.status, value: status).bytes
    }
    
    /// Bytes for *set charge limit* command.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *set charge limit* in `AACharging`.
    /// 
    /// - parameters:
    ///   - chargeLimit: Charge limit percentage between 0.0-1.0 as `AAPercentage`
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func setChargeLimit(chargeLimit: AAPercentage) -> Array<UInt8> {
        return AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.set.rawValue] + AAProperty(identifier: PropertyIdentifier.chargeLimit, value: chargeLimit).bytes
    }
    
    /// Bytes for *open close charging port* command.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *open close charging port* in `AACharging`.
    /// 
    /// - parameters:
    ///   - chargePortState: charge port state as `AAPosition`
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func openCloseChargingPort(chargePortState: AAPosition) -> Array<UInt8> {
        return AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.set.rawValue] + AAProperty(identifier: PropertyIdentifier.chargePortState, value: chargePortState).bytes
    }
    
    /// Bytes for *set charge mode* command.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *set charge mode* in `AACharging`.
    /// 
    /// - parameters:
    ///   - chargeMode: charge mode as `ChargeMode`
    /// - returns: Command's bytes as `Array<UInt8>?`
    public static func setChargeMode(chargeMode: ChargeMode) -> Array<UInt8>? {
        guard [.inductive].doesNotContain(chargeMode) else {
            return nil
        }
    
        return AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.set.rawValue] + AAProperty(identifier: PropertyIdentifier.chargeMode, value: chargeMode).bytes
    }
    
    /// Bytes for *set charging timers* command.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *set charging timers* in `AACharging`.
    /// 
    /// - parameters:
    ///   - timers: timers as `[AATimer]`
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func setChargingTimers(timers: [AATimer]) -> Array<UInt8> {
        return AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.set.rawValue] + AAProperty.multiple(identifier: PropertyIdentifier.timers, values: timers).flatMap { $0.bytes }
    }
    
    /// Bytes for *set reduction of charging current times* command.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *set reduction of charging current times* in `AACharging`.
    /// 
    /// - parameters:
    ///   - reductionTimes: reduction times as `[AAReductionTime]`
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func setReductionOfChargingCurrentTimes(reductionTimes: [AAReductionTime]) -> Array<UInt8> {
        return AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.set.rawValue] + AAProperty.multiple(identifier: PropertyIdentifier.reductionTimes, values: reductionTimes).flatMap { $0.bytes }
    }


    // MARK: AADebugTreeCapable
    
    public override var propertyNodes: [HMDebugTree] {
        [
            .node(label: "Battery current (AC)", property: batteryCurrentAC),
            .node(label: "Battery current (DC)", property: batteryCurrentDC),
            .node(label: "Battery level", property: batteryLevel),
            .node(label: "Battery temperature", property: batteryTemperature),
            .node(label: "Charge limit", property: chargeLimit),
            .node(label: "Charge mode", property: chargeMode),
            .node(label: "Charge port state", property: chargePortState),
            .node(label: "Charger voltage (AC)", property: chargerVoltageAC),
            .node(label: "Charger voltage (DC)", property: chargerVoltageDC),
            .node(label: "Charging rate (kW)", property: chargingRateKW),
            .node(label: "Charging window chosen", property: chargingWindowChosen),
            .node(label: "Departure times", properties: departureTimes),
            .node(label: "Estimated range", property: estimatedRange),
            .node(label: "Maximum charging current", property: maxChargingCurrent),
            .node(label: "Plug type", property: plugType),
            .node(label: "Plugged in", property: pluggedIn),
            .node(label: "Reduction of charging-current times", properties: reductionTimes),
            .node(label: "Status", property: status),
            .node(label: "Time to complete charge", property: timeToCompleteCharge),
            .node(label: "Timers", properties: timers)
        ]
    }
}