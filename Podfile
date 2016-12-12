# Uncomment this line to define a global platform for your project
platform :ios, '9.0'

target 'MGTV-Swift' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  
  post_install do |installer|
      installer.pods_project.targets.each do |target|
          target.build_configurations.each do |config|
              config.build_settings['SWIFT_VERSION'] = '3.0'
          end
      end
  end

  # Pods for MGTV-Swift
pod 'Kingfisher', '~> 3.0'
pod 'AlamofireObjectMapper', '~> 4.0'
pod 'SnapKit', '~> 3.0.2'
pod 'CCAutoScrollView', '~>2.0.5'

  target 'MGTV-SwiftTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'MGTV-SwiftUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
