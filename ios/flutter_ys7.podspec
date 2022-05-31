#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_ys7.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_ys7'
  s.version          = '0.2.7'
  s.summary          = 'A ios Flutter project.'
  s.description      = <<-DESC
A new Flutter project.
                       DESC
  s.homepage         = 'https://github.com/rxwen/flutter_ys7'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'czw' => 'admin@cxcaa.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'EZOpenSDK' ,'4.19.8'
  s.platform = :ios, '10.3'
  s.static_framework = true
  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
