#
# Be sure to run `pod lib lint AutoCompleteAccessoryView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AutoCompleteAccessoryView'
  s.version          = '0.1.2'
  s.summary          = 'AutoCompleteAccessoryView and PlaceHolderAccessoryView are a keyboard accessory views.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC

  AutoCompleteAccessoryView is an keyboard accessory view with autocomplete. You can use any [String] to search for with feed back on selection and completion.

  PlaceHolderAccessoryView is an keyboard accessory view with Place Holder Text.
                       DESC

  s.homepage         = 'https://github.com/MatthewMerritt/AutoCompleteAccessoryView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'MatthewMerritt' => 'matthew.merritt@yahoo.com' }
  s.source           = { :git => 'https://github.com/MatthewMerritt/AutoCompleteAccessoryView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '13.0'

  s.source_files = 'AutoCompleteAccessoryView/Classes/**/*'
  
  # s.resource_bundles = {
  #   'AutoCompleteAccessoryView' => ['AutoCompleteAccessoryView/Assets/*.png']
  # }

  s.ios.frameworks = 'UIKit', 'Foundation'

  s.swift_versions = ['5.0', '5.1']

  s.dependency 'EasyClosure'
end
