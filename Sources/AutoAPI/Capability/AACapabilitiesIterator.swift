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
//  AACapabilitiesIterator.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 27/11/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


public struct AACapabilitiesIterator: IteratorProtocol, AAPropertiesInitable {

    private let commandTypes = AAAutoAPI.commands.compactMap { $0 as? AACommand.Type }


    // MARK: IteratorProtocol

    public typealias Element = AACapability


    public mutating func next() -> AACapability? {
        guard let property = propertiesIterator.next() else {
            return nil
        }

        let identifier = AACommandIdentifier(property.value.prefix(2))

        guard let command = commandTypes.first(where: { $0.identifier == identifier }) else {
            return nil
        }

        return AACapability(binary: property.value, command: command)
    }


    // MARK: AAPropertiesInitable

    var propertiesIterator: AAPropertiesIterator
}
