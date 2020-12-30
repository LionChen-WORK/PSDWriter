Pod::Spec.new do |s|
  s.name             = 'PSDWriter'
  s.version          = '0.0.1'
  s.summary          = 'Write PSD files.'
  s.description      = 'A writer to create Adobe Photoshop PSD files.'

  s.homepage         = 'https://github.com/LionChen-WORK/PSDWriter'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = 'Lion Chen'
  s.source           = { :git => 'https://github.com/LionChen-WORK/PSDWriter.git', :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'
  s.requires_arc = false

  s.source_files = 'PSDWriter/*'
  s.public_header_files = 'PSDWriter/PSDWriter.h', 'PSDWriter/PSDLayer.h'

  s.frameworks = 'Foundation', 'UIKit'
end
