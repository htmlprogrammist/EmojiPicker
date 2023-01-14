//
//  UnicodeManagerStub.swift
//  EmojiPicker
//
//  Created by Егор Бадмаев on 13.01.2023.
//

@testable import EmojiPicker

class UnicodeManagerStub: UnicodeManagerProtocol {
    
    var emojiCategories = [EmojiCategory(categoryName: "People", emojis: [[1, 2, 3]]),
                           EmojiCategory(categoryName: "Nature", emojis: [[1, 2], [2, 3]]),
                           EmojiCategory(categoryName: "Food", emojis: [[1], [2], [3]])]
    
    func getEmojisForCurrentIOSVersion() -> [EmojiCategory] {
        return emojiCategories
    }
}
