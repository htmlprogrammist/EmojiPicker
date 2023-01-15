# EmojiPicker

Emoji picker for iOS like on macOS

<p float="left">
<img src="https://user-images.githubusercontent.com/50948518/172110164-b0dec76f-495d-4112-ad00-2708ffdda54a.gif" width="230">
<img src="https://user-images.githubusercontent.com/50948518/171909950-ebf388f3-83a1-4b63-ad54-f58ba947e3bb.png" width="230">
</p>

## Navigation

- [Installation](#installation)
    - [Swift Package Manager](#swift-package-manager)
    - [CocoaPods](#cocoapods)
    - [Manually](#manually)
- [Quick Start](#quick-start)
- [Usage](#usage)
    - [Required parameters](#required-parameters)
    - [Selected emoji category tint color](#selected-emoji-category-tint-color)
    - [Arrow direction](#arrow-direction)
    - [Horizontal inset](#horizontal-inset)
    - [Is dismiss after choosing](#is-dismiss-after-choosing)
    - [Custom height](#custom-height)
    - [Feedback generator style](#feedback-generator-style)
- [Localizations](#localizations)
- [Experiments](#experiments)

## Installation

Ready for use with Swift 4.2+ on iOS 11.1+

### Swift Package Manager

The [Swift Package Manager](https://www.swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler. It’s integrated with the Swift build system to automate the process of downloading, compiling, and linking dependencies.

In Xcode navigate to File → Swift Packages → Add Package Dependency…. Use this URL to add the dependency:

```
‌https://github.com/htmlprogrammist/EmojiPicker
```

Once you have your Swift package set up, adding as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/htmlprogrammist/EmojiPicker", .upToNextMajor(from: "3.0.0"))
]
```

### CocoaPods

The [CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate `EmojiPicker` into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'EmojiPicker', :git => 'https://github.com/htmlprogrammist/EmojiPicker'
```

### Manually

If you prefer not to use any of dependency managers, you can integrate manually. Put `Sources/EmojiPicker` folder in your Xcode project. Make sure to enable `Copy items if needed` and `Create groups`.

## Quick Start

Create `UIButton` and add selector as action:

```swift
@objc private func openEmojiPickerModule(sender: UIButton) {
    let viewController = EmojiPickerViewController()
    viewController.delegate = self
    viewController.sourceView = sender
    present(viewController, animated: true)
}
```

And then recieve emoji in the delegate method:

```swift
extension ViewController: EmojiPickerDelegate {
    func didGetEmoji(emoji: String) {
        emojiButton.setTitle(emoji, for: .normal)
    }
}
```

## Usage

### Delegate

Delegate for EmojiPicker to provide chosen emoji.

```swift
viewController.delegate = self
```

### Source View

A view containing the anchor rectangle for the popover. You can create any `UIView` instances and set them as the `sender`.

```swift
viewController.sourceView = sender
```

Also, there is way more settings for configuration:

### Selected emoji category tint color

Color for the selected emoji category. The default value of this property is `.systemBlue`.

```swift
viewController.selectedEmojiCategoryTintColor = .systemRed
```

### Arrow direction

The direction of the arrow for EmojiPicker. The default value of this property is `.up`.

```swift
viewController.arrowDirection = .up
```

### Horizontal inset

Inset from the `sourceView` border. The default value of this property is `0`.

```swift
viewController.horizontalInset = 0
```

### Is dismiss after choosing

Defines whether to dismiss emoji picker or not after choosing. The default value of this property is `true`.

```swift
viewController.isDismissedAfterChoosing = true
```

### Custom height

Custom height for EmojiPicker. The default value of this property is `nil`.

```swift
viewController.customHeight = 300
```

### Feedback generator style

Feedback generator style. To turn off, set `nil` to this parameter. The default value of this property is `.light`.

```swift
viewController.feedbackGeneratorStyle = .soft
```

## Localization

* English 🇬🇧
* Russian 🇷🇺
* Ukraine 🇺🇦
* French 🇫🇷
* German 🇩🇪
* Hindi 🇮🇳
* Turkish 🇹🇷

## Experiments

You can also play around with the project, see how it works or adapt it for yourself and immediately see the result:

1. Clone or fork this repository to yourself
1. Open `EmojiPicker.xcworkspace` file
2. Expand `Pods` target
3. Expand `Development Pods` and `EmojiPicker` directory (here you can make changes)
4. Make sure you have set `EmojiPicker-Example` as target for a run 
5. Have fun! Build & run the project
