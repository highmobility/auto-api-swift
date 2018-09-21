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
//  AAColour.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 06/12/2017.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


#if os(macOS)
    import AppKit
    public typealias AAColour = NSColor
#elseif os(iOS) || os(tvOS)
    import UIKit
    public typealias AAColour = UIColor
#else
    public typealias CGFloat = Double

    public struct AAColour {

        public var red: CGFloat
        public var green: CGFloat
        public var blue: CGFloat
        public var alpha: CGFloat


        public init(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
            self.red = red
            self.green = green
            self.blue = blue
            self.alpha = alpha
        }
    }

    extension AAColour: Equatable {

        public static func ==(lhs: AAColour, rhs: AAColour) -> Bool {
            return (lhs.red == rhs.red) && (lhs.green == rhs.green) && (lhs.blue == rhs.blue) && (lhs.alpha == rhs.alpha)
        }
    }
#endif

extension AAColour: PropertyConvertable {

    var propertyValue: [UInt8] {
        let values = self.values

        return [values.red, values.green, values.blue]
    }
}

public extension AAColour {

    var values: (red: UInt8, green: UInt8, blue: UInt8, alpha: UInt8) {
        #if os(macOS)
            let redVal = UInt8(redComponent * 255.0)
            let greenVal = UInt8(greenComponent * 255.0)
            let blueVal = UInt8(blueComponent * 255.0)
            let alphaVal = UInt8(alphaComponent * 255.0)
        #elseif os(iOS) || os(tvOS)
            let redVal = UInt8(CIColor(color: self).red * 255.0)
            let greenVal = UInt8(CIColor(color: self).green * 255.0)
            let blueVal = UInt8(CIColor(color: self).blue * 255.0)
            let alphaVal = UInt8(CIColor(color: self).alpha * 255.0)
        #else
            let redVal = UInt8(red * 255.0)
            let greenVal = UInt8(green * 255.0)
            let blueVal = UInt8(blue * 255.0)
            let alphaVal = 0x00
        #endif

        return (red: redVal, green: greenVal, blue: blueVal, alpha: alphaVal)
    }
}
