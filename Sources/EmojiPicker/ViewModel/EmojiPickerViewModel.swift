// The MIT License (MIT)
//
// Copyright © 2022 Ivan Izyumkin
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import Foundation

/// Protocol for a ViewModel which is being used in `EmojiPickerViewController`.
protocol EmojiPickerViewModelProtocol {
    /// The observed variable that is responsible for the choice of emoji.
    var selectedEmoji: Observable<String> { get set }
    /// The observed variable that is responsible for the choice of emoji category.
    var selectedEmojiCategoryIndex: Observable<Int> { get set }
    /// The method returns the number of categories with emojis.
    func numberOfSections() -> Int
    /// The method returns the number of emojis in the target section.
    func numberOfItems(in section: Int) -> Int
    /// This method is responsible for getting the emoji for the target indexPath.
    func emoji(at indexPath: IndexPath) -> String
    /// The method is responsible for getting the localized name of the emoji section.
    func sectionHeaderViewModel(for section: Int) -> String
}

/// Emoji Picker view model.
final class EmojiPickerViewModel: EmojiPickerViewModelProtocol {
    
    // MARK: - Internal Properties
    
    /// Observable object of selected emoji.
    var selectedEmoji = Observable<String>(value: "")
    /// Observable object of selected category index of an emoji.
    var selectedEmojiCategoryIndex = Observable<Int>(value: 0)
    
    // MARK: - Private Properties
    
    /// Set of emojis.
    private let emojiSet: EmojiSet
    
    // MARK: - Init
    
    init(emojiManager: EmojiManagerProtocol) {
        emojiSet = emojiManager.provideEmojis()
    }
    
    // MARK: - Internal Methods
    
    func numberOfSections() -> Int {
        return emojiSet.categories.count
    }
    
    func numberOfItems(in section: Int) -> Int {
        return emojiSet.categories[section].identifiers.count
    }
    
    func emoji(at indexPath: IndexPath) -> String {
        let name = emojiSet.categories[indexPath.section].identifiers[indexPath.row]
        return emojiSet.emojis[name]?.emoji ?? "⚠️"
    }
    
    func sectionHeaderViewModel(for section: Int) -> String {
        return NSLocalizedString(
            emojiSet.categories[section].type.rawValue,
            bundle: .module,
            comment: ""
        )
    }
}
