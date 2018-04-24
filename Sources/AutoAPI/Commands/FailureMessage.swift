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
//  FailureMessage.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 28/11/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct FailureMessage: InboundCommand {

    public let failedMessageIdentifier: Identifier?
    public let failedMessageType: UInt8?
    public let failureDescription: String?
    public let failureReason: FailureReason?


    // MARK: InboundCommand

    public let properties: Properties


    init?(_ messageType: UInt8, properties: Properties) {
        guard messageType == 0x01 else {
            return nil
        }

        failedMessageIdentifier = properties.value(for: 0x01)
        failedMessageType = properties.value(for: 0x02)
        failureReason = FailureReason(rawValue: properties.first(for: 0x03)?.monoValue)
        failureDescription = properties.value(for: 0x04)

        // Properties
        self.properties = properties
    }
}

extension FailureMessage: Identifiable {

    public static var identifier: Identifier = Identifier(0x0002)
}

extension FailureMessage: MessageTypesGettable {

    public enum MessageTypes: UInt8, MessageTypesKind {

        case failure = 0x01


        public static var all: [FailureMessage.MessageTypes] {
            return [self.failure]
        }
    }
}
