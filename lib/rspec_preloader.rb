require "rspec/core"

class RspecPreloader

  def self.run_server(rspec_arguments = "")
    new(rspec_arguments).run_server
  end

  def initialize(rspec_arguments)
    # @rspec_arguments = rspec_arguments
    @rspec_arguments = "spec/some_class_spec.rb"
  end

  def run_server
    initial_prompt
    first_run

    # run_loop

  end

  private

  def initial_prompt
    puts "Hello"
  end

  def first_run
    require "#{Dir.pwd}/spec/spec_helper"
    RSpec::Core::Runner.run([@rspec_arguments], STDERR, STDOUT)
  end

  def run_loop
    WORKER_COUNT.times do
      start_worker
    end
    loop do
      wait_for_available_worker
      prompt
      @rspec_arguments = STDIN.gets.strip.split(" ")
      write_arguements_to_interprocess_communication_file
      trigger_worker #with a semaphore or mutex
    end
  end

  def start_worker
    fork do
      require File.expand_path("spec/spec_helper", __dir__)
      mark_as_available_for_work
      wait_for_worker_start_order
      mark_as_unavailable_for_work
      load_changed_files #with git status
      find_rspec_arguments_from_interprocess_communication_file
      RSpec::Core::Runner.run([@rspec_arguments], STDERR, STDOUT)
    end
  end
end
