//
//  PickerArrowDirectionModeTests.swift
//  EmojiPickerTests
//
//  Created by Егор Бадмаев on 13.01.2023.
//

import XCTest
@testable import EmojiPicker

class PickerArrowDirectionModeTests: XCTestCase {
    
    var arrowDirection: PickerArrowDirectionMode!
    
    override func tearDownWithError() throws {
        arrowDirection = nil
    }
    
    func testSuccessInitValue1() throws {
        arrowDirection = PickerArrowDirectionMode(rawValue: 1)
        
        XCTAssertEqual(PickerArrowDirectionMode.up, arrowDirection)
    }
    
    func testSuccessInitValue2() throws {
        arrowDirection = PickerArrowDirectionMode(rawValue: 2)
        
        XCTAssertEqual(PickerArrowDirectionMode.down, arrowDirection)
    }
    
    func testFailureInitValue0() throws {
        arrowDirection = PickerArrowDirectionMode(rawValue: 0)
        
        XCTAssertNil(arrowDirection)
    }
    
    func testFailureInitAllLeftValues() throws {
        for i in 3...100 {
            arrowDirection = PickerArrowDirectionMode(rawValue: UInt(i))
            XCTAssertNil(arrowDirection)
        }
    }
}
