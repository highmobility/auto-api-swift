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
//  AAHonkHornFlashLights.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation
import HMUtilities


public class AAHonkHornFlashLights: AACapability {

    /// Flashers
    public enum Flashers: UInt8, AABytesConvertable {
        case inactive = 0x00
        case emergencyFlasherActive = 0x01
        case leftFlasherActive = 0x02
        case rightFlasherActive = 0x03
    }


    /// Property Identifiers for `AAHonkHornFlashLights` capability.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case flashers = 0x01
        case honkSeconds = 0x02
        case flashTimes = 0x03
        case emergencyFlashersState = 0x04
    }


    // MARK: Properties
    
    /// Flashers
    ///
    /// - returns: `Flashers` wrapped in `AAProperty<Flashers>`
    public var flashers: AAProperty<Flashers>? {
        properties.property(forID: PropertyIdentifier.flashers)
    }


    // MARK: AAIdentifiable
    
    /// Capability's Identifier
    ///
    /// - returns: `UInt16` combining the MSB and LSB
    public override class var identifier: UInt16 {
        0x0026
    }


    // MARK: Getters
    
    /// Bytes for getting the `AAHonkHornFlashLights` state.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *request* the state of `AAHonkHornFlashLights`.
    ///
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func getFlashersState() -> Array<UInt8> {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.get.rawValue]
    }


    // MARK: Setters
    
    /// Bytes for *honk flash* command.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *honk flash* in `AAHonkHornFlashLights`.
    /// 
    /// - parameters:
    ///   - honkSeconds: Number of seconds to honk the horn as `UInt8`
    ///   - flashTimes: Number of times to flash the lights as `UInt8`
    /// - returns: Command's bytes as `Array<UInt8>?`
    public static func honkFlash(honkSeconds: UInt8?, flashTimes: UInt8?) -> Array<UInt8>? {
        guard (honkSeconds != nil || flashTimes != nil) else {
            return nil
        }
    
        let props1 = AAProperty(identifier: PropertyIdentifier.honkSeconds, value: honkSeconds).bytes + AAProperty(identifier: PropertyIdentifier.flashTimes, value: flashTimes).bytes
    
        return AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.set.rawValue] + props1
    }
    
    /// Bytes for *activate deactivate emergency flasher* command.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *activate deactivate emergency flasher* in `AAHonkHornFlashLights`.
    /// 
    /// - parameters:
    ///   - emergencyFlashersState: emergency flashers state as `AAActiveState`
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func activateDeactivateEmergencyFlasher(emergencyFlashersState: AAActiveState) -> Array<UInt8> {
        return AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.set.rawValue] + AAProperty(identifier: PropertyIdentifier.emergencyFlashersState, value: emergencyFlashersState).bytes
    }


    // MARK: AADebugTreeCapable
    
    public override var propertyNodes: [HMDebugTree] {
        [
            .node(label: "Flashers", property: flashers)
        ]
    }
}