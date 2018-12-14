//
// AutoAPI
// Copyright (C) 2018 High-Mobility GmbH
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
//  AAMultiCommand.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 14/11/2018.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation
import HMUtilities


public struct AAMultiCommand: AAInboundCommand, AAOutboundCommand {

    public let states: [AAVehicleState]?


    // MARK: AAInboundCommand

    public let properties: AAProperties


    init?(_ messageType: UInt8, properties: AAProperties) {
        guard messageType == MessageTypes.states.rawValue else {
            return nil
        }

        let binaryTypes = AAAutoAPI.commands.compactMap { $0 as? AABinaryInitable.Type }

        /* Level 9 */
        states = properties.flatMap(for: \AAMultiCommand.states) { property in
            binaryTypes.flatMapFirst { $0.init(property.value) as? AAVehicleState }
        }

        // Properties
        self.properties = properties
    }
}

extension AAMultiCommand: AAIdentifiable {

    public static var identifier: AACommandIdentifier = 0x0013
}

extension AAMultiCommand: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case states = 0x01
        case send   = 0x02
    }
}

extension AAMultiCommand: AAPropertyIdentifierGettable {

    static func propertyID<Type>(for keyPath: KeyPath<AAMultiCommand, Type>) -> AAPropertyIdentifier {
        switch keyPath {
        case \AAMultiCommand.states: return 0x01

        default:
            return 0x00
        }
    }
}

public extension AAMultiCommand {

    static func combined(_ commands: [UInt8]...) -> [UInt8] {
        return commandPrefix(for: .send) + commands.flatMap { $0.propertyBytes(0x01) }
    }
}
