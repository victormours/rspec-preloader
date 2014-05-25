require "rspec/core"
require "rspec_preloader/file_watcher"

class RspecPreloader

  def self.run_server(rspec_arguments = "")
    new(rspec_arguments).run_server
  end

  def initialize(rspec_arguments)
    @rspec_arguments = "spec/some_class_spec.rb"
  end

  def run_server
    initial_prompt
    first_run
  end

  private

  def initial_prompt
    puts "Hello"
  end

  def first_run
    require "#{Dir.pwd}/spec/spec_helper"
    load FileWatcher.changed_files
    RSpec::Core::Runner.run([@rspec_arguments], STDERR, STDOUT)
  end

end
