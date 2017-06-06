Pod::Spec.new do |s|

    // 设置名称
    s.name         = "LN_Tools"

    // 设置版本号
    s.version      = "1.0.0"

    // 设置详情
    s.description  = "Good"

    // 设置仓库主页
    s.homepage     = "https://github.com/LionNeo/LN_Tools.git"

    // 设置许可证
    s.license      = "MIT"

    // 设置作者
    s.author             = { "LionNeo" => "123624331@qq.com" }

    // 设置仓库源,表示在哪可以找到组件工程
    s.source       = { :git => "https://github.com/LionNeo/LN_Tools.git", :tag => "#{s.version}",:commit => "" }

    // 设置 源文件路径 => 不是整个工程的文件，而是自己封装的代码，以后别的工程引入，就会引入这里的代码。
    s.source_files  = "LN_Tools/**/*.{h,m}"

  end