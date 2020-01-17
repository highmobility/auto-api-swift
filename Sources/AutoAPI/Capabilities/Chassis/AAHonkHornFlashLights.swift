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
//  AAHonkHornFlashLights.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/01/2020.
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
    public static func honkFlash(honkSeconds: UInt8? = nil, flashTimes: UInt8? = nil) -> Array<UInt8>? {
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