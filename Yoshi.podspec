#
# Be sure to run `pod lib lint Yoshi.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "Yoshi"
  s.version          = "1.0.0"
  s.summary          = "In app debug panel for iOS"

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!
  s.description      = <<-DESC
		       A helpful companion for your iOS app.

		       Yoshi is a convenient wrapper around the UI code that is often needed for displaying debug menus. Out of the box, Yoshi provides easy-to-implement date, list and custom menus.
                       DESC

  s.homepage         = "https://github.com/prolificinteractive/Yoshi"
  s.screenshots     = "https://github.com/prolificinteractive/Yoshi/blob/9405ea600838b9ce851400427e5195ac510d1d27/Yoshi.gif", "https://github.com/prolificinteractive/Yoshi/blob/60dd636bf295d9ab04576fcc9b63d4da288ac3ac/Yoshi_iPad.gif"
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { "Michael Campbell" => "Michael@prolificinteractive.com" }
  s.source           = { :git => "https://github.com/prolificinteractive/Yoshi.git", :tag => s.version.to_s }

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Yoshi/Yoshi/**/*.{swift}'
  s.resources = 'Yoshi/**/*.{png,jpeg,jpg,storyboard,xib}'

end
