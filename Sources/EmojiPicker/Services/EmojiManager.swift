// The MIT License (MIT)
//
// Copyright © 2023 Egor Badmaev
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

import Foundation

/// An abstraction over entity that provides emoji set.
protocol EmojiManagerProtocol {
    /// Provides a set of emojis.
    ///
    /// - Returns: Set of emojis.
    func provideEmojis() -> EmojiSet
}

/// The class is responsible for getting a relevant set of emojis for iOS version.
final class EmojiManager: EmojiManagerProtocol {
    
    // MARK: - Private Properties
    
    /// An object that decodes instances of a data type from JSON objects.
    private let decoder = JSONDecoder()
    
    /// Version of emoji set.
    ///
    /// - Note: The value is `5` by default.
    private var emojiVersion: String {
        switch deviceVersion {
        case 12.1...13.1:
            return "11"
            
        case 13.2...14.1:
            return "12.1"
            
        case 14.2...14.4:
            return "13"
            
        case 14.5...15.3:
            return "13.1"
            
        case 15.4...:
            return "14"
            
        default:
            return "5"
        }
    }
    
    /// Version of operating system of a device.
    ///
    /// It takes major and minor version of a device and returns it as `15.5`.
    private var deviceVersion: Double {
        let version: OperatingSystemVersion = ProcessInfo().operatingSystemVersion
        return Double(version.majorVersion) + Double(version.minorVersion) / 10
    }
    
    // MARK: - Internal Methods
    
    func provideEmojis() -> EmojiSet {
        guard let path = Bundle.module.path(forResource: emojiVersion, ofType: "json"),
              let data = try? Data(contentsOf: URL(fileURLWithPath: path))
        else {
            fatalError("Could not get data from \"\(emojiVersion).json\" file")
        }
        
        guard let emojiSet = try? decoder.decode(EmojiSet.self, from: data) else {
            fatalError("Could not get emoji set from data: \(data)")
        }
        
        return emojiSet
    }
}
