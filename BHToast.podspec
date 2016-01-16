#
# Be sure to run `pod lib lint BHToast.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name          = "BHToast"
  s.version       = "0.2.0"
  s.summary       = "It's a custom UIView inspired in Android Toast."
  s.homepage      = "https://github.com/bbheck/BHToastSwift"
  s.license       = 'MIT'
  s.author        = { "Bruno Hecktheuer" => "bbheck@gmail.com" }
  s.source        = { :git => "https://github.com/bbheck/BHToastSwift.git", :tag => s.version.to_s }
  s.platform      = :ios, '8.0'
  s.requires_arc  = true
  s.source_files  = 'Pod/Classes/**/*'

end
