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
//  AAWindscreen.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation
import HMUtilities


public class AAWindscreen: AACapability {

    /// Windscreen damage
    public enum WindscreenDamage: UInt8, AABytesConvertable {
        case noImpactDetected = 0x00
        case impactButNoDamageDetected = 0x01
        case damageSmallerThan1Inch = 0x02
        case damageLargerThan1Inch = 0x03
    }
    
    /// Windscreen needs replacement
    public enum WindscreenNeedsReplacement: UInt8, AABytesConvertable {
        case unknown = 0x00
        case noReplacementNeeded = 0x01
        case replacementNeeded = 0x02
    }
    
    /// Wipers intensity
    public enum WipersIntensity: UInt8, AABytesConvertable {
        case level0 = 0x00
        case level1 = 0x01
        case level2 = 0x02
        case level3 = 0x03
    }
    
    /// Wipers status
    public enum WipersStatus: UInt8, AABytesConvertable {
        case inactive = 0x00
        case active = 0x01
        case automatic = 0x02
    }


    /// Property Identifiers for `AAWindscreen` capability.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case wipersStatus = 0x01
        case wipersIntensity = 0x02
        case windscreenDamage = 0x03
        case windscreenZoneMatrix = 0x04
        case windscreenDamageZone = 0x05
        case windscreenNeedsReplacement = 0x06
        case windscreenDamageConfidence = 0x07
        case windscreenDamageDetectionTime = 0x08
    }


    // MARK: Properties
    
    /// Windscreen damage
    ///
    /// - returns: `WindscreenDamage` wrapped in `AAProperty<WindscreenDamage>`
    public var windscreenDamage: AAProperty<WindscreenDamage>? {
        properties.property(forID: PropertyIdentifier.windscreenDamage)
    }
    
    /// Confidence of damage detection, 0% if no impact detected
    ///
    /// - returns: `AAPercentage` wrapped in `AAProperty<AAPercentage>`
    public var windscreenDamageConfidence: AAProperty<AAPercentage>? {
        properties.property(forID: PropertyIdentifier.windscreenDamageConfidence)
    }
    
    /// Milliseconds since UNIX Epoch time
    ///
    /// - returns: `Date` wrapped in `AAProperty<Date>`
    public var windscreenDamageDetectionTime: AAProperty<Date>? {
        properties.property(forID: PropertyIdentifier.windscreenDamageDetectionTime)
    }
    
    /// Representing the position in the zone, seen from the inside of the vehicle (1-based index)
    ///
    /// - returns: `AAZone` wrapped in `AAProperty<AAZone>`
    public var windscreenDamageZone: AAProperty<AAZone>? {
        properties.property(forID: PropertyIdentifier.windscreenDamageZone)
    }
    
    /// Windscreen needs replacement
    ///
    /// - returns: `WindscreenNeedsReplacement` wrapped in `AAProperty<WindscreenNeedsReplacement>`
    public var windscreenNeedsReplacement: AAProperty<WindscreenNeedsReplacement>? {
        properties.property(forID: PropertyIdentifier.windscreenNeedsReplacement)
    }
    
    /// Representing the size of the matrix, seen from the inside of the vehicle
    ///
    /// - returns: `AAZone` wrapped in `AAProperty<AAZone>`
    public var windscreenZoneMatrix: AAProperty<AAZone>? {
        properties.property(forID: PropertyIdentifier.windscreenZoneMatrix)
    }
    
    /// Wipers intensity
    ///
    /// - returns: `WipersIntensity` wrapped in `AAProperty<WipersIntensity>`
    public var wipersIntensity: AAProperty<WipersIntensity>? {
        properties.property(forID: PropertyIdentifier.wipersIntensity)
    }
    
    /// Wipers status
    ///
    /// - returns: `WipersStatus` wrapped in `AAProperty<WipersStatus>`
    public var wipersStatus: AAProperty<WipersStatus>? {
        properties.property(forID: PropertyIdentifier.wipersStatus)
    }


    // MARK: AAIdentifiable
    
    /// Capability's Identifier
    ///
    /// - returns: `UInt16` combining the MSB and LSB
    public override class var identifier: UInt16 {
        0x0042
    }


    // MARK: Getters
    
    /// Bytes for getting the `AAWindscreen` state.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *request* the state of `AAWindscreen`.
    ///
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func getWindscreenState() -> Array<UInt8> {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.get.rawValue]
    }
    
    /// Bytes for getting the `AAWindscreen` state's **specific** properties.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *request* **specific** state properties of `AAWindscreen`.
    ///
    /// - parameters:
    ///   - propertyIDs: Array of requested property identifiers
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func getWindscreenProperties(propertyIDs: PropertyIdentifier...) -> Array<UInt8> {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.get.rawValue] + propertyIDs.map { $0.rawValue }
    }


    // MARK: Setters
    
    /// Bytes for *set windscreen damage* command.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *set windscreen damage* in `AAWindscreen`.
    /// 
    /// - parameters:
    ///   - windscreenDamage: windscreen damage as `WindscreenDamage`
    ///   - windscreenDamageZone: Representing the position in the zone, seen from the inside of the vehicle (1-based index) as `AAZone`
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func setWindscreenDamage(windscreenDamage: WindscreenDamage, windscreenDamageZone: AAZone? = nil) -> Array<UInt8> {
        let props1 = AAProperty(identifier: PropertyIdentifier.windscreenDamage, value: windscreenDamage).bytes + AAProperty(identifier: PropertyIdentifier.windscreenDamageZone, value: windscreenDamageZone).bytes
    
        return AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.set.rawValue] + props1
    }
    
    /// Bytes for *set windscreen replacement needed* command.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *set windscreen replacement needed* in `AAWindscreen`.
    /// 
    /// - parameters:
    ///   - windscreenNeedsReplacement: windscreen needs replacement as `WindscreenNeedsReplacement`
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func setWindscreenReplacementNeeded(windscreenNeedsReplacement: WindscreenNeedsReplacement) -> Array<UInt8> {
        return AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.set.rawValue] + AAProperty(identifier: PropertyIdentifier.windscreenNeedsReplacement, value: windscreenNeedsReplacement).bytes
    }
    
    /// Bytes for *control wipers* command.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *control wipers* in `AAWindscreen`.
    /// 
    /// - parameters:
    ///   - wipersStatus: wipers status as `WipersStatus`
    ///   - wipersIntensity: wipers intensity as `WipersIntensity`
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func controlWipers(wipersStatus: WipersStatus, wipersIntensity: WipersIntensity? = nil) -> Array<UInt8> {
        let props1 = AAProperty(identifier: PropertyIdentifier.wipersStatus, value: wipersStatus).bytes + AAProperty(identifier: PropertyIdentifier.wipersIntensity, value: wipersIntensity).bytes
    
        return AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.set.rawValue] + props1
    }


    // MARK: AADebugTreeCapable
    
    public override var propertyNodes: [HMDebugTree] {
        [
            .node(label: "Windscreen damage", property: windscreenDamage),
            .node(label: "Windscreen damage confidence", property: windscreenDamageConfidence),
            .node(label: "Windscreen damage detection time", property: windscreenDamageDetectionTime),
            .node(label: "Windscreen damage zone", property: windscreenDamageZone),
            .node(label: "Windscreen needs replacement", property: windscreenNeedsReplacement),
            .node(label: "Windscreen zone matrix", property: windscreenZoneMatrix),
            .node(label: "Wipers intensity", property: wipersIntensity),
            .node(label: "Wipers status", property: wipersStatus)
        ]
    }
}