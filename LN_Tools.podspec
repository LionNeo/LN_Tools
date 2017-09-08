Pod::Spec.new do |s|
  s.name     = 'LN_Tools'
  s.version  = '3.0.3'
  s.ios.deployment_target = '8.0'
  s.license  =  'MIT'
  s.summary  = 'some tools is good for develop on iOS'
  s.homepage = 'https://github.com/LionNeo/LN_Tools.git'
  s.authors   = { 'Lion_Neo' => '123624331@qq.com'}
  s.source   = { :git => 'https://github.com/LionNeo/LN_Tools.git', :tag => s.version.to_s }
  s.description = 'LN_Tools is a tools about develop on iOS'


   s.public_header_files = 'LN_Tools/LN_Tools.h'
   s.source_files = 'LN_Tools/LN_Tools.h'


  s.frameworks = 'UIKit', 'CoreText', 'CoreGraphics', 'QuartzCore'
  
  # s.ios.vendored_frameworks = 'LN_Framework/*.{framework}'
  s.requires_arc = true

  s.subspec 'Store' do |ss|
      ss.source_files = 'LN_Tools/Store/**/*.{h,m}'
      ss.public_header_files = 'LN_Tools/Store/**/*.{h}'
  end
   s.subspec 'Vender' do |vv|
      vv.source_files = 'LN_Tools/Vender/**/*.{h,m}'
      vv.public_header_files = 'LN_Tools/Vender/**/*.{h}'
  end
  s.subspec 'Helper' do |vv|
      vv.source_files = 'LN_Tools/Helper/**/*.{h,m}'
      vv.public_header_files = 'LN_Tools/Helper/**/*.{h}'
  end
   s.subspec 'Category' do |cc|
      cc.source_files = 'LN_Tools/Category/**/*.{h,m}'
      cc.public_header_files = 'LN_Tools/Category/**/*.{h}'
      cc.dependency 'LN_Tools/LN_Framework'
      cc.dependency 'YYKit', '~> 1.0.9'

  end
   s.subspec 'Color' do |color|
      color.source_files = 'LN_Tools/Color/**/*.{h,m}'
  end
  s.subspec 'LN_Framework' do |ff|
      ff.ios.vendored_frameworks = 'LN_Tools/Framework/*.{framework}'
  end
 s.subspec 'Location' do |ll|
      ll.source_files = 'LN_Tools/Location/**/*.{h,m}'
      ll.public_header_files = 'LN_Tools/Location/**/*.{h}'
      ll.frameworks = 'CoreLocation'
  end

end
