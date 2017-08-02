Pod::Spec.new do |s|
  s.name     = 'LN_Tools'
  s.version  = '1.0.6'
  s.ios.deployment_target = '8.0'
  s.license  =  'MIT'
  s.summary  = 'A tools is good for develop on iOS'
  s.homepage = 'https://github.com/LionNeo/LN_Tools.git'
  s.authors   = { 'Lion_Neo' => '123624331@qq.com'}
  s.source   = { :git => 'https://github.com/LionNeo/LN_Tools.git', :tag => s.version.to_s }
  s.description = 'LN_Tools is a tools about develop on iOS'

  s.source_files = 'LN_Tools/**/*.{h,m}'
  s.public_header_files = 'LN_Tools/**/*.{h}'
  s.frameworks = 'UIKit', 'CoreText', 'CoreGraphics', 'QuartzCore','CoreLocation'
  s.dependency 'YYKit', '~> 1.0.9'
  s.ios.vendored_frameworks = 'LN_Framework/*.{framework}'
  s.requires_arc = true
end
