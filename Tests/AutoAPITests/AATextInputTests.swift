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
//  AATextInputTests.swift
//  AutoAPI
//
//  Generated by AutoAPIGenerator for Swift.
//  Copyright © 2021 High-Mobility GmbH. All rights reserved.
//

import Foundation
import HMUtilities
import XCTest
@testable import AutoAPI


final class AATextInputTests: XCTestCase {

    // MARK: Non-state or Deprecated Properties
    
    func testText() {
        let bytes: [UInt8] = [0x01, 0x00, 0x17, 0x01, 0x00, 0x14, 0x52, 0x65, 0x6e, 0x64, 0x65, 0x7a, 0x76, 0x6f, 0x75, 0x73, 0x20, 0x77, 0x69, 0x74, 0x68, 0x20, 0x52, 0x61, 0x6d, 0x61]
        
        guard let property: AAProperty<String> = AAOpaqueProperty(bytes: bytes)?.property() else {
            return XCTFail("Could not create a property for `.text`")
        }
        
        XCTAssertEqual(property.value, "Rendezvous with Rama")
    }


    // MARK: Setters
    
    func testTextInput() {
        let bytes: [UInt8] = [0x0c, 0x00, 0x44, 0x01, 0x01, 0x00, 0x17, 0x01, 0x00, 0x14, 0x52, 0x65, 0x6e, 0x64, 0x65, 0x7a, 0x76, 0x6f, 0x75, 0x73, 0x20, 0x77, 0x69, 0x74, 0x68, 0x20, 0x52, 0x61, 0x6d, 0x61]
        let setterBytes = AATextInput.textInput(text: "Rendezvous with Rama")
        
        XCTAssertEqual(bytes, setterBytes)
    }


    // MARK: Identifiers
    
    func testCapabilityIdentifier() {
        XCTAssertEqual(AATextInput.identifier, 0x0044)
    }
    
    func testPropeertyIdentifiers() {
        XCTAssertEqual(AATextInput.PropertyIdentifier.text.rawValue, 0x01)
    }
}