Gem::Specification.new do |gem|
  gem.name        = 'rspec-preloader'
  gem.version     = '0.0.1'
  gem.licenses    = ['MIT']
  gem.summary     = "A faster way to run your specs."
  gem.description = "A preloader for your spec helper for faster TDD"
  gem.authors     = ["Victor Mours"]
  gem.email       = 'victor.mours@gmail.com'
  gem.files       = ["lib/rspec_preloader.rb"]
  gem.executables = ["rspec-preloader"]
  gem.homepage    = 'https://github.com/victormours/rspec-preloader'

  gem.add_runtime_dependency "rspec"
  gem.add_runtime_dependency "git"

  gem.add_development_dependency "minitest"
end
