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

/// Delegate for event handling in `EmojiPickerView`.
protocol EmojiPickerViewDelegate: AnyObject {
    /// Processes an event by category selection.
    ///
    /// - Parameter index: Index of the selected category.
    func didChoiceEmojiCategory(at index: Int)
}

final class EmojiPickerView: UIView {
    
    private enum Constants {
        static let separatorViewHeight: CGFloat = 1
        static let categoriesStackViewSideInset: CGFloat = 16
        static let verticalScrollIndicatorTopInset: CGFloat = 8
        static let collectionViewMinimumLineSpacing: CGFloat = 0
        static let collectionViewMinimumInteritemSpacing: CGFloat = 0
        static let categoriesStackViewHeightMultiplier: CGFloat = 0.13
        static let collectionViewContentInsets: UIEdgeInsets = .init(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    // MARK: - Internal Properties
    
    weak var delegate: EmojiPickerViewDelegate?
    
    var selectedEmojiCategoryTintColor: UIColor = .systemBlue
    
    let collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionHeadersPinToVisibleBounds = true
        layout.minimumLineSpacing = Constants.collectionViewMinimumLineSpacing
        layout.minimumInteritemSpacing = Constants.collectionViewMinimumInteritemSpacing
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.verticalScrollIndicatorInsets.top = Constants.verticalScrollIndicatorTopInset
        collectionView.contentInset = Constants.collectionViewContentInsets
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(
            EmojiCollectionViewCell.self,
            forCellWithReuseIdentifier: EmojiCollectionViewCell.identifier
        )
        collectionView.register(
            EmojiCollectionViewHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: EmojiCollectionViewHeader.identifier
        )
        return collectionView
    }()
    
    // MARK: - Private Properties
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .separatorColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let categoriesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .popoverBackgroundColor
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var categoryViews = [TouchableEmojiCategoryView]()
    private var selectedCategoryIndex: Int = .zero
    
    /**
     Describes height for `categoriesStackView`.
     
     The height is calculated based on the ratio of the proportions of the width ...
     The number `0.13` was taken based on the proportion of this element to the width of the emoji picker on macOS.
     */
    // TODO: Описать по-другому этот комментарий (как написан первый)
    private var categoriesStackViewHeight: CGFloat {
        bounds.width * Constants.categoriesStackViewHeightMultiplier
    }
    private var categoriesStackHeightConstraint: NSLayoutConstraint?
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupCategoryViews()
    }
    
    @available(*, unavailable, message: "init(coder:) has not been implemented")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        setupView()
    }
    
    /// Passes the index of the selected category to all categoryViews to update the state.
    ///
    /// - Parameter categoryIndex: Selected category index.
    func updateSelectedCategoryIcon(with categoryIndex: Int) {
        selectedCategoryIndex = categoryIndex
        categoryViews.forEach {
            $0.updateCategoryViewState(selectedCategoryIndex: categoryIndex)
        }
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        addSubview(collectionView)
        addSubview(categoriesStackView)
        addSubview(separatorView)
        
        let categoriesStackHeightConstraint = categoriesStackView.heightAnchor.constraint(
            equalToConstant: categoriesStackViewHeight
        )
        self.categoriesStackHeightConstraint = categoriesStackHeightConstraint
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: safeAreaInsets.top),
            collectionView.bottomAnchor.constraint(equalTo: separatorView.topAnchor),
            
            categoriesStackView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: Constants.categoriesStackViewSideInset
            ),
            categoriesStackView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -Constants.categoriesStackViewSideInset
            ),
            categoriesStackView.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: -safeAreaInsets.bottom
            ),
            categoriesStackHeightConstraint,
            
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            separatorView.topAnchor.constraint(equalTo: categoriesStackView.topAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: Constants.separatorViewHeight)
        ])
    }
    
    private func setupCategoryViews() {
        backgroundColor = .popoverBackgroundColor
        categoriesStackHeightConstraint?.constant = categoriesStackViewHeight
        categoryViews = []
        categoriesStackView.subviews.forEach { $0.removeFromSuperview() }
        
        var index = 0
        for type in CategoryType.allCases {
            let categoryView = TouchableEmojiCategoryView(
                delegate: self,
                categoryIndex: index,
                categoryType: type,
                selectedEmojiCategoryTintColor: selectedEmojiCategoryTintColor
            )
            
            /// We need to set _selected_ state for the first category (default at the start).
            categoryView.updateCategoryViewState(selectedCategoryIndex: selectedCategoryIndex)
            categoryViews.append(categoryView)
            categoriesStackView.addArrangedSubview(categoryView)
            index += 1
        }
    }
    
    /// Scrolls collection view to the header of selected category.
    ///
    /// - Parameter section: Selected category index.
    private func scrollToHeader(for section: Int) {
        let indexPath = IndexPath(item: 0, section: section)
        
        guard let cellFrame = collectionView.collectionViewLayout.layoutAttributesForItem(
                at: indexPath
              )?.frame,
              let headerFrame = collectionView.collectionViewLayout.layoutAttributesForSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                at: indexPath
              )?.frame
        else { return }
        
        let offset = CGPoint(
            x: -collectionView.contentInset.left,
            y: cellFrame.minY - headerFrame.height
        )
        collectionView.setContentOffset(offset, animated: false)
    }
}

// MARK: - EmojiCategoryViewDelegate

extension EmojiPickerView: EmojiCategoryViewDelegate {
    
    func didChoiceCategory(at index: Int) {
        scrollToHeader(for: index)
        delegate?.didChoiceEmojiCategory(at: index)
    }
}
