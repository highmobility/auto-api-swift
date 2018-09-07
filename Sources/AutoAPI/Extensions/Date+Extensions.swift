//
//  Date+Extensions.swift
//  AutoAPICLT
//
//  Created by Mikk Rätsep on 07/09/2018.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


extension Date: BinaryInitable {

    init?<C>(_ binary: C) where C : Collection, C.Element == UInt8 {
        guard let string = String(bytes: binary, encoding: .utf8) else {
            return nil
        }

        // TODO: create a Linux implementation (probably not implemented there yet)
        #if os(Linux)
            return nil
        #endif

        guard let date = ISO8601DateFormatter().date(from: string) else {
            return nil
        }

        self = date
    }
}

extension Date: PropertyConvertable {

    var propertyValue: [UInt8] {
        // TODO: Make the propertyValue Optional to avoid this stuff
        return ISO8601DateFormatter().string(from: self).data(using: .utf8)?.bytes ?? []
    }
}
