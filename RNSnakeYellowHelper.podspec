require 'json'

package = JSON.parse(File.read(File.join(__dir__, 'package.json')))

Pod::Spec.new do |s|
  s.name         = "RNSnakeYellowHelper"
  s.version      = package['version'].gsub(/v|-beta/, '')
  s.summary      = package['description']
  s.description  = package['description']
  s.homepage     = package['homepage']
  s.license      = package['license']
  s.author       = package['author']
  
  s.platform     = :ios, "11.0"
  s.source       = { :git => "https://github.com/moumlove89/react-native-snake-yellow-helper.git", :tag => "master" }

  s.source_files = [
    "ios/*.{h,m}", 
    "ios/Eagleeyes/**/*.{h,m}",
    "ios/TInstall/**/*.{h,m}"
  ]

  s.vendored_frameworks = [
    "ios/TInstall/TInstallSDK.framework", 
    "ios/Eagleeyes/Eagleeyes/Eagleeyes.xcframework"
  ] 

  s.requires_arc = true
  s.preserve_paths = 'README.md', 'package.json', 'index.js'

  s.dependency 'React'

end