#
# Be sure to run `pod lib lint ABSegmentControl.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ABSegmentControl'
  s.version          = '0.1.0'
  s.summary          = 'yet another segment controller'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = ' longer description about yet another segment controller'

  s.homepage         = 'https://github.com/alexander.bollbach@gmail.com/ABSegmentControl'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'alexander.bollbach@gmail.com' => 'alexander.bollbach@gmail.com' }
  s.source           = { :git => 'https://github.com/alexander.bollbach@gmail.com/ABSegmentControl.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'ABSegmentControl/Classes/**/*'
  
  # s.resource_bundles = {
  #   'ABSegmentControl' => ['ABSegmentControl/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
