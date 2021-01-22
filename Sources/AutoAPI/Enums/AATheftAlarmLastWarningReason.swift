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
//  AATheftAlarmLastWarningReason.swift
//  AutoAPI
//
//  Generated by AutoAPIGenerator for Swift.
//  Copyright © 2021 High-Mobility GmbH. All rights reserved.
//

import Foundation
import HMUtilities


/// Last warning reason.
public enum AATheftAlarmLastWarningReason: String, CaseIterable, Codable, HMBytesConvertable {

    case basisAlarm
    case centerBox
    case commonAlmIn
    case doorFrontLeft
    case doorFrontRight
    case doorRearLeft
    case doorRearRight
    case glovebox
    case holdCom
    case hood
    case horn
    case its
    case itsSlv
    case noAlarm
    case panic
    case rearBox
    case remote
    case sensorVta
    case tps
    case trunk
    case unknown


    public var byteValue: UInt8 {
        switch self {
        case .noAlarm: return 0x00
        case .basisAlarm: return 0x01
        case .doorFrontLeft: return 0x02
        case .doorFrontRight: return 0x03
        case .doorRearLeft: return 0x04
        case .doorRearRight: return 0x05
        case .hood: return 0x06
        case .trunk: return 0x07
        case .commonAlmIn: return 0x08
        case .panic: return 0x09
        case .glovebox: return 0x0a
        case .centerBox: return 0x0b
        case .rearBox: return 0x0c
        case .sensorVta: return 0x0d
        case .its: return 0x0e
        case .itsSlv: return 0x0f
        case .tps: return 0x10
        case .horn: return 0x11
        case .holdCom: return 0x12
        case .remote: return 0x13
        case .unknown: return 0x14
        }
    }


    // MARK: HMBytesConvertable

    public var bytes: [UInt8] {
        [byteValue]
    }


    public init?(bytes: [UInt8]) {
        guard let uint8 = UInt8(bytes: bytes) else {
            return nil
        }

        switch uint8 {
        case 0x00: self = .noAlarm
        case 0x01: self = .basisAlarm
        case 0x02: self = .doorFrontLeft
        case 0x03: self = .doorFrontRight
        case 0x04: self = .doorRearLeft
        case 0x05: self = .doorRearRight
        case 0x06: self = .hood
        case 0x07: self = .trunk
        case 0x08: self = .commonAlmIn
        case 0x09: self = .panic
        case 0x0a: self = .glovebox
        case 0x0b: self = .centerBox
        case 0x0c: self = .rearBox
        case 0x0d: self = .sensorVta
        case 0x0e: self = .its
        case 0x0f: self = .itsSlv
        case 0x10: self = .tps
        case 0x11: self = .horn
        case 0x12: self = .holdCom
        case 0x13: self = .remote
        case 0x14: self = .unknown
        default: return nil
        }
    }
}