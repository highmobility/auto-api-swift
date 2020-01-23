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
//  Colour.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 06/12/2017.
//

import Foundation


#if os(macOS)
    import AppKit
    public typealias Colour = NSColor
#elseif os(iOS) || os(tvOS)
    import UIKit
    public typealias Colour = UIColor
#else
    public typealias CGFloat = Double

    public struct Colour {

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

    extension Colour: Equatable {

        public static func ==(lhs: Colour, rhs: Colour) -> Bool {
            return (lhs.red == rhs.red) && (lhs.green == rhs.green) && (lhs.blue == rhs.blue) && (lhs.alpha == rhs.alpha)
        }
    }
#endif

extension Colour: PropertyConvertable {

    var propertyValue: [UInt8] {
        let values = self.values

        return [values.red, values.green, values.blue]
    }
}

public extension Colour {

    var values: (red: UInt8, green: UInt8, blue: UInt8, alpha: UInt8) {
        #if os(macOS)
            let redVal = UInt8(redComponent * 255.0)
            let greenVal = UInt8(greenComponent * 255.0)
            let blueVal = UInt8(blueComponent * 255.0)
        #elseif os(iOS) || os(tvOS)
            let redVal = UInt8(CIColor(color: self).red * 255.0)
            let greenVal = UInt8(CIColor(color: self).green * 255.0)
            let blueVal = UInt8(CIColor(color: self).blue * 255.0)
        #else
            let redVal = UInt8(red * 255.0)
            let greenVal = UInt8(green * 255.0)
            let blueVal = UInt8(blue * 255.0)
        #endif

        return (red: redVal, green: greenVal, blue: blueVal, alpha: 0x00)
    }
}
