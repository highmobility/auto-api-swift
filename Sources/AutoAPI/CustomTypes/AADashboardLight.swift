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
//  AADashboardLight.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import Foundation


/// Dashboard light
public struct AADashboardLight: AABytesConvertable, Equatable {

    /// Name
    public enum Name: UInt8, AABytesConvertable {
        case highBeam = 0x00
        case lowBeam = 0x01
        case hazardWarning = 0x02
        case brakeFailure = 0x03
        case hatchOpen = 0x04
        case fuelLevel = 0x05
        case engineCoolantTemperature = 0x06
        case batteryChargingCondition = 0x07
        case engineOil = 0x08
        case positionLights = 0x09
        case frontFogLight = 0x0a
        case rearFogLight = 0x0b
        case parkHeating = 0x0c
        case engineIndicator = 0x0d
        case serviceCall = 0x0e
        case transmissionFluidTemperature = 0x0f
        case transmissionFailure = 0x10
        case antiLockBrakeFailure = 0x11
        case wornBrakeLinings = 0x12
        case windscreenWasherFluid = 0x13
        case tireFailure = 0x14
        case engineOilLevel = 0x15
        case engineCoolantLevel = 0x16
        case steeringFailure = 0x17
        case escIndication = 0x18
        case brakeLights = 0x19
        case adblueLevel = 0x1a
        case fuelFilterDiffPressure = 0x1b
        case seatBelt = 0x1c
        case advancedBraking = 0x1d
        case acc = 0x1e
        case trailerConnected = 0x1f
        case airbag = 0x20
        case escSwitchedOff = 0x21
        case laneDepartureWarningOff = 0x22
    }

    /// State
    public enum State: UInt8, AABytesConvertable {
        case inactive = 0x00
        case info = 0x01
        case yellow = 0x02
        case red = 0x03
    }


    /// Name
    public let name: Name

    /// State
    public let state: State


    /// Initialise `AADashboardLight` with parameters.
    ///
    /// - parameters:
    ///   - name: Name as `Name`
    ///   - state: State as `State`
    public init(name: Name, state: State) {
        var bytes: Array<UInt8> = []
    
        bytes += name.bytes
        bytes += state.bytes
    
        self.bytes = bytes
        self.name = name
        self.state = state
    }


    // MARK: AABytesConvertable
    
    /// `AADashboardLight` bytes
    ///
    /// - returns: Bytes of `AADashboardLight` in `Array<UInt8>`
    public let bytes: Array<UInt8>
    
    
    /// Initialise `AADashboardLight` with bytes.
    ///
    /// - parameters:
    ///   - bytes: Array of bytes in `Array<UInt8>`
    public init?(bytes: Array<UInt8>) {
        guard bytes.count == 2 else {
            return nil
        }
    
        guard let name = Name(bytes: bytes[0..<1]),
            let state = State(bytes: bytes[1..<2]) else {
                return nil
        }
    
        self.bytes = bytes
        self.name = name
        self.state = state
    }
}