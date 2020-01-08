//
// AutoAPI
// Copyright (C) 2020 High-Mobility GmbH
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
//  AAMessagingTest.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 08/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import AutoAPI
import XCTest


class AAMessagingTest: XCTestCase {

    // MARK: State Properties

    func testText() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x37, 0x01, 0x01, 0x00, 0x0b, 0x01, 0x00, 0x08, 0x48, 0x65, 0x79, 0x20, 0x6d, 0x6f, 0x6d, 0x21]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAMessaging else {
            return XCTFail("Could not parse bytes as AAMessaging")
        }
    
        XCTAssertEqual(capability.text?.value, "Hey mom!")
    }

    func testHandle() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x37, 0x01, 0x02, 0x00, 0x06, 0x01, 0x00, 0x03, 0x45, 0x70, 0x70]
    
        guard let capability = AAAutoAPI.parseBinary(bytes) as? AAMessaging else {
            return XCTFail("Could not parse bytes as AAMessaging")
        }
    
        XCTAssertEqual(capability.handle?.value, "Epp")
    }

    
    // MARK: Setters

    func testMessageReceived() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x37, 0x01] + [0x01, 0x00, 0x0b, 0x01, 0x00, 0x08, 0x48, 0x65, 0x79, 0x20, 0x6d, 0x6f, 0x6d, 0x21, 0x02, 0x00, 0x06, 0x01, 0x00, 0x03, 0x45, 0x70, 0x70]
        let setterBytes = AAMessaging.messageReceived(text: "Hey mom!", handle: "Epp")
    
        XCTAssertEqual(bytes, setterBytes)
    }
}