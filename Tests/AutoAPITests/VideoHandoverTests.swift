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
//  VideoHandoverTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 13/12/2017.
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
