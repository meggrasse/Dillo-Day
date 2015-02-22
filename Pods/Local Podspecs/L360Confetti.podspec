Pod::Spec.new do |s|
  s.name         = "L360Confetti"
  s.version      = "1.1.1"
  s.summary      = "Delight your users with some confetti in your app!!"

  s.description  = <<-DESC
                   Wouldn't you like to delign your users with some confetti in your app?
                   Here at Life360 we believe that part of being a close family is to enjoy moments together.
                   Confetti is a playful celebration of good times that the family can enjoy together.
                   DESC

  s.homepage     = "http://github.com/life360/confetti"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"


  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  # s.license      = "Apache License, Version 2.0"
  s.license      = { :type => "Apache License, Version 2.0", :file => "iOS/LICENSE.md" }


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.author             = { "Mohammed Islam" => "mohammed@life360.com" }
  # Or just: s.author    = "Mohammed Islam"
  # s.authors            = { "Mohammed Islam" => "mohammed@life360.com" }
  # s.social_media_url   = "http://twitter.com/Mohammed Islam"

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  # s.platform     = :ios
  s.platform     = :ios, "7.0"

  #  When using multiple platforms
  s.ios.deployment_target = "7.0"
  # s.osx.deployment_target = "10.7"


  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.source       = { :git => "https://github.com/life360/confetti.git", :tag => "1.1.1" }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

 # s.source_files  = "L360Confetti", "L360Confetti/*.{h,m}"
  s.source_files  = "iOS/L360Confetti"
  #s.exclude_files = "Classes/Exclude"

  # s.public_header_files = "Classes/**/*.h"


  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"

  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.framework  = "UIKit"
  # s.frameworks = "SomeFramework", "AnotherFramework"

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"
end
