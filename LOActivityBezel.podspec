Pod::Spec.new do |s|
  s.name             = "LOActivityBezel"
  s.version          = "0.1.0"
  s.summary          = "A simple modal bezel showing activity."
  s.description      = <<-DESC
                       LOActivityBezel - A simple modal bezel showing an activity indicator with optional message.
                       DESC
  s.homepage         = "https://github.com/linkomnia/LOActivityBezel"
  s.license          = 'MIT'
  s.author           = { "Roger So" => "rogerso@linkomnia.com" }
  s.source           = { :git => "https://github.com/linkomnia/LOActivityBezel.git", :tag => s.version.to_s }

  s.platform     = :ios, '5.0'
  s.ios.deployment_target = '5.0'
  s.requires_arc = true

  s.source_files = 'LOActivityBezel'

  s.public_header_files = 'LOActivityBezel/*.h'
end
