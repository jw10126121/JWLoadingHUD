#
# Be sure to run `pod lib lint JWProgressHUD.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'JWProgressHUD'
    s.version          = '0.0.1'
    s.summary          = 'JWProgressHUD.指示器'
    s.homepage         = 'https://github.com/jw10126121/JWProgressHUD'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'jw10126121' => '10126121@qq.com' }
    s.source           = { :git => 'https://github.com/jw10126121/JWProgressHUD.git', :tag => s.version.to_s }
    s.ios.deployment_target = '9.0'
    
    #s.framework    = 'QuartzCore'
    s.source_files = 'JWProgressHUD/Classes/**/*'
    #s.resource_bundles = {
    #    'JWProgressHUD' => ['JWProgressHUD/Assets/*.png']
    #}
    s.resources    = 'JWProgressHUD/JWProgressHUD.bundle'
    s.swift_versions = ['4.2', '5.0'] # 同时支持4.2和5.0
    s.dependency 'MBProgressHUD', '~> 1.1.0'
    
    
end
