#
# Be sure to run `pod lib lint Yoshi.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "Yoshi"
  s.version          = "3.0.1"
  s.summary          = "A helpful companion for your iOS app."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!
  s.description      = <<-DESC
		       Yoshi is a convenient wrapper around the UI code that is often needed for displaying debug menus. Out of the box, Yoshi provides easy-to-implement date, list and custom menus.
                       DESC

  s.homepage         = "https://github.com/prolificinteractive/Yoshi"
  s.screenshots     = "https://raw.githubusercontent.com/prolificinteractive/Yoshi/a6e85e87cbd67f2bb3bfe60157e7b13281d80f20/Images/Yoshi.png", "https://raw.githubusercontent.com/prolificinteractive/Yoshi/c66cdf8dc2ab643fe57996d20d3cd37b8b70ceff/Images/Yoshi_iPad.png"
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { "Michael Campbell" => "Michael@prolificinteractive.com" , "Luna An" => "luna@prolificinteractive.com"}
  s.source           = { :git => "https://github.com/prolificinteractive/Yoshi.git", :tag => s.version.to_s }

  s.platform     = :ios, '9.0'
  s.requires_arc = true

  # Default subspec that contains all shared code files for the library
  # All subspecs must declare this as a dependency.
  s.subspec "Core" do |ss|
   ss.source_files = "Yoshi/Yoshi/**/*.{swift}"
   ss.resources = 'Yoshi/**/*.{png,jpeg,jpg,storyboard,xib}'
  end

  s.default_subspec = "Core"

  # Subspecs
  qakit     =   { :name => "QAKit" }

  all_specs = [qakit]
  all_specs.each do |spec|

    # Define a Cocoapods subspec
    s.subspec spec[:name] do |sp|
      sp.source_files = "Yoshi/#{spec[:name]}/**/*.swift"
      sp.dependency "Yoshi/Core"
    end
  end

end
