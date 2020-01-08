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
//  AALights.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
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
    public static func controlLights(frontExteriorLight: FrontExteriorLight?, rearExteriorLight: AAActiveState?, ambientLightColour: AARGBColour?, fogLights: [AALight]?, readingLamps: [AAReadingLamp]?, interiorLights: [AALight]?) -> Array<UInt8>? {
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