//
//  EmojiPickerViewModelTests.swift
//  EmojiPickerTests
//
//  Created by Егор Бадмаев on 13.01.2023.
//

import XCTest
@testable import EmojiPicker

class EmojiPickerViewModelTests: XCTestCase {
    
    var emojiManagerStub: EmojiManagerStub!
    /// SUT.
    var viewModel: EmojiPickerViewModel!
    
    override func setUpWithError() throws {
        emojiManagerStub = EmojiManagerStub()
        viewModel = EmojiPickerViewModel(emojiManager: emojiManagerStub)
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        emojiManagerStub = nil
    }
    
    /// Tests default values for selected emoji.
    func testSelectedEmojiDefaultValues() throws {
        XCTAssertEqual(viewModel.selectedEmoji.value, "")
        XCTAssertEqual(viewModel.selectedEmojiCategoryIndex.value, 0)
    }
    
    func testNumberOfSectionsMethod() throws {
        let result = viewModel.numberOfSections()
        
        XCTAssertEqual(result, emojiManagerStub.emojiSet.categories.count)
    }
    
    func testNumberOfItemsMethod() throws {
        let section = 0
        
        let result = viewModel.numberOfItems(in: 0)
        
        XCTAssertEqual(result, emojiManagerStub.emojiSet.categories[section].emojis.count)
    }
    
    func testEmojiAtIndexPathMethod() throws {
        let indexPath = IndexPath(row: 1, section: 0)
        
        let result = viewModel.emoji(at: indexPath)
        
        let expectedResult = emojiManagerStub.emojiSet.emojis[
            emojiManagerStub.emojiSet.categories[indexPath.section].emojis[indexPath.row]
        ]?
            .skins[0]
            .native
        XCTAssertEqual(
            result,
            expectedResult
        )
    }
    
    func testSectionHeaderViewModelMethod() throws {
        let section = 0
        
        let result = viewModel.sectionHeaderViewModel(for: section)
        
        let expectedResult = NSLocalizedString(
            emojiManagerStub.emojiSet.categories[section].type.rawValue,
            bundle: .module,
            comment: ""
        )
        XCTAssertEqual(result, expectedResult)
    }
}
