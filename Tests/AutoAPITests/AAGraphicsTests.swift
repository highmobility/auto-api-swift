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
//  AAGraphicsTest.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/01/2020.
//  Copyright © 2020 High-Mobility GmbH. All rights reserved.
//

import AutoAPI
import XCTest


class AAGraphicsTest: XCTestCase {

    
    // MARK: Non-state Properties

    func testImageURL() {
        let bytes: Array<UInt8> = [0x01, 0x00, 0x3c, 0x01, 0x00, 0x39, 0x68, 0x74, 0x74, 0x70, 0x73, 0x3a, 0x2f, 0x2f, 0x61, 0x62, 0x6f, 0x75, 0x74, 0x2e, 0x68, 0x69, 0x67, 0x68, 0x2d, 0x6d, 0x6f, 0x62, 0x69, 0x6c, 0x69, 0x74, 0x79, 0x2e, 0x63, 0x6f, 0x6d, 0x2f, 0x61, 0x73, 0x73, 0x65, 0x74, 0x73, 0x2f, 0x69, 0x6d, 0x61, 0x67, 0x65, 0x73, 0x2f, 0x68, 0x6d, 0x2d, 0x6c, 0x6f, 0x67, 0x6f, 0x2e, 0x73, 0x76, 0x67]
    
        guard let property: AAProperty<String> = AAOpaqueProperty(bytes: bytes)?.property() else {
            return XCTFail("Could not create a property for .imageURL")
        }
    
        XCTAssertEqual(property.value, "https://about.high-mobility.com/assets/images/hm-logo.svg")
    }

    
    // MARK: Setters

    func testDisplayImage() {
        let bytes: Array<UInt8> = [0x0b, 0x00, 0x51, 0x01] + [0x01, 0x00, 0x3c, 0x01, 0x00, 0x39, 0x68, 0x74, 0x74, 0x70, 0x73, 0x3a, 0x2f, 0x2f, 0x61, 0x62, 0x6f, 0x75, 0x74, 0x2e, 0x68, 0x69, 0x67, 0x68, 0x2d, 0x6d, 0x6f, 0x62, 0x69, 0x6c, 0x69, 0x74, 0x79, 0x2e, 0x63, 0x6f, 0x6d, 0x2f, 0x61, 0x73, 0x73, 0x65, 0x74, 0x73, 0x2f, 0x69, 0x6d, 0x61, 0x67, 0x65, 0x73, 0x2f, 0x68, 0x6d, 0x2d, 0x6c, 0x6f, 0x67, 0x6f, 0x2e, 0x73, 0x76, 0x67]
        let setterBytes = AAGraphics.displayImage(imageURL: "https://about.high-mobility.com/assets/images/hm-logo.svg")
    
        XCTAssertEqual(bytes, setterBytes)
    }
}