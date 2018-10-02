//
// AutoAPI
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
//  AACoordinate.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 20/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


#if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)
    import CoreLocation

    public typealias AACoordinate = CLLocationCoordinate2D
#else
    public struct AACoordinate {

        public var latitude: Double
        public var longitude: Double


        public init(latitude: Double, longitude: Double) {
            self.latitude = latitude
            self.longitude = longitude
        }
    }

    extension AACoordinate: Equatable {

        public static func ==(lhs: AACoordinate, rhs: AACoordinate) -> Bool {
            return (lhs.latitude == rhs.latitude) && (lhs.longitude == rhs.longitude)
        }
    }
#endif


extension AACoordinate {

    var bytes: [UInt8] {
        return latitude.bytes + longitude.bytes
    }
}

extension AACoordinate: AABinaryInitable {

    init?<C>(_ binary: C) where C : Collection, C.Element == UInt8 {
        guard binary.count >= 16 else {
            return nil
        }

        let latitudeBytes = Double(binary.bytes.prefix(upTo: 8))
        let longitudeBytes = Double(binary.dropFirstBytes(8))

        self.init(latitude: Double(latitudeBytes), longitude: Double(longitudeBytes))
    }
}

extension AACoordinate: AAPropertyConvertable {

    var propertyValue: [UInt8] {
        return bytes
    }
}
