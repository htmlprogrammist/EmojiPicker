//
//  CategoryTests.swift
//  EmojiPicker-Unit-Tests
//
//  Created by Егор Бадмаев on 25.01.2023.
//

import XCTest
@testable import EmojiPicker

class CategoryTests: XCTestCase {
    
    var category: EmojiPicker.Category!
    
    override func tearDownWithError() throws {
        category = nil
    }
    
    func test_decodeCategory_success() throws {
        category = try? JSONDecoder().decode(EmojiPicker.Category.self, from: category1)
        
        XCTAssertNotNil(category, "The result of decoding should be successful")
        XCTAssertEqual(category.type, CategoryType.people)
        XCTAssertEqual(category?.identifiers, ["grinning", "smiley", "smile"])
    }
    
    func test_decodeCategory_wrongCodingKeys1() throws {
        category = try? JSONDecoder().decode(EmojiPicker.Category.self, from: category2)
        
        XCTAssertNil(category)
    }
    
    func test_decodeCategory_wrongCodingKeys2() throws {
        category = try? JSONDecoder().decode(EmojiPicker.Category.self, from: category3)
        
        XCTAssertNil(category)
    }
    
    func test_decodeCategory_wrongCodingKeys3() throws {
        category = try? JSONDecoder().decode(EmojiPicker.Category.self, from: category4)
        
        XCTAssertNil(category)
    }
}

fileprivate let category1 = Data("""
{
    "id": "people",
    "emojis": [
        "grinning",
        "smiley",
        "smile",
    ]
}
""".utf8)

fileprivate let category2 = Data("""
{
    "type": "people",
    "identifiers": [
        "grinning",
        "smiley",
        "smile",
    ]
}
""".utf8)

fileprivate let category3 = Data("""
{
    "id": "people",
    "identifiers": [
        "grinning",
        "smiley",
        "smile",
    ]
}
""".utf8)

fileprivate let category4 = Data("""
{
    "type": "people",
    "emojis": [
        "grinning",
        "smiley",
        "smile",
    ]
}
""".utf8)
