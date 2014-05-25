task :default => :build

task :build do
  `gem build rspec_preloader.gemspec`
end

task :test do
  puts `bundle exec ruby spec/*_spec.rb`
end
