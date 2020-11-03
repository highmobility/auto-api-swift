//
//  AAQLType.swift
//  
//
//  Created by Mikk Rätsep on 24.07.20.
//

import AutoAPI
import Foundation
import GraphQLKit
import HMUtilities
import Vapor


public protocol AAQLType: FieldKeyProvider, HMBytesConvertable where Self: Encodable {

    static var qlType: QLType<AAGraphQLAPIProvider, Request, Self> { get }
}
