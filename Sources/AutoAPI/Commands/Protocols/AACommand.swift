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
//  AACommand.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 14/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation
import HMUtilities


public protocol AACommand: AAIdentifiable {

    // FIXME: Not sure this should be here
    var debugTree: HMDebugTree { get }
}

extension AACommand {

    public var debugTree: HMDebugTree {
        return HMDebugTree(self, label: nil, expandProperties: false) { (anything, label, expandProperties) -> HMDebugTree? in
            switch anything {
            case let capabilities as AACapabilities:
                let nodes: [HMDebugTree] = capabilities.map {
                    let idLeaf: HMDebugTree = .leaf(label: "identifier = " + String(format: "0x%04X", $0.identifier))
                    let msgTypesLeaf: HMDebugTree = .leaf(label: "supportedMessageTypes = " + $0.supportedMessageTypes.map { String(format: "0x%02X", $0) }.joined(separator: ", "))

                    return .node(label: "\($0.command)", nodes: [idLeaf, msgTypesLeaf])
                }

                return .node(label: label, nodes: nodes)

            case let colour as AAColour:
                if case .node(_, let nodes) = HMDebugTree(colour.values, expandProperties: expandProperties) {
                    return .node(label: label, nodes: nodes)
                }
                else {
                    return .node(label: label, nodes: [HMDebugTree(colour.values, expandProperties: expandProperties)])
                }

            case let properties as AAProperties:
                if expandProperties {
                    if properties.all.isEmpty {
                        return .leaf(label: "properties = []")
                    }
                    else {
                        let nodes = properties.map { HMDebugTree.leaf(label: "\($0)") }

                        return .node(label: label, nodes: nodes)
                    }
                }
                else {
                    return .leaf(label: "* properties.count = \(properties.all.count)")
                }

            default:
                return nil
            }
        }
    }
}
