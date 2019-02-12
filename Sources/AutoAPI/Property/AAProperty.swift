//
//  AAProperty.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 25/01/2019.
//  Copyright © 2019 High Mobility. All rights reserved.
//

import Foundation


public struct AAProperty<ValueType> {

    public var failure: AAPropertyFailure?
    public var timestamp: Date?
    public var value: ValueType?


    init?(property: AABasicProperty, properties: AAProperties, valueMaker: ([UInt8]) -> ValueType?) {
        failure = properties.propertiesFailures?.first(for: property.identifier)
        timestamp = properties.propertiesTimestamps?.first(for: property.identifier, value: property.value)?.date
        value = valueMaker(property.value)

        if (failure == nil) && (timestamp == nil) && (value == nil) {
            return nil
        }
    }
}


extension AAProperties {

    // Single Convenience methods

    func property<R, T>(for propertyKeyPath: KeyPath<T, AAProperty<R>?>) -> AAProperty<R>? where R: AABinaryInitable, T: AAPropertyIdentifierGettable {
        return properties(for: propertyKeyPath, valueMaker: { R($0) })?.first
    }

    func property<R, T>(for propertyKeyPath: KeyPath<T, AAProperty<R>?>) -> AAProperty<R>? where R: RawRepresentable, R.RawValue == UInt8, T: AAPropertyIdentifierGettable {
        return properties(for: propertyKeyPath, valueMaker: { R(rawValue: $0.first) })?.first
    }

    // Multi Convenience methods

    func properties<R, T>(for propertyKeyPath: KeyPath<T, [AAProperty<R>]?>) -> [AAProperty<R>]? where R: AABinaryInitable, T: AAPropertyIdentifierGettable {
        return properties(for: propertyKeyPath, valueMaker: { R($0) })
    }

    func properties<R, T>(for propertyKeyPath: KeyPath<T, [AAProperty<R>]?>) -> [AAProperty<R>]? where R: RawRepresentable, R.RawValue == UInt8, T: AAPropertyIdentifierGettable {
        return properties(for: propertyKeyPath, valueMaker: { R(rawValue: $0.first) })
    }

    // Basic methods

    func properties<R, T, X>(for keyPath: KeyPath<T, X>, valueMaker: ([UInt8]) -> R?) -> [AAProperty<R>]? where T: AAPropertyIdentifierGettable {
        guard let identifier = T.propertyID(for: keyPath) else {
            return nil
        }

        var properties = filter(for: identifier)

        // This hack isn't cool.
        // Creates and adds a property to the list if there's a failure for it (and it didn't exist).
        if (properties.count == 0) &&
            (propertiesFailures?.contains(where: { $0.propertyID == identifier }) ?? false),
            let dummyProperty = AABasicProperty(identifier.bytes + [0x00] ) {
            // Add the created property
            properties.append(dummyProperty)
        }

        guard properties.count > 0 else {
            return nil
        }

        return properties.compactMap {
            AAProperty(property: $0, properties: self, valueMaker: valueMaker)
        }
    }
}
