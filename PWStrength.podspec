Pod::Spec.new do |s|
  s.name     = 'PWStrength'
  s.version  = '0.0.1'
  s.summary  = 'A simple validator for checking password strength'
  s.homepage = 'https://github.com/laiso/PWStrength'
  s.license  = 'MIT'
  s.author   = { 'laiso' => 'laiso@lai.so' }
  s.source   = { :git => 'https://github.com/laiso/PWStrength.git', :tag => "v#{s.version}" }
  s.source_files = 'PWStrength/*.{h,m}'
end
