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
//  AATachograph.swift
//  AutoAPI
//
//  Generated by AutoAPIGenerator for Swift.
//  Copyright © 2021 High-Mobility GmbH. All rights reserved.
//

import Foundation
import HMUtilities


public final class AATachograph: AACapability, AAPropertyIdentifying {

    /// Information about the introduction and last update of this capability.
    public enum API: AAAPICurrent {
        /// Level (version) of *AutoAPI* when `AATachograph` was introduced to the spec.
        public static let intro: UInt8 = 7
    
        /// Level (version) of *AutoAPI* when `AATachograph` was last updated.
        public static let updated: UInt8 = 12
    }


    /// Vehicle direction enum.
    public enum VehicleDirection: UInt8, CaseIterable, Codable, HMBytesConvertable {
        case forward = 0x00
        case reverse = 0x01
    }

    /// Vehicle overspeed enum.
    public enum VehicleOverspeed: UInt8, CaseIterable, Codable, HMBytesConvertable {
        case noOverspeed = 0x00
        case overspeed = 0x01
    }


    // MARK: Identifiers
    
    public class override var identifier: UInt16 { 0x0064 }


    /// Property identifiers for `AATachograph`.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case driversWorkingStates = 0x01
        case driversTimeStates = 0x02
        case driversCardsPresent = 0x03
        case vehicleMotion = 0x04
        case vehicleOverspeed = 0x05
        case vehicleDirection = 0x06
        case vehicleSpeed = 0x07
    }


    // MARK: Properties
    
    /// Drivers cards present value.
    public var driversCardsPresent: [AAProperty<AADriverCardPresent>]?
    
    /// Drivers time states value.
    public var driversTimeStates: [AAProperty<AADriverTimeState>]?
    
    /// Drivers working states value.
    public var driversWorkingStates: [AAProperty<AADriverWorkingState>]?
    
    /// Vehicle direction value.
    public var vehicleDirection: AAProperty<VehicleDirection>?
    
    /// Vehicle motion value.
    public var vehicleMotion: AAProperty<AADetected>?
    
    /// Vehicle overspeed value.
    public var vehicleOverspeed: AAProperty<VehicleOverspeed>?
    
    /// The tachograph vehicle speed.
    public var vehicleSpeed: AAProperty<Measurement<UnitSpeed>>?


    // MARK: Getters
    
    /// Get `AATachograph` state (all properties).
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getTachographState() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.get.rawValue.bytes
    }
    
    /// Get `AATachograph` state's specific properties.
    ///
    /// - parameters:
    ///     - ids: List of property identifiers to request.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getTachographStateProperties(ids: PropertyIdentifier...) -> [UInt8] {
        getTachographState() + ids.map { $0.rawValue }
    }
    
    /// Get `AATachograph` state properties availability.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getTachographStateAvailability() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.availability.rawValue.bytes
    }
    
    /// Get `AATachograph` state's specific properties' availability.
    ///
    /// - parameters:
    ///     - ids: List of property identifiers to request availability for.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getTachographStatePropertiesAvailability(ids: PropertyIdentifier...) -> [UInt8] {
        getTachographStateAvailability() + ids.map { $0.rawValue }
    }


    // MARK: AACapability
    
    public required init?(bytes: [UInt8]) {
        super.init(bytes: bytes)
    
        driversCardsPresent = extract(properties: .driversCardsPresent)
        driversTimeStates = extract(properties: .driversTimeStates)
        driversWorkingStates = extract(properties: .driversWorkingStates)
        vehicleDirection = extract(property: .vehicleDirection)
        vehicleMotion = extract(property: .vehicleMotion)
        vehicleOverspeed = extract(property: .vehicleOverspeed)
        vehicleSpeed = extract(property: .vehicleSpeed)
    }
}