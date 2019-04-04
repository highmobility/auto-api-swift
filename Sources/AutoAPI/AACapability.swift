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

    #if PRODUCTION
    public var debugTree: HMDebugTree {
        return HMDebugTree(self, label: nil, expandProperties: false) { (anything, label, expandProperties) -> HMDebugTree? in
            switch anything {
            case let basicProperty as AABasicProperty:
                var nodes: [HMDebugTree] = []

                // Extract the values
                let string = "\(basicProperty)".replacingOccurrences(of: "AutoAPI.", with: "")

                guard string.hasPrefix("AAProperty") else {
                    return nil
                }

                guard let valueString = string.components(separatedBy: "value: ").last else {
                    return nil
                }

                if let value = self.extractValues(from: valueString, label: label) {
                    nodes.append(value)
                }

                // Access the other properties
                if let failure = basicProperty.failure {
                    nodes.append(.leaf(label: "failure = \(failure)"))
                }

                if let timestamp = basicProperty.timestamp {
                    nodes.append(.leaf(label: "timestamp = " + DateFormatter().string(from: timestamp)))
                }

                // Handle the single-value cases
                if nodes.count == 0 {
                    return .leaf(label: label + " = nil")
                }
                else if nodes.count == 1 {
                    if case .node = nodes[0] {
                        return nodes[0]
                    }
                    else {
                        return .leaf(label: label + " = " + nodes[0].label)
                    }
                }
                else {
                    return .node(label: label, nodes: nodes)
                }

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

    private func extractValues(from string: String, label: String) -> HMDebugTree? {
        guard let firstParenthesis = string.range(of: "(")?.lowerBound else {
            return .leaf(label: string)
        }

        var label = label
        var string = string
        var subString: String?

        string.removeFirst(firstParenthesis.utf16Offset(in: string) + 1)
        string.removeLast()

        // "Clean" the label
        if label.contains("AAProperty") {
            if let range = label.range(of: "<.+>", options: .regularExpression) {
                let start = label.index(range.lowerBound, offsetBy: 3)
                let end = label.index(range.upperBound, offsetBy: -1)

                label = String(label[start..<end])
            }
            else {
                label = "*"
            }
        }

        // Extract the "sub" values
        if let range = string.range(of: "AA\\w+\\(.+\\)", options: .regularExpression) {
            subString = String(string[range])

            string.replaceSubrange(range, with: "")
        }

        // Extract the "normal" values
        let nodes: [HMDebugTree] = string.components(separatedBy: ",").compactMap {
            let pieces = $0.components(separatedBy: ":").map { $0.trimmingCharacters(in: .whitespaces) }

            guard pieces.count == 2 else {
                if $0.hasPrefix(" time: ") {
                    let formatter = DateFormatter()

                    formatter.dateFormat = "YYYY-MM-dd HH:mm:ss ZZ"

                    guard let date = formatter.date(from: String($0[" time: ".endIndex...])) else {
                        return nil
                    }

                    return .leaf(label: "time = \(date)")
                }
                else {
                    return nil
                }
            }

            let label = pieces[0]
            let value = pieces[1]

            if value.isEmpty,
                let subString = subString,
                let node = extractValues(from: subString, label: label) {
                // "sub" value
                return node
            }
            else {
                // "normal" value
                let cleanedLabel = label.components(separatedBy: ".").last!
                let cleanedValue = value.components(separatedBy: ".").last!

                return .leaf(label: cleanedLabel + " = " + cleanedValue)
            }
        }

        return .node(label: label, nodes: nodes)
    }
    #endif
}
