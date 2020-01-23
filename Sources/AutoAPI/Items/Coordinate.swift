//
//  The MIT License
//
//  Copyright (c) 2014- High-Mobility GmbH (https://high-mobility.com)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//
//
//  Coordinate.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 20/12/2017.
//

import Foundation


#if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)
    import CoreLocation
    public typealias Coordinate = CLLocationCoordinate2D
#else
    public struct Coordinate {

        public var latitude: Double
        public var longitude: Double


        public init(latitude: Double, longitude: Double) {
            self.latitude = latitude
            self.longitude = longitude
        }
    }

    extension Coordinate: Equatable {

        public static func ==(lhs: Coordinate, rhs: Coordinate) -> Bool {
            return (lhs.latitude == rhs.latitude) && (lhs.longitude == rhs.longitude)
        }
    }
#endif


extension Coordinate {

    var bytes: [UInt8] {
        return Float(latitude).bytes + Float(longitude).bytes
    }
}

extension Coordinate: BinaryInitable {

    init?<C>(_ binary: C) where C : Collection, C.Element == UInt8 {
        guard binary.count >= 8 else {
            return nil
        }

        let latitudeBytes = Float(binary.bytes.prefix(upTo: 4))
        let longitudeBytes = Float(binary.dropFirstBytes(4))

        self.init(latitude: Double(latitudeBytes), longitude: Double(longitudeBytes))
    }
}

extension Coordinate: PropertyConvertable {

    var propertyValue: [UInt8] {
        return bytes
    }
}
