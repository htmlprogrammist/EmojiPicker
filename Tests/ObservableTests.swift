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
        observable.bind { [unowned self] number in
            newValue = number
        }
    }
    
    override func tearDownWithError() throws {
        observable = nil
        newValue = nil
    }
    
    func testChangingValue() throws {
        let newNumber = 1
        
        observable.value = newNumber
        
        XCTAssertEqual(newValue, newNumber)
    }
}
