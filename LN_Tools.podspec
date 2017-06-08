Pod::Spec.new do |s|
  s.name     = 'LN_Tools'
  s.version  = '1.0.0'
  s.ios.deployment_target = '8.0'
  s.license  =  'MIT'
  s.summary  = 'A tools is good for develop on iOS'
  s.homepage = 'https://github.com/LionNeo/LN_Tools.git'
  s.authors   = { 'Lion_Neo' => '123624331@qq.com'}
  s.source   = { :git => 'https://github.com/LionNeo/LN_Tools.git', :tag => s.version.to_s }
  s.description = 'LN_Tools is a tools about develop on iOS'

  s.source_files = 'LN_Tools/*.{h,m}'
  s.framework    = 'CoreLocation'
  s.resources    = 'LN_Tools/LN_Tools.bundle'
  s.requires_arc = true
end
