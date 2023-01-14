//
//  Bundle.swift
//  EmojiPicker
//
//  Created by Егор Бадмаев on 13.01.2023.
//

import Foundation

/// We don't want `Bundle.module` that is being generated automatically for Swift Package to be overriden by our property.
#if !SWIFT_PACKAGE
extension Bundle {
    /**
     Resources bundle.
     
     Since CocoaPods resources bundle is something other than SPM's `Bundle.module`, we need to create it.
     
     - Note: It was named same as for Swift Package to simplify usage.
     */
    static var module: Bundle {
        let path = Bundle(for: UnicodeManager.self).path(forResource: "EmojiPicker", ofType: "bundle") ?? ""
        return Bundle(path: path) ?? Bundle.main
    }
}
#endif
