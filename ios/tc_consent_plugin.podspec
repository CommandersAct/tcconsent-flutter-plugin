#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint tc_consent_plugin.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'tc_consent_plugin'
  s.version          = '1.4.0'
  s.summary          = 'CommandersAct\'s TCConsent Plugin'
  s.description      = <<-DESC
A new Flutter plugin project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'CommandersAct' => 'mobile@commandersact.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.platform = :ios, '11.0'
  s.dependency 'IOSV5-TCCore', '5.3.4'
  s.dependency 'TCConsent_IAB', '5.2.1'
  s.dependency 'TCIAB', '5.0.2'
  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
end
