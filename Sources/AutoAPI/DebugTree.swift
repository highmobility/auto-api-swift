//
// AutoAPI CLT
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
//  DebugTree.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 11/01/2018.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


extension AutoAPI {
    
    public enum DebugTree: Equatable {

        case leaf(label: String)

        indirect case node(label: String, nodes: [DebugTree])


        // MARK: Vars

        public var label: String {
            switch self {
            case .leaf(label: let label):
                return label

            case .node(label: let label, nodes: _):
                return label
            }
        }

        public var stringValue: String {
            return stringValue("")
        }


        // MARK: Methods

        public func visualise() {
            visualise("")
        }

        private func jsonValue(_ prefix: String) -> [String : Any] {
            switch self {
            case .leaf(let label):
                let components = label.components(separatedBy: " = ")

                if components.count == 2 {
                    if components[0].hasPrefix("* properties.count") {
                        return ["propertiesCount" : components[1]]
                    }
                    else {
                        return [components[0] : components[1]]
                    }
                }
                else {
                    return [label : ""]
                }

            case .node(let label, let nodes):
                return [label : nodes.map { $0.jsonValue(prefix) }]
            }
        }

        private func visualise(_ prefix: String) {
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

        private func stringValue(_ prefix: String) -> String {
            switch self {
            case .leaf(let label):
                return prefix + label + "\n"

            case .node(let label, let nodes):
                return prefix + label + " =\n" + nodes.map { $0.stringValue("\t" + prefix) }.joined()
            }
        }


        // MARK: Init

        public init(_ anything: Any, label: String? = nil, expandProperties: Bool = false) {
            let mirror = Mirror(reflecting: anything)
            let label = label ?? "\(type(of: anything))"

            // Handle some custom-ly, others by their swift-type
            if let capabilities = anything as? Capabilities {
                let nodes: [DebugTree] = capabilities.map {
                    let idLeaf: DebugTree = .leaf(label: "identifier = " + String(format: "0x%04X", $0.identifier))
                    let msgTypesLeaf: DebugTree = .leaf(label: "supportedMessageTypes = " + $0.supportedMessageTypes.map { String(format: "0x%02X", $0) }.joined(separator: ", "))

                    return .node(label: "\($0.command)", nodes: [idLeaf, msgTypesLeaf])
                }

                self = .node(label: label, nodes: nodes)
            }
            else if let colour = anything as? Colour {
                if case .node(_, let nodes) = DebugTree(colour.values, expandProperties: expandProperties) {
                    self = .node(label: label, nodes: nodes)
                }
                else {
                    self = .node(label: label, nodes: [DebugTree(colour.values, expandProperties: expandProperties)])
                }
            }
            else if let failureMessage = anything as? FailureMessage {
                let nodes: [DebugTree] = [.leaf(label: "failedMessageIdentifier = " + String(format: "0x%04X", failureMessage.failedMessageIdentifier)),
                                          .leaf(label: "failedMessageType = " + String(format: "0x%02X", failureMessage.failedMessageType)),
                                          .leaf(label: "failureDescription = \(String(describing: failureMessage.failureDescription))"),
                                          DebugTree((failureMessage.failureReason as Any), label: "failureReason", expandProperties: expandProperties),
                                          DebugTree(failureMessage.properties, expandProperties: expandProperties)]

                self = .node(label: label, nodes: nodes)
            }
            else if let properties = anything as? Properties {
                if expandProperties {
                    if properties.all.isEmpty {
                        self = .leaf(label: "properties = []")
                    }
                    else {
                        let nodes = properties.map { DebugTree.leaf(label: "\($0)") }

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
                        self = .node(label: label, nodes: array.map { DebugTree($0, expandProperties: expandProperties) })
                    }
                    else {
                        self = .leaf(label: label)
                    }

                case .`enum`:
                    self = .leaf(label: "\(label) = \(anything)")

                case .optional:
                    if let value = mirror.children.first?.value {
                        self = DebugTree(value, label: label, expandProperties: expandProperties)
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
                        let nodes = mirror.children.map { DebugTree($0.value, label: $0.label, expandProperties: expandProperties) }

                        self = .node(label: label, nodes: nodes)
                    }

                case .tuple:
                    let nodes = mirror.children.map { DebugTree($0.value, label: $0.label, expandProperties: expandProperties) }

                    self = .node(label: label, nodes: nodes)

                default:
                    self = .leaf(label: label)
                }
            }
            else {
                // Meaning it's a "simple" type – int, float, string, etc.
                self = .leaf(label: "\(label) = \(anything)")
            }
        }
    }
}
