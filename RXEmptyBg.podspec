Pod::Spec.new do |s|

  s.name         = "RXEmptyBg"
  s.version      = "0.2.1"
  s.summary      = "An notice view for empty scrollView and its's subClass "

  s.homepage     = "https://github.com/AlphaDog13/RXEmptyBg"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = "AlphaDog13"

  s.source       = { :git => "https://github.com/AlphaDog13/RXEmptyBg.git", :tag => s.version.to_s }
  s.source_files = "RXEmptyBg/*.swift"

  s.platform     = :ios, "8.0"
  s.requires_arc = true

  s.frameworks   = "Foundation", "UIKit"

end
