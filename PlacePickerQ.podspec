

Pod::Spec.new do |spec|



  spec.name         = "PlacePickerQ"
  spec.version      = "1.0.3"
  spec.summary      = " PlacePickerQ to pick address from Google maps directly."


#spec.description  = <<-DESC
#DESC

  spec.homepage     = "https://github.com/AnupSukumaran/PlacePickerR.git"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author             = { "Anup Sukumaran" => "anup.sukumaran9@gmail.com" }

  spec.platform     = :ios
  spec.ios.deployment_target = "12.4"

  spec.source       = { :git => "https://github.com/AnupSukumaran/PlacePickerR.git", :tag => "1.0.3" }

  spec.source_files  = "PlacePickerQ", "PlacePickerQ/**/*.{swift}"

  # spec.resource  = "icon.png"
  # spec.resources = "PlacePickerQ/*.png"

  spec.resources = "PlacePickerQ/**/*.{png,storyboard,xcassets}"

  spec.framework  = "UIKit"
  spec.requires_arc = true

  spec.dependency "Alamofire", "~> 4.8.2"
  spec.dependency "GooglePlaces", "~> 3.1.0"
  spec.dependency "GoogleMaps", "~> 3.1.0"
  spec.dependency "SDWebImage/WebP", "~> 4.4.7"
  spec.dependency "NVActivityIndicatorView/AppExtension", "~> 4.7.0"
  spec.static_framework = true
  spec.swift_version = '5.0'

end
