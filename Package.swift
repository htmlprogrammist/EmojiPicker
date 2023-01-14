// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "EmojiPicker",
    defaultLocalization: "en",
    platforms: [.iOS("11.1")],
    products: [
        .library(
            name: "EmojiPicker",
            targets: ["EmojiPicker"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "EmojiPicker",
            resources: [
                .process("Resources")
            ]
        ),
        .testTarget(
            name: "EmojiPickerTests",
            dependencies: ["EmojiPicker"]
        )
    ],
    swiftLanguageVersions: [.v4_2, .v5]
)
