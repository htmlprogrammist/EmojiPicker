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

/// Delegate protocol to match user interaction with emoji picker.
public protocol EmojiPickerDelegate: AnyObject {
    /// Provides chosen emoji.
    ///
    /// - Parameter emoji: String emoji.
    func didGetEmoji(emoji: String)
}

/// Emoji Picker view controller. 
public final class EmojiPickerViewController: UIViewController {
    
    // MARK: - Public Properties
    
    /// Delegate for selecting an emoji object.
    public weak var delegate: EmojiPickerDelegate?
    
    /// The view containing the anchor rectangle for the popover.
    public var sourceView: UIView? {
        didSet {
            popoverPresentationController?.sourceView = sourceView
        }
    }
    
    /**
     The direction of the arrow for EmojiPicker.
     
     - Note: The default value of this property is `.up`.
     */
    public var arrowDirection: PickerArrowDirectionMode = .up
    
    /**
     Custom height for EmojiPicker.
     
     - Note: The default value of this property is `nil`.
     - Important: it will be limited by the distance from `sourceView.origin.y` to the upper or lower bound(depends on `permittedArrowDirections`).
     */
    public var customHeight: CGFloat?
    
    /**
     Inset from the sourceView border.
     
     - Note: The default value of this property is `0`.
     */
    public var horizontalInset: CGFloat = 0
    
    /**
     A boolean value that determines whether the screen will be hidden after the emoji is selected.
     
     If this property’s value is `true`, the EmojiPicker will be dismissed after the emoji is selected.
     If you want EmojiPicker not to dismissed after emoji selection, you must set this property to `false`.
     
     - Note: The default value of this property is `true`.
     */
    public var isDismissedAfterChoosing: Bool = true
    
    /**
     Color for the selected emoji category.
     
     - Note: The default value of this property is `.systemBlue`.
     */
    public var selectedEmojiCategoryTintColor: UIColor? = .systemBlue {
        didSet {
            guard let selectedEmojiCategoryTintColor = selectedEmojiCategoryTintColor else { return }
            emojiPickerView.selectedEmojiCategoryTintColor = selectedEmojiCategoryTintColor
        }
    }
    
    /**
     Feedback generator style. To turn off, set `nil` to this parameter.
     
     - Note: The default value of this property is `.light`.
     */
    public var feedbackGeneratorStyle: UIImpactFeedbackGenerator.FeedbackStyle? {
        didSet {
            guard let feedBackGeneratorStyle = feedbackGeneratorStyle else {
                feedbackGenerator = nil
                return
            }
            feedbackGenerator = UIImpactFeedbackGenerator(style: feedBackGeneratorStyle)
        }
    }
    
    // MARK: - Private Properties
    
    /// View of this controller.
    private let emojiPickerView = EmojiPickerView()
    /// An obect that creates haptics to simulate physical impacts.
    private var feedbackGenerator: UIImpactFeedbackGenerator?
    /// View model of this module.
    private var viewModel: EmojiPickerViewModelProtocol
    
    // MARK: - Init
    
    /// Creates EmojiPicker view controller with provided configuration.
    public init() {
        let emojiManager = EmojiManager()
        viewModel = EmojiPickerViewModel(emojiManager: emojiManager)
        
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .popover
        
        setupDelegates()
        bindViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override public func loadView() {
        view = emojiPickerView
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        setupPreferredContentSize()
        setupArrowDirections()
        setupHorizontalInset()
    }
    
    // MARK: - Private Methods
    
    private func bindViewModel() {
        viewModel.selectedEmoji.bind { [unowned self] emoji in
            feedbackGenerator?.impactOccurred()
            delegate?.didGetEmoji(emoji: emoji)
            
            if isDismissedAfterChoosing {
                dismiss(animated: true, completion: nil)
            }
        }
        
        viewModel.selectedEmojiCategoryIndex.bind { [unowned self] categoryIndex in
            self.emojiPickerView.updateSelectedCategoryIcon(with: categoryIndex)
        }
    }
    
    private func setupDelegates() {
        emojiPickerView.delegate = self
        emojiPickerView.collectionView.delegate = self
        emojiPickerView.collectionView.dataSource = self
        presentationController?.delegate = self
    }
    
    /// Sets up preferred content size.
    ///
    /// - Note: The number `0.16` was taken based on the proportion of height to the width of the EmojiPicker on macOS.
    private func setupPreferredContentSize() {
        let size: CGSize = {
            switch UIDevice.current.userInterfaceIdiom {
            case .phone:
                let sideInset: CGFloat = 20
                let screenWidth: CGFloat = UIScreen.main.nativeBounds.width / UIScreen.main.nativeScale
                let popoverWidth: CGFloat = screenWidth - (sideInset * 2)
                // The number 0.16 was taken based on the proportion of height to the width of the EmojiPicker on macOS.
                let heightProportionToWidth: CGFloat = 1.16
                return CGSize(
                    width: popoverWidth,
                    height: popoverWidth * heightProportionToWidth
                )
            default:
                // macOS size
                return CGSize(width: 410, height: 460)
            }
        }()
       
        preferredContentSize = size
    }
    
    private func setupArrowDirections() {
        popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection(
            rawValue: arrowDirection.rawValue
        )
    }
    
    private func setupHorizontalInset() {
        guard let sourceView = sourceView else { return }
        
        popoverPresentationController?.sourceRect = CGRect(
            x: 0,
            y: popoverPresentationController?.permittedArrowDirections == .up ? horizontalInset : -horizontalInset,
            width: sourceView.frame.width,
            height: sourceView.frame.height
        )
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension EmojiPickerViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections()
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems(in: section)
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmojiCollectionViewCell.identifier, for: indexPath) as? EmojiCollectionViewCell
        else { return UICollectionViewCell() }
        
        cell.configure(with: viewModel.emoji(at: indexPath))
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: EmojiCollectionViewHeader.identifier, for: indexPath) as? EmojiCollectionViewHeader
            else { return UICollectionReusableView() }
            
            sectionHeader.configure(with: viewModel.sectionHeaderViewModel(for: indexPath.section))
            return sectionHeader
        default:
            return UICollectionReusableView()
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        viewModel.selectedEmoji.value = viewModel.emoji(at: indexPath)
    }
}

// MARK: - UIScrollViewDelegate

extension EmojiPickerViewController: UIScrollViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        /// This code updates the selected category during scrolling.
        let indexPathsForVisibleHeaders = emojiPickerView.collectionView.indexPathsForVisibleSupplementaryElements(
            ofKind: UICollectionView.elementKindSectionHeader
        ).sorted(by: { $0.section < $1.section })
        
        if let selectedEmojiCategoryIndex = indexPathsForVisibleHeaders.first?.section,
           viewModel.selectedEmojiCategoryIndex.value != selectedEmojiCategoryIndex {
            viewModel.selectedEmojiCategoryIndex.value = selectedEmojiCategoryIndex
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension EmojiPickerViewController: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 40)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sideInsets = collectionView.contentInset.right + collectionView.contentInset.left
        let contentSize = collectionView.bounds.width - sideInsets
        return CGSize(width: contentSize / 8, height: contentSize / 8)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

// MARK: - EmojiPickerViewDelegate

extension EmojiPickerViewController: EmojiPickerViewDelegate {
    
    func didChoiceEmojiCategory(at index: Int) {
        feedbackGenerator?.impactOccurred()
        viewModel.selectedEmojiCategoryIndex.value = index
    }
}

// MARK: - UIAdaptivePresentationControllerDelegate

extension EmojiPickerViewController: UIAdaptivePresentationControllerDelegate {
    
    public func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
}
