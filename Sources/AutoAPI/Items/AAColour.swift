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


public struct AAColour {

    public var red: Double
    public var green: Double
    public var blue: Double
}

extension AAColour: AABytesConvertable {

    public var bytes: [UInt8] {
        return [UInt8(red * 255.0), UInt8(green * 255.0), UInt8(blue * 255.0)]
    }


    public init?(bytes: [UInt8]) {
        guard bytes.count == 3 else {
            return nil
        }

        red = Double(bytes[0]) / 255.0
        green = Double(bytes[1]) / 255.0
        blue = Double(bytes[2]) / 255.0
    }
}

extension AAColour: Equatable {

}

#if os(macOS)
import AppKit

extension AAColour {

    var nsColor: NSColor {
        return NSColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: 1.0)
    }
}
#elseif os(iOS) || os(tvOS)
import UIKit

extension AAColour {
    var uiColor: UIColor {
        return UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: 1.0)
    }
}
#endif
