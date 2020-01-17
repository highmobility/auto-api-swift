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
//  AARooftopControl.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation
import HMUtilities


public class AARooftopControl: AACapability {

    /// Convertible roof state
    public enum ConvertibleRoofState: UInt8, AABytesConvertable {
        case closed = 0x00
        case open = 0x01
        case emergencyLocked = 0x02
        case closedSecured = 0x03
        case openSecured = 0x04
        case hardTopMounted = 0x05
        case intermediatePosition = 0x06
        case loadingPosition = 0x07
        case loadingPositionImmediate = 0x08
    }
    
    /// Sunroof state
    public enum SunroofState: UInt8, AABytesConvertable {
        case closed = 0x00
        case open = 0x01
        case intermediate = 0x02
    }
    
    /// Sunroof tilt state
    public enum SunroofTiltState: UInt8, AABytesConvertable {
        case closed = 0x00
        case tilted = 0x01
        case halfTilted = 0x02
    }


    /// Property Identifiers for `AARooftopControl` capability.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case dimming = 0x01
        case position = 0x02
        case convertibleRoofState = 0x03
        case sunroofTiltState = 0x04
        case sunroofState = 0x05
    }


    // MARK: Properties
    
    /// Convertible roof state
    ///
    /// - returns: `ConvertibleRoofState` wrapped in `AAProperty<ConvertibleRoofState>`
    public var convertibleRoofState: AAProperty<ConvertibleRoofState>? {
        properties.property(forID: PropertyIdentifier.convertibleRoofState)
    }
    
    /// 1.0 (100%) is opaque, 0.0 (0%) is transparent
    ///
    /// - returns: `AAPercentage` wrapped in `AAProperty<AAPercentage>`
    public var dimming: AAProperty<AAPercentage>? {
        properties.property(forID: PropertyIdentifier.dimming)
    }
    
    /// 1.0 (100%) is fully open, 0.0 (0%) is closed
    ///
    /// - returns: `AAPercentage` wrapped in `AAProperty<AAPercentage>`
    public var position: AAProperty<AAPercentage>? {
        properties.property(forID: PropertyIdentifier.position)
    }
    
    /// Sunroof state
    ///
    /// - returns: `SunroofState` wrapped in `AAProperty<SunroofState>`
    public var sunroofState: AAProperty<SunroofState>? {
        properties.property(forID: PropertyIdentifier.sunroofState)
    }
    
    /// Sunroof tilt state
    ///
    /// - returns: `SunroofTiltState` wrapped in `AAProperty<SunroofTiltState>`
    public var sunroofTiltState: AAProperty<SunroofTiltState>? {
        properties.property(forID: PropertyIdentifier.sunroofTiltState)
    }


    // MARK: AAIdentifiable
    
    /// Capability's Identifier
    ///
    /// - returns: `UInt16` combining the MSB and LSB
    public override class var identifier: UInt16 {
        0x0025
    }


    // MARK: Getters
    
    /// Bytes for getting the `AARooftopControl` state.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *request* the state of `AARooftopControl`.
    ///
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func getRooftopState() -> Array<UInt8> {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.get.rawValue]
    }
    
    /// Bytes for getting the `AARooftopControl` state's **specific** properties.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *request* **specific** state properties of `AARooftopControl`.
    ///
    /// - parameters:
    ///   - propertyIDs: Array of requested property identifiers
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func getRooftopStateProperties(propertyIDs: PropertyIdentifier...) -> Array<UInt8> {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.get.rawValue] + propertyIDs.map { $0.rawValue }
    }


    // MARK: Setters
    
    /// Bytes for *control rooftop* command.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *control rooftop* in `AARooftopControl`.
    /// 
    /// - parameters:
    ///   - dimming: 1.0 (100%) is opaque, 0.0 (0%) is transparent as `AAPercentage`
    ///   - position: 1.0 (100%) is fully open, 0.0 (0%) is closed as `AAPercentage`
    ///   - convertibleRoofState: convertible roof state as `ConvertibleRoofState`
    ///   - sunroofTiltState: sunroof tilt state as `SunroofTiltState`
    ///   - sunroofState: sunroof state as `SunroofState`
    /// - returns: Command's bytes as `Array<UInt8>?`
    public static func controlRooftop(dimming: AAPercentage? = nil, position: AAPercentage? = nil, convertibleRoofState: ConvertibleRoofState? = nil, sunroofTiltState: SunroofTiltState? = nil, sunroofState: SunroofState? = nil) -> Array<UInt8>? {
        guard [.emergencyLocked, .closedSecured, .openSecured, .hardTopMounted, .intermediatePosition, .loadingPosition, .loadingPositionImmediate].doesNotContain(convertibleRoofState) && (dimming != nil || position != nil || convertibleRoofState != nil || sunroofTiltState != nil || sunroofState != nil) else {
            return nil
        }
    
        let props1 = AAProperty(identifier: PropertyIdentifier.dimming, value: dimming).bytes + AAProperty(identifier: PropertyIdentifier.position, value: position).bytes + AAProperty(identifier: PropertyIdentifier.convertibleRoofState, value: convertibleRoofState).bytes
        let props2 = AAProperty(identifier: PropertyIdentifier.sunroofTiltState, value: sunroofTiltState).bytes + AAProperty(identifier: PropertyIdentifier.sunroofState, value: sunroofState).bytes
    
        return AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.set.rawValue] + props1 + props2
    }


    // MARK: AADebugTreeCapable
    
    public override var propertyNodes: [HMDebugTree] {
        [
            .node(label: "Convertible roof state", property: convertibleRoofState),
            .node(label: "Dimming", property: dimming),
            .node(label: "Position", property: position),
            .node(label: "Sunroof state", property: sunroofState),
            .node(label: "Sunroof tilt state", property: sunroofTiltState)
        ]
    }
}