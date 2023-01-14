//
//  ArrayExtensionTests.swift
//  EmojiPickerTests
//
//  Created by Егор Бадмаев on 13.01.2023.
//

import XCTest
@testable import EmojiPicker

class ArrayExtensionTests: XCTestCase {
    
    var array: [Int]!
    
    override func tearDownWithError() throws {
        array = nil
    }
    
    func testConvertingEmptyArray() throws {
        array = []
        
        let result = array.emoji()
        
        XCTAssertEqual(result, "")
    }
    
    func testConvertingSomeEmojis() throws {
        array = [0x1F600,
                 0x1F601,
                 0x1F602,
                 0x1F923,
                 0x1F603]
        
        let result = array.emoji()
        
        XCTAssertEqual(result, "😀😁😂🤣😃")
    }
}
