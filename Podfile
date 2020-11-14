# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Countdown' do
  # Comment the next line if you don't want to use dynamic frameworks
pod 'Charts', '~> 3.0'
  use_frameworks!


 # Pods for Countdown
  pod 'Charts'

pod 'Charts', '~> 3.0.1'

pod 'Countdown', '~> 2.0.2'

post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['SWIFT_VERSION'] = '3.0'
      end
    end
  end
end