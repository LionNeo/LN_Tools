Pod::Spec.new do |s|
  s.name         = "LN_Tools"
  s.version      = "1.0.0"
  s.summary      = "Good"
  s.homepage     = "https://github.com/LionNeo/LN_Tools.git"
  s.license      = 'MIT'
  s.author       = { "LionNeo" => "123624331@qq.com" }
  s.source       = { :git => "https://github.com/LionNeo/LN_Tools.git", :tag => s.version,:commit =>"fb088b567896d0927cbd7bba05688dc1dd3ca963" }
  s.ios.deployment_target = '8.0'
  s.source_files = "LN_Tools/*.{h,m}"
  s.requires_arc = true
  s.description = "Good"
end