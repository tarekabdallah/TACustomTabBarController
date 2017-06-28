#
# Be sure to run `pod lib lint TACustomTabBarController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TACustomTabBarController'
  s.version          = '0.1.2'

  s.summary          = 'TACustomTabBarController is a tabBar controller ability to control the design (item background color, text position, text font ...).'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TACustomTabBarController is a tabBar controller ability to control the design (item background color, text position, text font ...). It gives the developer an easy way to design his app with minimal restriction

DESC

  s.homepage         = 'https://github.com/tarekabdallah/TACustomTabBarController'
  s.license          = { :type => 'Apache License 2.0', :file => 'LICENSE' }
  s.author           = { 'Tarek' => 'tarekabd1995@gmail.com' }
  s.source           = { :git => 'https://github.com/tarekabdallah/TACustomTabBarController.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = 'TACustomTabBarController/Classes/**/*'
  
  # s.resource_bundles = {
  #   'TACustomTabBarController' => ['TACustomTabBarController/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
