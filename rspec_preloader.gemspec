Gem::Specification.new do |gem|
  gem.name        = 'rspec-preloader'
  gem.version     = '0.0.3'
  gem.licenses    = ['MIT']
  gem.summary     = "A git backed preloader for rspec"
  gem.description = "Life is too short to be waiting for your tests to load."
  gem.authors     = ["Victor Mours"]
  gem.email       = 'victor.mours@gmail.com'
  gem.files       = Dir["lib/**/*.rb"]
  gem.executables = ["rspec-preloader"]
  gem.homepage    = 'https://github.com/victormours/rspec-preloader'

  gem.add_runtime_dependency "rspec", "~> 0"
  gem.add_runtime_dependency "git", "~> 0"

  gem.add_development_dependency "minitest", "~> 0"
  gem.add_development_dependency "pry", "~> 0"
end
