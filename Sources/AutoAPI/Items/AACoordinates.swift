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
//  AACoordinates.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 20/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


#if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)
    import CoreLocation

    public typealias AACoordinates = CLLocationCoordinate2D
#else
    public struct AACoordinates {

        public var latitude: Double
        public var longitude: Double


        public init(latitude: Double, longitude: Double) {
            self.latitude = latitude
            self.longitude = longitude
        }
    }

    extension AACoordinates: Equatable {

        public static func ==(lhs: AACoordinates, rhs: AACoordinates) -> Bool {
            return (lhs.latitude == rhs.latitude) && (lhs.longitude == rhs.longitude)
        }
    }
#endif


extension AACoordinates: AABytesConvertable {

    public var bytes: [UInt8] {
        return latitude.bytes + longitude.bytes
    }


    public init?(bytes: [UInt8]) {
        guard bytes.count == 16 else {
            return nil
        }

        guard let latitudeBytes = Double(bytes: bytes[0...7]),
            let longitudeBytes = Double(bytes: bytes[8...15]) else {
                return nil
        }

        self.init(latitude: Double(latitudeBytes), longitude: Double(longitudeBytes))
    }
}
