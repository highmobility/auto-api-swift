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
//  AAHeartRate.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation
import HMUtilities


public class AAHeartRate: AACapability {

    /// Property Identifiers for `AAHeartRate` capability.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case heartRate = 0x01
    }


    // MARK: AAIdentifiable
    
    /// Capability's Identifier
    ///
    /// - returns: `UInt16` combining the MSB and LSB
    public override class var identifier: UInt16 {
        0x0029
    }


    // MARK: Setters
    
    /// Bytes for *send heart rate* command.
    ///
    /// These bytes should be sent to a receiving vehicle (device) to *send heart rate* in `AAHeartRate`.
    /// 
    /// - parameters:
    ///   - heartRate: heart rate as `UInt8`
    /// - returns: Command's bytes as `Array<UInt8>`
    public static func sendHeartRate(heartRate: UInt8) -> Array<UInt8> {
        return AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + [AACommandType.set.rawValue] + AAProperty(identifier: PropertyIdentifier.heartRate, value: heartRate).bytes
    }


    // MARK: AADebugTreeCapable
    
    public override var propertyNodes: [HMDebugTree] {
        [
    
        ]
    }
}