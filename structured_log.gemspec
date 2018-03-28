
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'structured_log/version'

Gem::Specification.new do |spec|
  spec.name          = 'structured_log'
  spec.version       = StructuredLog::VERSION
  spec.authors       = ['burdettelamar']
  spec.email         = ['BurdetteLamar@Yahoo.com']

  spec.summary       = 'Structured (not flat) log'
  spec.description   = 'Logging where nested sections (blocks) in code become nested XML elements in the log'
  spec.homepage      = 'https://github.com/BurdetteLamar/structured_log'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'diff-lcs', '~> 1.3'
  spec.add_development_dependency 'markdown_helper', '~> 0.1.5'
end
