package = JSON.parse(File.read(File.join(__dir__, '../package.json')))

Pod::Spec.new do |s|
  s.name           = "RNTextDetector"
  s.version        = package['version']
  s.summary        = package['summary']
  s.description    = package['description']
  s.license        = package['license']
  s.author         = package['author']
  s.homepage       = package['homepage']
  s.platform       = :ios, "9.0"
  s.source         = { :git => "https://github.com/fadyshawky/react-native-text-detector.git", :tag => "master" }
  s.source_files   = "*.{h,m}"
  s.requires_arc   = true


  s.dependency     "React"
end
