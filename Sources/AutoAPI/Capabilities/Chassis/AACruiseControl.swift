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
//  AACruiseControl.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation
import HMUtilities


public class AACruiseControl: AACapability {

    /// Limiter
    public enum Limiter: UInt8, AABytesConvertable {
        case notSet = 0x00
        case higherSpeedRequested = 0x01
        case lowerSpeedRequested = 0x02
        case speedFixed = 0x03
    }


    /// Property Identifiers for `AACruiseControl` capability.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case cruiseControl = 0x01
        case limiter = 0x02
        case targetSpeed = 0x03
        case adaptiveCruiseControl = 0x04
        case accTargetSpeed = 0x05
    }


    // MARK: Properties
    
    /// The target speed in km/h of the Adaptive Cruise Control
    ///
    /// - returns: `Int16` wrapped in `AAProperty<Int16>`
    public var accTargetSpeed: AAProperty<Int16>? {
        properties.property(forID: PropertyIdentifier.accTargetSpeed)
    }
    
    /// Adaptive cruise control
    ///
    /// - returns: `AAActiveState` wrapped in `AAProperty<AAActiveState>`
    public var adaptiveCruiseControl: AAProperty<AAActiveState>? {
        properties.property(forID: PropertyIdentifier.adaptiveCruiseControl)
    }
    
    /// Cruise control
    ///
    /// - returns: `AAActiveState` wrapped in `AAProperty<AAActiveState>`
    public var cruiseControl: AAProperty<AAActiveState>? {
        properties.property(forID: PropertyIdentifier.cruiseControl)
    }
    
    /// Limiter
    ///
    /// - returns: `Limiter` wrapped in `AAProperty<Limiter>`
    public var limiter: AAProperty<Limiter>? {
        properties.property(forID: PropertyIdentifier.limiter)
    }
    
    /// The target speed in km/h
    ///
    /// - returns: `Int16` wrapped in `AAProperty<Int16>`
    public var targetSpeed: AAProperty<Int16>? {
        properties.property(forID: PropertyIdentifier.targetSpeed)
    }


    // MARK: AAIdentifiable
    
    /// Capability's Identifier
    ///
    /// - returns: `UInt16` combining the MSB and LSB
    public override class var identifier: UInt16 {
        0x0062
    }


    // MARK: Getters
    
    /// Bytes for getting the `AACruiseControl` state.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *request* the state of `AACruiseControl`.
    ///
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func getCruiseControlState() -> Array<UInt8> {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.get.rawValue]
    }
    
    /// Bytes for getting the `AACruiseControl` state's **specific** properties.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *request* **specific** state properties of `AACruiseControl`.
    ///
    /// - parameters:
    ///   - propertyIDs: Array of requested property identifiers
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func getCruiseControlProperties(propertyIDs: PropertyIdentifier...) -> Array<UInt8> {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.get.rawValue] + propertyIDs.map { $0.rawValue }
    }


    // MARK: Setters
    
    /// Bytes for *activate deactivate cruise control* command.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *activate deactivate cruise control* in `AACruiseControl`.
    /// 
    /// - parameters:
    ///   - cruiseControl: cruise control as `AAActiveState`
    ///   - targetSpeed: The target speed in km/h as `Int16`
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func activateDeactivateCruiseControl(cruiseControl: AAActiveState, targetSpeed: Int16? = nil) -> Array<UInt8> {
        let props1 = AAProperty(identifier: PropertyIdentifier.cruiseControl, value: cruiseControl).bytes + AAProperty(identifier: PropertyIdentifier.targetSpeed, value: targetSpeed).bytes
    
        return AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.set.rawValue] + props1
    }


    // MARK: AADebugTreeCapable
    
    public override var propertyNodes: [HMDebugTree] {
        [
            .node(label: "Adaptive Cruise Control (ACC) target speed", property: accTargetSpeed),
            .node(label: "Adaptive Cruise Control", property: adaptiveCruiseControl),
            .node(label: "Cruise control", property: cruiseControl),
            .node(label: "Limiter", property: limiter),
            .node(label: "Target speed", property: targetSpeed)
        ]
    }
}