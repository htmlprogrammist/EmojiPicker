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
        let result = try? JSONDecoder().decode(EmojiPicker.Category.self, from: category1)
        
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.type, CategoryType.people)
        XCTAssertEqual(result?.emojis, ["grinning", "smiley", "smile"])
    }
    
    func test_decodeCategory_arraySuccess() throws {
        let result = try? JSONDecoder().decode([EmojiPicker.Category].self, from: category3)
        
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.count, 2)
    }
    
    func test_decodeCategory_wrongCodingKeys() throws {
        let result = try? JSONDecoder().decode(EmojiPicker.Category.self, from: category2)
        
        XCTAssertNil(result)
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
    "emojis": [
        "grinning",
        "smiley",
        "smile",
    ]
}
""".utf8)

fileprivate let category3 = Data("""
[
    {
      "id": "people",
      "emojis": [
        "grinning",
        "smile",
        "zzz"
      ]
    },
    {
      "id": "nature",
      "emojis": [
        "monkey",
        "leaves",
        "dog"
      ]
    }
]
""".utf8)
