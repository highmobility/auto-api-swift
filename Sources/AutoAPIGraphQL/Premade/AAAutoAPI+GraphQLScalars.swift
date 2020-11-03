//
//  AAAutoAPI+GraphQLScalars.swift
//  
//
//  Created by Mikk Rätsep on 29.07.20.
//

@_exported import AutoAPI // TODO: move the '@_exported import' to some more appropriate file
import Foundation
import Graphiti
import GraphQLKit
import Vapor


extension AAAutoAPI {

    public static var qlAllScalars: [QLSchemaComponent<AAGraphQLAPIProvider, Request>] {
        [
            QLScalar(Date.self, serialize: {
                Map.string(DateFormatter.hmFormatter.string(from: $0))
            }, parse: { map in
                switch map {
                case .string(let str):  return DateFormatter.hmFormatter.date(from: str)!
                default:                fatalError()
                }
            }),

            QLScalar(Int8.self, serialize: {
                Map.number(.init($0))
            }, parse: { map in
                switch map {
                case .number(let num):  return num.int8Value
                default:                fatalError()
                }
            }),

            QLScalar(UInt8.self, serialize: {
                Map.number(.init($0))
            }, parse: { map in
                switch map {
                case .number(let num):  return num.uint8Value
                default:                fatalError()
                }
            }),

            QLScalar(UInt16.self, serialize: {
                Map.number(.init($0))
            }, parse: { map in
                switch map {
                case .number(let num):  return num.uint16Value
                default:                fatalError()
                }
            }),
        ]
    }
}



extension Array: AAQLPropertyType where Element == UInt8 {

    public static var qlPropertyType: QLType<AAGraphQLAPIProvider, Request, AAProperty<Self>> {
        QLType(AAProperty<Self>.self, name: "UInt8ArrayProperty", fields: [
            QLField(.value, at: \.value),
        ])
    }
}

extension Date: AAQLPropertyType {

}

extension Double: AAQLPropertyType {

}

extension Int8: AAQLPropertyType {

}

extension String: AAQLPropertyType {

}

extension UInt8: AAQLPropertyType {
    
}

extension UInt16: AAQLPropertyType {

}
