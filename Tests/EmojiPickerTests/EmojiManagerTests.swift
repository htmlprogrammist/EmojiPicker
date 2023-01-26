//
//  EmojiManagerTests.swift
//  EmojiPickerTests
//
//  Created by Егор Бадмаев on 25.01.2023.
//

import XCTest
@testable import EmojiPicker

class EmojiManagerTests: XCTestCase {
    
    /// SUT.
    var emojiManager: EmojiManager!
    
    override func setUpWithError() throws {
        emojiManager = EmojiManager()
    }
    
    override func tearDownWithError() throws {
        emojiManager = nil
    }
    
    /**
     Tests providing emoji set.
     
     Due to the fact that the tests can be run on different devices, we have to check that the answer does not come to us an empty array.
     */
    func testProvideEmojisMethod() throws {
        let result = emojiManager.provideEmojis()
        
        XCTAssertGreaterThan(result.emojis.count, 0)
        XCTAssertGreaterThan(result.categories.count, 0)
        XCTAssertGreaterThan(result.aliases.count, 0)
    }
}
