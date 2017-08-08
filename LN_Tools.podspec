Pod::Spec.new do |s|
  s.name     = 'LN_Tools'
  s.version  = '3.0.0'
  s.ios.deployment_target = '8.0'
  s.license  =  'MIT'
  s.summary  = 'A tools is good for develop on iOS'
  s.homepage = 'https://github.com/LionNeo/LN_Tools.git'
  s.authors   = { 'Lion_Neo' => '123624331@qq.com'}
  s.source   = { :git => 'https://github.com/LionNeo/LN_Tools.git', :tag => s.version.to_s }
  s.description = 'LN_Tools is a tools about develop on iOS'

  s.source_files = 'LN_Tools/LN_Tools.h'
  s.public_header_files = 'LN_Tools/LN_Tools.h'

  s.frameworks = 'UIKit', 'CoreText', 'CoreGraphics', 'QuartzCore'
  
  # s.ios.vendored_frameworks = 'LN_Framework/*.{framework}'
  s.requires_arc = true

  s.subspec 'Store' do |root|
      root.source_files = 'LN_Tools/Store/**/*.{h,m}'
      root.public_header_files = 'LN_Tools/**/*.{h}'
  end
   s.subspec 'Vender' do |root|
      root.source_files = 'LN_Tools/Vender/**/*.{h,m}'
      root.public_header_files = 'LN_Tools/vendor/**/*.{h}'
  end
   s.subspec 'Category' do |root|
      root.source_files = 'LN_Tools/Category/**/*.{h,m}'
      root.public_header_files = 'LN_Tools/Category/**/*.{h}'
      root.dependency 'LN_Tools/LN_Framework'
  end
   s.subspec 'Color' do |root|
      root.source_files = 'LN_Tools/Color/**/*.{h,m}'
  end
  s.subspec 'LN_Framework' do |f|
      f.ios.vendored_frameworks = 'LN_Tools/Framework/*.{framework}'
  end
 s.subspec 'Location' do |root|
      root.source_files = 'LN_Tools/Location/**/*.{h,m}'
      root.public_header_files = 'LN_Tools/Location/**/*.{h}'
      root.frameworks = 'CoreLocation'
  end

end
