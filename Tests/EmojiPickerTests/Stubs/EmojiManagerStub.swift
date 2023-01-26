//
//  EmojiManagerStub.swift
//  EmojiPicker
//
//  Created by Егор Бадмаев on 25.01.2023.
//

@testable import EmojiPicker

class EmojiManagerStub: EmojiManagerProtocol {
    
    var deviceVersion: Double {
        11.1
    }
    
    func provideEmojis() -> EmojiSet {
        emojiSet
    }
    
    var emojiSet = EmojiSet(
        categories: [
            Category(type: .people, emojis: [
                "smile",
                "laughing",
                "grin"
            ]),
            Category(type: .foods, emojis: [
                "peach"
            ]),
        ],
        emojis: [
            "smile": Emoji(
                id: "smile",
                name: "Grinning Face with Smiling Eyes",
                keywords: [],
                skins: [
                    Skin(unified: "1f604", native: "😄")
                ],
                version: 1.0),
            "laughing": Emoji(
                id: "laughing",
                name: "Grinning Squinting Face",
                keywords: [],
                skins: [
                    Skin(unified: "1f606", native: "😆")
                ],
                version: 1.0),
            "grin": Emoji(
                id: "grin",
                name: "Beaming Face with Smiling Eyes",
                keywords: [],
                skins: [
                    Skin(unified: "1f601", native: "😁")
                ],
                version: 1.0),
            "peach": Emoji(
                id: "peach",
                name: "Peach",
                keywords: [],
                skins: [
                    Skin(unified: "1f351", native: "🍑")
                ],
                version: 1.0),
        ],
        aliases: [:]
    )
}
