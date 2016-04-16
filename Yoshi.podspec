#
# Be sure to run `pod lib lint Yoshi.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "Yoshi"
  s.version          = "0.1.0"
  s.summary          = "In app debug panel for iOS"

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!
  s.description      = <<-DESC
In app debug panel for iOS
                       DESC

  s.homepage         = "https://github.com/prolificinteractive/Yoshi"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { "Michael Campbell" => "Michael@prolificinteractive.com" }
  s.source           = { :git => "https://github.com/prolificinteractive/Yoshi.git", :tag => s.version.to_s }

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Sources/Yoshi/**/*.{h,swift}'
  s.resources = 'Sources/**/*.{png,jpeg,jpg,storyboard,xib}'

end
