//
//  UnicodeManagerTests.swift
//  EmojiPickerTests
//
//  Created by Егор Бадмаев on 13.01.2023.
//

import XCTest
@testable import EmojiPicker

class UnicodeManagerTests: XCTestCase {
    
    /// SUT.
    var unicodeManager: UnicodeManager!
    
    override func setUpWithError() throws {
        unicodeManager = UnicodeManager()
    }
    
    override func tearDownWithError() throws {
        unicodeManager = nil
    }
    
    /**
     Tests getting emojis for device's iOS version.
     
     Due to the fact that the tests can be run on different devices, we have to check that the answer does not come to us an empty array.
     */
    func testGettingEmojisForCurrentIOSVersion() throws {
        let result = unicodeManager.getEmojisForCurrentIOSVersion()
        
        XCTAssertGreaterThan(result.count, 0)
    }
    
    /**
     Tests getting title for `flags` emoji category.
     
     Unit-tests has no access to resource bundle so the result will be `"flags"`.
     But this access has CocoaPods, when it is time to do `pod lib lint`. That is why we test it in this way:
     * If the `result` is not equal to the expected ones, we fail our test.
     */
    func testGettingEmojiCategoryTitle() throws {
        let emojiCategory = EmojiCategoryType.flags
        
        let result = unicodeManager.getEmojiCategoryTitle(for: emojiCategory)
        
        if result != "flags" && result != "FLAGS" {
            XCTFail("The expected output should be one of the expected ones, instead we got: \(result)")
        }
    }
}
