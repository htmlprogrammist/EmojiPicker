//
//  ObservableTests.swift
//  EmojiPickerTests
//
//  Created by Егор Бадмаев on 13.01.2023.
//

import XCTest
@testable import EmojiPicker

class ObservableTests: XCTestCase {
    
    var observable: Observable<Int>!
    var newValue: Int!
    
    override func setUpWithError() throws {
        observable = Observable(value: 0)
    }
    
    override func tearDownWithError() throws {
        observable = nil
        newValue = nil
    }
    
    func testChangingValueWithBinding() throws {
        let newNumber = 1
        observable.bind { [unowned self] number in
            newValue = number
        }
        
        observable.value = newNumber
        
        XCTAssertEqual(newValue, newNumber)
    }
    
    func testChangingValueWithoutBinding() throws {
        let newNumber = 1
        
        observable.value = newNumber
        
        XCTAssertNil(newValue)
        XCTAssertNotEqual(newValue, newNumber)
    }
}
