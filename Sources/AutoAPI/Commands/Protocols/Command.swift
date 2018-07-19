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
//  Command.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 14/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation
import HMUtilities


public protocol Command: Identifiable {

    var debugTree: DebugTree { get }
}

extension Command {

    public var debugTree: DebugTree {
        return DebugTree(self, label: nil, expandProperties: false) { (anything, label, expandProperties) -> DebugTree? in
            switch anything {
            case let capabilities as Capabilities:
                let nodes: [DebugTree] = capabilities.map {
                    let idLeaf: DebugTree = .leaf(label: "identifier = " + String(format: "0x%04X", $0.identifier))
                    let msgTypesLeaf: DebugTree = .leaf(label: "supportedMessageTypes = " + $0.supportedMessageTypes.map { String(format: "0x%02X", $0) }.joined(separator: ", "))

                    return .node(label: "\($0.command)", nodes: [idLeaf, msgTypesLeaf])
                }

                return .node(label: label, nodes: nodes)

            case let colour as Colour:
                if case .node(_, let nodes) = DebugTree(colour.values, expandProperties: expandProperties) {
                    return .node(label: label, nodes: nodes)
                }
                else {
                    return .node(label: label, nodes: [DebugTree(colour.values, expandProperties: expandProperties)])
                }

            case let properties as Properties:
                if expandProperties {
                    if properties.all.isEmpty {
                        return .leaf(label: "properties = []")
                    }
                    else {
                        let nodes = properties.map { DebugTree.leaf(label: "\($0)") }

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

extension Command where Self: MessageTypesGettable, Self.MessageTypes.RawValue == UInt8 {

    static func commandPrefix(for messageType: Self.MessageTypes) -> [UInt8] {
        return commandPrefix(for: messageType, additionalBytes: nil)
    }

    static func commandPrefix(for messageType: Self.MessageTypes, additionalBytes bytes: UInt8?...) -> [UInt8] {
        return Self.identifier.bytes + [messageType.rawValue] + bytes.compactMap { $0 }
    }
}
