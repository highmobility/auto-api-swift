//
//  AAQLMeasurement.swift
//  
//
//  Created by Mikk Rätsep on 24.07.20.
//

import AutoAPI
import Foundation
import GraphQLKit
import Vapor


extension Measurement: FieldKeyProvider {

    public enum FieldKey: String {
        case unit   // todo
        case value
    }
}


public protocol AAQLMeasurement: AAUnitType {

    // TODO: make this protocol work
//    static var qlMeasurement: QLType<AAGraphQLAPIProvider, Request, Measurement<Self>>
}
