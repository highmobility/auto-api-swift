//
// AutoAPI
// Copyright (C) 2019 High-Mobility GmbH
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
//  AACapability.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 17/02/2019.
//  Copyright © 2019 High Mobility GmbH. All rights reserved.
//

import Foundation
import HMUtilities


public protocol AACapability: AACapabilityClass & AAIdentifiable {

}

extension AACapability {

    public var debugTree: HMDebugTree {
        // TODO: This doesn't handle the AAProperty atm
        return HMDebugTree(self, label: nil, expandProperties: false) { (anything, label, expandProperties) -> HMDebugTree? in
            switch anything {
            case let capabilities as AACapabilities:
                let nodes: [HMDebugTree] = capabilities.capabilities?.compactMap {
                    guard let capability = $0.value else {
                        return nil
                    }

                    let idLeaf: HMDebugTree = .leaf(label: "identifier = " + String(format: "0x%04X", capability.identifier))
                    let msgTypesLeaf: HMDebugTree = .leaf(label: "supportedMessageTypes = " + capability.supportedMessageTypes.compactMap { String(format: "0x%02X", $0) }.joined(separator: ", "))

                    return .node(label: "\(capability.capability)", nodes: [idLeaf, msgTypesLeaf])
                    } ?? []

                return .node(label: label, nodes: nodes)

            case let colour as AAColour:
                let values = (colour.red, colour.green, colour.blue)

                if case .node(_, let nodes) = HMDebugTree(values, expandProperties: expandProperties) {
                    return .node(label: label, nodes: nodes)
                }
                else {
                    return .node(label: label, nodes: [HMDebugTree(values, expandProperties: expandProperties)])
                }

            case let properties as AAProperties:
                if expandProperties {
                    if Array(properties).isEmpty {
                        return .leaf(label: "properties = []")
                    }
                    else {
                        let nodes = properties.map { HMDebugTree.leaf(label: "\($0)") }

                        return .node(label: label, nodes: nodes)
                    }
                }
                else {
                    return .leaf(label: "* properties.count = \(Array(properties).count)")
                }

            default:
                return nil
            }
        }
    }
}
