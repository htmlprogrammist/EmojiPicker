Pod::Spec.new do |s|
  s.name = 'EmojiPicker'
  s.version = '3.0.9'
  s.license = 'MIT'
  s.summary = 'Emoji picker for iOS like on MacOS'
  s.homepage = 'https://github.com/htmlprogrammist/EmojiPicker'
  s.authors = { 'Egor Badmaev' => 'eg.badmaev@gmail.com' }
  
  s.source = { :git => 'https://github.com/htmlprogrammist/EmojiPicker.git', :tag => s.version.to_s }
  s.source_files = 'Sources/EmojiPicker/**/*.{swift}'
  s.resource_bundle = { "Resources" => ["Sources/EmojiPicker/**/*.{json,strings}"] }
  
  s.test_spec 'Tests' do |test_spec|
    test_spec.source_files = 'Tests/EmojiPickerTests/**/*.{swift}'
  end
  
  s.swift_version = '4.2'
  s.platform = :ios, '11.1'
end
