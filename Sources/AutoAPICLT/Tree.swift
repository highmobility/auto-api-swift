//
// AutoAPI CLT
// Copyright (C) 2017 High-Mobility GmbH
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
//  Tree.swift
//  AutoAPI CLT
//
//  Created by Mikk Rätsep on 11/01/2018.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import AutoAPI
import Foundation


enum Tree {

    case leaf(label: String)

    indirect case node(label: String, nodes: [Tree])


    // MARK: Methods

    func visualise(_ prefix: String = "") {
        switch self {
        case .leaf(let label):
            print(prefix + label)

        case .node(let label, let nodes):
            print(prefix + label + " =")

            nodes.forEach {
                $0.visualise("\t" + prefix)
            }
        }
    }


    // MARK: Init

    init(_ anything: Any, label: String? = nil) {
        let mirror = Mirror(reflecting: anything)
        let label = label ?? "\(type(of: anything))"

        if let capabilities = anything as? Capabilities {
            let nodes: [Tree] = capabilities.map {
                let idLeaf: Tree = .leaf(label: "identifier = " + String(format: "0x%04X", $0.identifier))
                let msgTypesLeaf: Tree = .leaf(label: "supportedMessageTypes = " + $0.supportedMessageTypes.map { String(format: "0x%02X", $0) }.joined(separator: ", "))

                return .node(label: "\($0.command)", nodes: [idLeaf, msgTypesLeaf])
            }

            self = .node(label: label, nodes: nodes)
        }
        else if let colour = anything as? Colour {
            if case .node(_, let nodes) = Tree(colour.values) {
                self = .node(label: label, nodes: nodes)
            }
            else {
                self = .node(label: label, nodes: [Tree(colour.values)])
            }
        }
        else if let properties = anything as? Properties {
            if expandProperties {
                if properties.all.isEmpty {
                    self = .leaf(label: "properties = []")
                }
                else {
                    let nodes = properties.map { Tree.leaf(label: "\($0)") }

                    self = .node(label: label, nodes: nodes)
                }
            }
            else {
                self = .leaf(label: "* properties.count = \(properties.all.count)")
            }
        }
        else if let displayStyle = mirror.displayStyle {
            switch displayStyle {
            case .collection:
                if let array = anything as? Array<Any> {
                    self = .node(label: label, nodes: array.map { Tree($0) })
                }
                else {
                    self = .leaf(label: label)
                }

            case .`enum`:
                self = .leaf(label: "\(label) = \(anything)")

            case .optional:
                if let value = mirror.children.first?.value {
                    self = Tree(value, label: label)
                }
                else {
                    self = .leaf(label: label + " = nil")
                }

            case .`struct`:
                // A horrible way to (try to) handle OptionSets
                if anything is CustomStringConvertible, mirror.children.count == 1, mirror.children.first?.label == "rawValue" {
                    self = .leaf(label: "\(label) = \(anything)")
                }
                else {
                    // Pass the iVar label onward
                    let nodes = mirror.children.map { Tree($0.value, label: $0.label) }

                    self = .node(label: label, nodes: nodes)
                }

            case .tuple:
                let nodes = mirror.children.map { Tree($0.value, label: $0.label) }

                self = .node(label: label, nodes: nodes)

            default:
                self = .leaf(label: label)
            }
        }
            // Meaning it's a "simple" type – int, float, string, etc.
        else {
            self = .leaf(label: "\(label) = \(anything)")
        }
    }
}
