//
//  AAQLPropertyType.swift
//  
//
//  Created by Mikk Rätsep on 15.07.20.
//

import AutoAPI
import Foundation
import GraphQLKit
import HMUtilities
import Vapor


extension AAProperty: FieldKeyProvider {

    public enum FieldKey: String {
        case timestamp  // todo
        case value
    }
}


public protocol AAQLPropertyType: HMBytesConvertable where Self: Codable {

    static var qlPropertyType: QLType<AAGraphQLAPIProvider, Request, AAProperty<Self>> { get }
}

extension AAQLPropertyType {

    public static var qlPropertyType: QLType<AAGraphQLAPIProvider, Request, AAProperty<Self>> {
        let name = "\(type(of: self))".replacingOccurrences(of: ".Type", with: "Property")

        return QLType(AAProperty<Self>.self, name: name, fields: [
            QLField(.value, at: \.value),
        ])
    }
}

extension AAQLPropertyType where Self: AAQLParentNameGettable {

    public static var qlPropertyType: QLType<AAGraphQLAPIProvider, Request, AAProperty<Self>> {
        let name = (qlParentTypeName ?? "") + "\(type(of: self))".replacingOccurrences(of: ".Type", with: "Property")

        return QLType(AAProperty<Self>.self, name: name, fields: [
            QLField(.value, at: \.value),
        ])
    }
}
