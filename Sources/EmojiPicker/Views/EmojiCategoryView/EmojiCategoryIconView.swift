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

import UIKit

/// Describes states for `EmojiCategoryIconView`.
enum EmojiCategoryIconViewState {
    case standard
    case highlighted
    case selected
}

/// Responsible for rendering the icon for the target emoji category in the desired color.
final class EmojiCategoryIconView: UIView {
    
    // MARK: - Private Properties
    
    /// Target icon type.
    private var type: CategoryType
    /// Current tint color for the icon.
    private var currentIconTintColor: UIColor = .systemGray
    /// Selected tint color for the icon.
    private var selectedIconTintColor: UIColor
    /// Current icon state.
    private var state: EmojiCategoryIconViewState = .standard
    
    // MARK: - Init
    
    init(
        type: CategoryType,
        selectedIconTintColor: UIColor
    ) {
        self.type = type
        self.selectedIconTintColor = selectedIconTintColor
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
    }
    
    @available(*, unavailable, message: "init(coder:) has not been implemented")
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    /// New centered rect based on bounds width to prevent stretching of the icon.
    ///
    /// - Parameter state: Target icon state. Based on this state, the target color will be selected.
    func updateIconTintColor(for state: EmojiCategoryIconViewState) {
        guard self.state != state else { return }
        self.state = state
        
        switch state {
        case .standard:
            currentIconTintColor = .systemGray
            
        case .highlighted:
            currentIconTintColor = currentIconTintColor.adjust(by: 40)
            
        case .selected:
            currentIconTintColor = selectedIconTintColor
        }
        
        setNeedsDisplay()
    }
    
    // MARK: - Override Methods
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        /// New centered rect based on bounds width to prevent stretching of the icon.
        let rect = CGRect(
            origin: CGPoint(x: 0, y: (rect.height - rect.width) / 2),
            size: CGSize(width: rect.width, height: rect.width)
        )
        let drawKitService = CategoryIconsDrawKit(
            frame: rect,
            resizing: .aspectFit,
            tintColor: currentIconTintColor
        )
        
        switch type {
        case .people:
            drawKitService.drawPeopleCategory()
        case .nature:
            drawKitService.drawNatureCategory()
        case .foods:
            drawKitService.drawFoodAndDrinkCategory()
        case .activity:
            drawKitService.drawActivityCategory()
        case .places:
            drawKitService.drawTravelAndPlacesCategory()
        case .objects:
            drawKitService.drawObjectsCategory()
        case .symbols:
            drawKitService.drawSymbolsCategory()
        case .flags:
            drawKitService.drawFlagsCategory()
        }
    }
}
