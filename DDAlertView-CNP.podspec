Pod::Spec.new do |s|
  s.name         = "DDAlertView-CNP"
  s.version      = "1.0.3"
  s.summary      = "easy alert"
  s.homepage     = "https://github.com/chenddcoder/DDAlertView"
  s.license      = "MIT"
  s.author             = { "chenddcoder" => "chenddcoder@foxmail.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/chenddcoder/DDAlertView.git", :tag => "1.0.3" }
  s.source_files  = "DDAlertView/DDAlertView/Classes/*.{h,m}"
  s.requires_arc = true
  s.dependency "CNPPopupController"
end
