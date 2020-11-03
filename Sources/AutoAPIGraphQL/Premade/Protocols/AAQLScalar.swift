//
//  AAQLScalar.swift
//  
//
//  Created by Mikk Rätsep on 24.07.20.
//

import AutoAPI
import Foundation
import GraphQL
import GraphQLKit
import HMUtilities
import Vapor


// TODO: convert to enum-type (with enum XXX: String prolly)
public protocol AAQLScalar: AAQLPropertyType {

    static var qlScalar: QLScalar<AAGraphQLAPIProvider, Request, Self> { get }

    init(string: String?)
}

extension AAQLScalar where Self: RawRepresentable, Self.RawValue == UInt8 {

    public static var qlScalar: QLScalar<AAGraphQLAPIProvider, Request, Self> {
        QLScalar(Self.self, serialize: {
            Map("\($0)")
        }, parse: { map in
            Self(string: map.string)
        })
    }
}
