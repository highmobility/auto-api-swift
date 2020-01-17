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
//  AALights.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation
import HMUtilities


public class AALights: AACapability {

    /// Front exterior light
    public enum FrontExteriorLight: UInt8, AABytesConvertable {
        case inactive = 0x00
        case active = 0x01
        case activeWithFullBeam = 0x02
        case dlr = 0x03
        case automatic = 0x04
    }


    /// Property Identifiers for `AALights` capability.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case frontExteriorLight = 0x01
        case rearExteriorLight = 0x02
        case ambientLightColour = 0x04
        case reverseLight = 0x05
        case emergencyBrakeLight = 0x06
        case fogLights = 0x07
        case readingLamps = 0x08
        case interiorLights = 0x09
    }


    // MARK: Properties
    
    /// Ambient light colour
    ///
    /// - returns: `AARGBColour` wrapped in `AAProperty<AARGBColour>`
    public var ambientLightColour: AAProperty<AARGBColour>? {
        properties.property(forID: PropertyIdentifier.ambientLightColour)
    }
    
    /// Emergency brake light
    ///
    /// - returns: `AAActiveState` wrapped in `AAProperty<AAActiveState>`
    public var emergencyBrakeLight: AAProperty<AAActiveState>? {
        properties.property(forID: PropertyIdentifier.emergencyBrakeLight)
    }
    
    /// Fog lights
    ///
    /// - returns: Array of `AALight`-s wrapped in `[AAProperty<AALight>]`
    public var fogLights: [AAProperty<AALight>]? {
        properties.properties(forID: PropertyIdentifier.fogLights)
    }
    
    /// Front exterior light
    ///
    /// - returns: `FrontExteriorLight` wrapped in `AAProperty<FrontExteriorLight>`
    public var frontExteriorLight: AAProperty<FrontExteriorLight>? {
        properties.property(forID: PropertyIdentifier.frontExteriorLight)
    }
    
    /// Interior lights
    ///
    /// - returns: Array of `AALight`-s wrapped in `[AAProperty<AALight>]`
    public var interiorLights: [AAProperty<AALight>]? {
        properties.properties(forID: PropertyIdentifier.interiorLights)
    }
    
    /// Reading lamps
    ///
    /// - returns: Array of `AAReadingLamp`-s wrapped in `[AAProperty<AAReadingLamp>]`
    public var readingLamps: [AAProperty<AAReadingLamp>]? {
        properties.properties(forID: PropertyIdentifier.readingLamps)
    }
    
    /// Rear exterior light
    ///
    /// - returns: `AAActiveState` wrapped in `AAProperty<AAActiveState>`
    public var rearExteriorLight: AAProperty<AAActiveState>? {
        properties.property(forID: PropertyIdentifier.rearExteriorLight)
    }
    
    /// Reverse light
    ///
    /// - returns: `AAActiveState` wrapped in `AAProperty<AAActiveState>`
    public var reverseLight: AAProperty<AAActiveState>? {
        properties.property(forID: PropertyIdentifier.reverseLight)
    }


    // MARK: AAIdentifiable
    
    /// Capability's Identifier
    ///
    /// - returns: `UInt16` combining the MSB and LSB
    public override class var identifier: UInt16 {
        0x0036
    }


    // MARK: Getters
    
    /// Bytes for getting the `AALights` state.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *request* the state of `AALights`.
    ///
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func getLightsState() -> Array<UInt8> {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.get.rawValue]
    }
    
    /// Bytes for getting the `AALights` state's **specific** properties.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *request* **specific** state properties of `AALights`.
    ///
    /// - parameters:
    ///   - propertyIDs: Array of requested property identifiers
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func getLightsProperties(propertyIDs: PropertyIdentifier...) -> Array<UInt8> {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.get.rawValue] + propertyIDs.map { $0.rawValue }
    }


    // MARK: Setters
    
    /// Bytes for *control lights* command.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *control lights* in `AALights`.
    /// 
    /// - parameters:
    ///   - frontExteriorLight: front exterior light as `FrontExteriorLight`
    ///   - rearExteriorLight: rear exterior light as `AAActiveState`
    ///   - ambientLightColour: ambient light colour as `AARGBColour`
    ///   - fogLights: fog lights as `[AALight]`
    ///   - readingLamps: reading lamps as `[AAReadingLamp]`
    ///   - interiorLights: interior lights as `[AALight]`
    /// - returns: Command's bytes as `Array<UInt8>?`
    public static func controlLights(frontExteriorLight: FrontExteriorLight? = nil, rearExteriorLight: AAActiveState? = nil, ambientLightColour: AARGBColour? = nil, fogLights: [AALight]? = nil, readingLamps: [AAReadingLamp]? = nil, interiorLights: [AALight]? = nil) -> Array<UInt8>? {
        guard (frontExteriorLight != nil || rearExteriorLight != nil || ambientLightColour != nil || fogLights != nil || readingLamps != nil || interiorLights != nil) else {
            return nil
        }
    
        let props1 = AAProperty(identifier: PropertyIdentifier.frontExteriorLight, value: frontExteriorLight).bytes + AAProperty(identifier: PropertyIdentifier.rearExteriorLight, value: rearExteriorLight).bytes + AAProperty(identifier: PropertyIdentifier.ambientLightColour, value: ambientLightColour).bytes
        let props2 = AAProperty.multiple(identifier: PropertyIdentifier.fogLights, values: fogLights).flatMap { $0.bytes } + AAProperty.multiple(identifier: PropertyIdentifier.readingLamps, values: readingLamps).flatMap { $0.bytes } + AAProperty.multiple(identifier: PropertyIdentifier.interiorLights, values: interiorLights).flatMap { $0.bytes }
    
        return AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.set.rawValue] + props1 + props2
    }


    // MARK: AADebugTreeCapable
    
    public override var propertyNodes: [HMDebugTree] {
        [
            .node(label: "Ambient light colour", property: ambientLightColour),
            .node(label: "Emergency brake light", property: emergencyBrakeLight),
            .node(label: "Fog lights", properties: fogLights),
            .node(label: "Front exterior light", property: frontExteriorLight),
            .node(label: "Interior lights", properties: interiorLights),
            .node(label: "Reading lamps", properties: readingLamps),
            .node(label: "Rear exterior light", property: rearExteriorLight),
            .node(label: "Reverse light", property: reverseLight)
        ]
    }
}