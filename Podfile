# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'MapApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

	pod 'GoogleMaps'

  # Pods for MapApp

end

post_install do |pi|
   pi.pods_project.targets.each do |t|
       t.build_configurations.each do |bc|
          bc.build_settings['ARCHS[sdk=iphonesimulator*]'] =  `uname -m`
       end
   end
end