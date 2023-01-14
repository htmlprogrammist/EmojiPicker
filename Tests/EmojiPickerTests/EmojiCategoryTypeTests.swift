//
//  EmojiCategoryTypeTests.swift
//  EmojiPickerTests
//
//  Created by Егор Бадмаев on 13.01.2023.
//

import XCTest
@testable import EmojiPicker

class EmojiCategoryTypeTests: XCTestCase {
    
    /// Since we have special order for our emojis, we must test it.
    func testEmojiCategoryTypesOrder() throws {
        let people = EmojiCategoryType(rawValue: 0)
        let nature = EmojiCategoryType(rawValue: 1)
        let foodAndDrink = EmojiCategoryType(rawValue: 2)
        let activity = EmojiCategoryType(rawValue: 3)
        let travelAndPlaces = EmojiCategoryType(rawValue: 4)
        let objects = EmojiCategoryType(rawValue: 5)
        let symbols = EmojiCategoryType(rawValue: 6)
        let flags = EmojiCategoryType(rawValue: 7)
        
        XCTAssertEqual(people, EmojiCategoryType.people, "The value of this variable should equal \"people\"")
        XCTAssertEqual(nature, EmojiCategoryType.nature, "The value of this variable should equal \"nature\"")
        XCTAssertEqual(foodAndDrink, EmojiCategoryType.foodAndDrink, "The value of this variable should equal \"foodAndDrink\"")
        XCTAssertEqual(activity, EmojiCategoryType.activity, "The value of this variable should equal \"activity\"")
        XCTAssertEqual(travelAndPlaces, EmojiCategoryType.travelAndPlaces, "The value of this variable should equal \"travelAndPlaces\"")
        XCTAssertEqual(objects, EmojiCategoryType.objects, "The value of this variable should equal \"objects\"")
        XCTAssertEqual(symbols, EmojiCategoryType.symbols, "The value of this variable should equal \"symbols\"")
        XCTAssertEqual(flags, EmojiCategoryType.flags, "The value of this variable should equal \"flags\"")
    }
    
    /// Signals (fails) us about new emoji category, that must be handled in source code. That is why we test it.
    func testNewEmojiCategoryWasAdded() throws {
        let newValue = EmojiCategoryType(rawValue: 8)
        
        XCTAssertNil(newValue)
    }
}
