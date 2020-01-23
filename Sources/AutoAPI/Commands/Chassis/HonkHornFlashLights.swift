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
//  HonkHornFlashLights.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 12/12/2017.
//

import Foundation


public struct HonkHornFlashFlights: FullStandardCommand {

    public let flasherState: FlasherState?


    // MARK: FullStandardCommand

    public let properties: Properties


    init?(properties: Properties) {
        // Ordered by the ID
        flasherState = FlasherState(rawValue: properties.first(for: 0x01)?.monoValue)

        // Properties
        self.properties = properties
    }
}

extension HonkHornFlashFlights: Identifiable {

    public static var identifier: Identifier = Identifier(0x0026)
}

extension HonkHornFlashFlights: MessageTypesGettable {

    public enum MessageTypes: UInt8, MessageTypesKind {

        case getFlasherState                    = 0x00
        case flasherState                       = 0x01
        case honkFlash                          = 0x02
        case activateDeactivateEmergencyFlasher = 0x03


        public static var all: [HonkHornFlashFlights.MessageTypes] {
            return [self.getFlasherState,
                    self.flasherState,
                    self.honkFlash,
                    self.activateDeactivateEmergencyFlasher]
        }
    }
}

public extension HonkHornFlashFlights {

    struct Settings {
        public let honkHornSeconds: UInt8?
        public let flashLightsTimes: UInt8?

        public init(honkHornSeconds: UInt8?, flashLightsTimes: UInt8?){
            self.honkHornSeconds = honkHornSeconds
            self.flashLightsTimes = flashLightsTimes
        }
    }


    /// Use `false` to *inactivate*.
    static var activateEmergencyFlasher: (Bool) -> [UInt8] {
        return {
            return commandPrefix(for: .activateDeactivateEmergencyFlasher, additionalBytes: $0.byte)
        }
    }

    static var getFlasherState: [UInt8] {
        return commandPrefix(for: .getFlasherState)
    }

    static var honkHornFlashLights: (Settings) -> [UInt8] {
        return {
            let hornBytes: [UInt8] = $0.honkHornSeconds?.propertyBytes(0x01) ?? []
            let flashBytes: [UInt8] = $0.flashLightsTimes?.propertyBytes(0x02) ?? []

            return commandPrefix(for: .honkFlash) + hornBytes + flashBytes
        }
    }
}
