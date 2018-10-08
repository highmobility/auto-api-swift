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
//  AAFirmwareVersion.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 28/11/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct AAFirmwareVersion: AAInboundCommand {

    public let applicationVersion: String?
    public let hmkitVersion: AASDKVersion?
    public let hmkitBuildName: String?


    @available(*, deprecated, renamed: "hmkitVersion")
    public var carSDKVersion: AASDKVersion? {
        return hmkitVersion
    }

    @available(*, deprecated, renamed: "hmkitBuildName")
    public var carSDKBuildName: String? {
        return hmkitBuildName
    }


    // MARK: AAInboundCommand

    public let properties: AAProperties


    init?(_ messageType: UInt8, properties: AAProperties) {
        guard messageType == 0x01 else {
            return nil
        }

        // Ordered by the ID
        hmkitVersion = AASDKVersion(properties.first(for: \AAFirmwareVersion.hmkitVersion)?.value ?? [])
        hmkitBuildName = properties.value(for: \AAFirmwareVersion.hmkitBuildName)
        applicationVersion = properties.value(for: \AAFirmwareVersion.applicationVersion)

        // Properties
        self.properties = properties
    }
}

extension AAFirmwareVersion: AAIdentifiable {

    public static var identifier: AACommandIdentifier = 0x0003
}

extension AAFirmwareVersion: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case getVersion = 0x00
        case version    = 0x01
    }
}

extension AAFirmwareVersion: AAPropertyIdentifierGettable {

    static func propertyID<Type>(for keyPath: KeyPath<AAFirmwareVersion, Type>) -> AAPropertyIdentifier {
        switch keyPath {
        case \AAFirmwareVersion.hmkitVersion:       return 0x01
        case \AAFirmwareVersion.hmkitBuildName:     return 0x02
        case \AAFirmwareVersion.applicationVersion: return 0x03

        default:
            return 0x00
        }
    }
}


// MARK: Commands

public extension AAFirmwareVersion {

    static var getVersion: [UInt8] {
        return commandPrefix(for: .getVersion)
    }
}
