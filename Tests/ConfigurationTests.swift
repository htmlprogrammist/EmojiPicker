//
//  ConfigurationTests.swift
//  ConfigurationTests
//
//  Created by Егор Бадмаев on 13.01.2023.
//

import XCTest
@testable import EmojiPicker

class ConfigurationTests: XCTestCase {
    
    var delegate = EmojiPickerDelegateMock()
    var sender = UIView()
    /// SUT.
    var configuration: Configuration!
    
    override func tearDownWithError() throws {
        configuration = nil
    }
    
    func testDefaultInitializer() throws {
        configuration = Configuration(delegate: delegate, sender: sender)
        
        XCTAssertEqual(configuration.selectedEmojiCategoryTintColor, nil)
        XCTAssertEqual(configuration.arrowDirection, .up)
        XCTAssertEqual(configuration.horizontalInset, 0)
        XCTAssertEqual(configuration.isDismissAfterChoosing, true)
        XCTAssertEqual(configuration.customHeight, nil)
        XCTAssertEqual(configuration.feedbackGeneratorStyle, .light)
    }
    
    func testFullDataProvided() throws {
        let selectedEmojiCategoryTintColor = UIColor.red
        let arrowDirection = PickerArrowDirectionMode.down
        let horizontalInset: CGFloat = 100
        let isDismissAfterChoosing = false
        let customHeight: CGFloat = 100
        let feedbackGeneratorStyle = UIImpactFeedbackGenerator.FeedbackStyle.medium
        
        configuration = Configuration(delegate: delegate,
                                      sender: sender,
                                      selectedEmojiCategoryTintColor: selectedEmojiCategoryTintColor,
                                      arrowDirection: arrowDirection,
                                      horizontalInset: horizontalInset,
                                      isDismissAfterChoosing: isDismissAfterChoosing,
                                      customHeight: customHeight,
                                      feedbackGeneratorStyle: feedbackGeneratorStyle
        )
        
        XCTAssertEqual(configuration.selectedEmojiCategoryTintColor, selectedEmojiCategoryTintColor)
        XCTAssertEqual(configuration.arrowDirection, arrowDirection)
        XCTAssertEqual(configuration.horizontalInset, horizontalInset)
        XCTAssertEqual(configuration.isDismissAfterChoosing, isDismissAfterChoosing)
        XCTAssertEqual(configuration.customHeight, customHeight)
        XCTAssertEqual(configuration.feedbackGeneratorStyle, feedbackGeneratorStyle)
    }
}
