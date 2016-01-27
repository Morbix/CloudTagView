#
# Be sure to run `pod lib lint CloudTagView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "CloudTagView"
  s.version          = "1.0.0"
  s.summary          = "A custom view to create cloud of tags."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = <<-DESC
This class helps you to create a simple cloud of tags based on Strings. You can manipulate the text, the padding and you can use the tintColor to modify the tag color. There are two delegates to handle taps in the tag: close icon and tag touch. You can access the example project for more details or contacting me.
                       DESC

  s.homepage         = "https://github.com/Morbix/CloudTagView"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Henrique Morbin" => "morbin_@hotmail.com" }
  s.source           = { :git => "https://github.com/Morbix/CloudTagView.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/Morbin_'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.resources = 'Pod/Assets/Media.xcassets'
  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'CloudTagView' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
