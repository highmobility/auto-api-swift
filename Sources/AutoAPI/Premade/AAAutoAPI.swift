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
//  AAAutoAPI.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 15.06.20.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation
import HMUtilities


public struct AAAutoAPI {

    /// Parse bytes `[UInt8]` to a capability.
    ///
    /// This is the *main* access point for parsing data into an easily usable capability.
    ///
    /// After a capability is parsed, it should be cast into the desired type.
    ///
    /// ```
    /// if let charging = AAAutoAPI.parseBytes(bytes) as? AACharging {
    ///     // code
    /// }
    /// ```
    ///
    /// - parameters:
    ///    - bytes: Bytes of a capability's *state* in `[UInt8]`
    ///
    /// - returns: The parsed capability (if a match is found) as `AACapability`
    public static func parseBytes(_ bytes: [UInt8]) throws -> AACapability? {
        guard bytes.count >= 4 else {
            throw AAError.insufficientBytes
        }

        // Check if the data is for the correct version
        guard bytes[0] == protocolVersion else {
            throw AAError.invalidVersion
        }

        let capabilityID = UInt16(bytes: bytes[1...2])!

        return capabilities.first { $0.identifier == capabilityID }?.init(bytes: bytes)
    }
}
