Pod::Spec.new do |s|
  s.name             = 'PureMVC'
  s.version          = '1.0.0'
  s.summary          = 'PureMVC MultiCore Framework for Objective-C.'
  s.homepage         = 'https://puremvc.org'
  s.license          = { :type => 'BSD-3-Clause', :file => 'LICENSE' }
  s.author           = { 'Saad Shams' => 'saad.shams@puremvc.org' }
  
  # Where the code is hosted
  s.source           = { :git => 'https://github.com/PureMVC/puremvc-objectivec-multicore-framework.git', :tag => s.version.to_s }

  # Deployment targets
  s.ios.deployment_target = '12.0'

  # Objective-C specific paths
  s.source_files          = 'PureMVC/**/*.{h,m}', 'include/PureMVC/**/*.h'
  s.header_mappings_dir   = 'include/PureMVC'
  
  # If you use ARC
  s.requires_arc          = true
end
