Pod::Spec.new do |s|
  s.name         = 'Dillo Day'
  s.version      = '<#Project Version#>'
  s.license      =  :type => '<#License#>'
  s.homepage     = '<#Homepage URL#>'
  s.authors      =  '<#Author Name#>' => '<#Author Email#>'
  s.summary      = '<#Summary (Up to 140 characters#>'

# Source Info
  s.platform     =  :ios, '<#iOS Platform#>'
  s.source       =  :git => '<#Github Repo URL#>', :tag => '<#Tag name#>'
  s.source_files = '<#Resources#>'
  s.framework    =  '<#Required Frameworks#>'

  s.requires_arc = true
  
# Pod Dependencies
  s.dependencies =	pod 'BlocksKit'
  s.dependencies =	pod 'Masonry'
  s.dependencies =	pod 'Colours', '~> 5.6'
  s.dependencies =	pod "Mapbox-iOS-SDK"
  s.dependencies =	pod 'HTHorizontalSelectionList', '~> 0.3.1'
  s.dependencies =	pod 'HTKDynamicResizingCell', '~> 0.0.1'
  s.dependencies =	pod 'PureLayout'
  s.dependencies =	pod 'BOString', '~> 0.0'


end