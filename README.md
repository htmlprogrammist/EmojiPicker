<p align="center">
  <br>
  <b>EmojiPicker</b> is a customizable package<br>implementing macOS-style emoji picker popover
  <br>
  <img width="640" alt="Emoji Picker Preview" src="https://user-images.githubusercontent.com/60363270/215256897-bb78172d-703b-4eba-8e99-8de36f323202.png">
</p>

![Swift CI badge](https://github.com/htmlprogrammist/EmojiPicker/actions/workflows/swift.yml/badge.svg)

## Navigation

- [Installation](#installation)
    - [Swift Package Manager](#swift-package-manager)
    - [CocoaPods](#cocoapods)
    - [Manually](#manually)
- [Quick Start](#quick-start)
- [Usage](#usage)
    - [Delegate](#delegate)
    - [Source view](#source-view)
    - [Selected emoji category tint color](#selected-emoji-category-tint-color)
    - [Arrow direction](#arrow-direction)
    - [Horizontal inset](#horizontal-inset)
    - [Is dismissed after choosing](#is-dismissed-after-choosing)
    - [Custom height](#custom-height)
    - [Feedback generator style](#feedback-generator-style)
- [Localization](#localization)
- [Contributing](#contributing)
- [Experiments](#experiments)

## Installation

Ready for use with Swift 4.2+ on iOS 11.1+

### Swift Package Manager

The [Swift Package Manager](https://www.swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler. It’s integrated with the Swift build system to automate the process of downloading, compiling, and linking dependencies.

In Xcode navigate to File → Swift Packages → Add Package Dependency. Use this URL to add the dependency:

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

### Is dismissed after choosing

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

## Experiments

To play around with the project, contribute to it, see how it works or adapt it for yourself:

1. Clone or fork this repository to yourself
2. Open `Example App/EmojiPicker.xcworkspace` file
3. Expand `Pods` target
4. Expand `Development Pods` and `EmojiPicker` directories. Here you can make your changes
5. Build & Run project to see an immediate result on an example application. Have fun!

## Localization

* Chinese 🇨🇳
* English 🇬🇧
* French 🇫🇷
* German 🇩🇪
* Hindi 🇮🇳
* Russian 🇷🇺
* Turkish 🇹🇷
* Ukrainian 🇺🇦

You can also contribute your language to this list. Please, read [following heading](#contributing) for more information.

> ❗️ Note that the languages are arranged in alphabetical order

## Contributing

This project is based on [MCEmojiPicker](https://github.com/izyumkin/MCEmojiPicker) and is one big contribution in it. And of course contributions are welcomed and encouraged here! Please see the [Contributing guide](https://github.com/htmlprogrammist/EmojiPicker/blob/main/CONTRIBUTING.md).

To be a truly great community, we need to welcome developers from all walks of life, with different backgrounds, and with a wide range of experience. A diverse and friendly community will have more great ideas, more unique perspectives, and produce more great code. We will work diligently to make our community welcoming to everyone.

To give clarity of what is expected of our members, we have adopted the code of conduct defined by the Contributor Covenant. This document is used across many open source communities, and we think it articulates our values well. For more, see the [Code of Conduct](https://github.com/htmlprogrammist/EmojiPicker/blob/main/CODE_OF_CONDUCT.md).
