//
// AutoAPITests
// Copyright (C) 2017 High-Mobility GmbH
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
//  VideoHandoverTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 13/12/2017.
//  Copyright © 2017 High Mobility. All rights reserved.
//

import AutoAPI
import XCTest


class VideoHandoverTests: XCTestCase {

    static var allTests = [("testVideoHandover", testVideoHandover)]


    // MARK: XCTestCase

    func testVideoHandover() {
        let bytes: [UInt8] = [
            0x00, 0x43, // MSB, LSB Message Identifier for Video Handover
            0x00,       // Message Type for Video Handover

            0x01,       // Property Identifier for Video URL
            0x00, 0x2b, // Propert size is 43 bytes
            0x68, 0x74, 0x74, 0x70, 0x73, 0x3a, 0x2f, 0x2f, 0x77, 0x77, 0x77, 0x2e, 0x79,   //
            0x6f, 0x75, 0x74, 0x75, 0x62, 0x65, 0x2e, 0x63, 0x6f, 0x6d, 0x2f, 0x77, 0x61,   //
            0x74, 0x63, 0x68, 0x3f, 0x76, 0x3d, 0x79, 0x57, 0x56, 0x42, 0x37, 0x55, 0x36,   //
            0x6d, 0x58, 0x32, 0x59, // https://www.youtube.com/watch?v=yWVB7U6mX2Y

            0x02,       // Property Identifier for Starting Second
            0x00, 0x02, // Property size is 2 bytes
            0x00, 0x5a, // Start from 1m 30s

            0x03,       // Property Identifier for Screen
            0x00, 0x01, // Property size is 1 byte
            0x00        // Show on front screen
        ]

        guard let url = URL(string: "https://www.youtube.com/watch?v=yWVB7U6mX2Y") else {
            return XCTFail("Failed to generate a URL")
        }

        let details = VideoHandover.Details(videoURL: url, startingSecond: 90, screen: .front)

        XCTAssertEqual(VideoHandover.videoHandover(details), bytes)
    }
}
