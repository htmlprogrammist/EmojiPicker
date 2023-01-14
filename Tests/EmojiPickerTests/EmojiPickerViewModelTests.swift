//
//  EmojiPickerViewModelTests.swift
//  EmojiPickerTests
//
//  Created by Егор Бадмаев on 13.01.2023.
//

import XCTest
@testable import EmojiPicker

class EmojiPickerViewModelTests: XCTestCase {
    
    var unicodeManagerStub: UnicodeManagerStub!
    /// SUT.
    var viewModel: EmojiPickerViewModel!
    
    override func setUpWithError() throws {
        unicodeManagerStub = UnicodeManagerStub()
        viewModel = EmojiPickerViewModel(unicodeManager: unicodeManagerStub)
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        unicodeManagerStub = nil
    }
    
    /// Tests default values for selected emoji.
    func testSelectedEmojiDefaultValues() throws {
        XCTAssertEqual(viewModel.selectedEmoji.value, "")
        XCTAssertEqual(viewModel.selectedEmojiCategoryIndex.value, 0)
    }
    
    func testNumberOfSectionsMethod() throws {
        let result = viewModel.numberOfSections()
        
        XCTAssertEqual(result, unicodeManagerStub.emojiCategories.count)
    }
    
    func testNumberOfItemsMethod() throws {
        let section = 0
        
        let result = viewModel.numberOfItems(in: 0)
        
        XCTAssertEqual(result, unicodeManagerStub.emojiCategories[section].emojis.count)
    }
    
    func testEmojiAtIndexPathMethod() throws {
        let indexPath = IndexPath(row: 1, section: 1)
        
        let result = viewModel.emoji(at: indexPath)
        
        XCTAssertEqual(result,
                       unicodeManagerStub.emojiCategories[indexPath.section].emojis[indexPath.row].emoji())
    }
    
    func testSectionHeaderViewModelMethod() throws {
        let section = 0
        
        let result = viewModel.sectionHeaderViewModel(for: section)
        
        XCTAssertEqual(result, unicodeManagerStub.emojiCategories[section].categoryName)
    }
}
