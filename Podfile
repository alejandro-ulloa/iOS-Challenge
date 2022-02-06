# Uncomment the next line to define a global platform for your project
 platform :ios, '15.2'

# ignore all warnings from all pods
inhibit_all_warnings!

target 'iOS-Challenge' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'RxDataSources'
  pod 'Action'
  pod 'Moya/RxSwift'
  pod 'XCoordinator/RxSwift'
  pod 'Swinject'
  pod 'SnapKit'
  pod 'RxGesture'
  pod 'Kingfisher'
  # Pods for iOS-Challenge

  target 'iOS-ChallengeTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'iOS-ChallengeUITests' do
    # Pods for testing
  end

end

post_install do |installer_representation|
  installer_representation.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['CLANG_ENABLE_CODE_COVERAGE'] = 'NO'
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.2'
    end
  end
end
