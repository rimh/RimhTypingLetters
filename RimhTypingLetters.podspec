#
# Be sure to run `pod lib lint RimhTypingLetters.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RimhTypingLetters'
  s.version          = '0.1.1'
  s.summary          = 'A simple typing animation for UITextView and UILabel.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'A simple typing animation for UITextView and UILabel. It is simple use with small codes.'

  s.homepage         = 'https://github.com/rimh/RimhTypingLetters'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Rimh(Ming)' => 'rimh@github' }
  s.source           = { :git => 'https://github.com/rimh/RimhTypingLetters.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'RimhTypingLetters/Classes/**/*'
end
