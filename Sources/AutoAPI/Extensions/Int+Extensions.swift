//
//  Int+Extensions.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 14/02/2019.
//  Copyright © 2019 High Mobility GmbH. All rights reserved.
//

import Foundation


extension Int {

    func sizeBytes(amount: Int) -> [UInt8] {
        return (0..<amount).map {
            (self >> ($0 * 8)).uint8
        }.reversed()
    }
}
