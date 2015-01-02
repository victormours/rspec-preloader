require "rspec/core"
require_relative "file_selector"

class RspecPreloader
  class SpecRunner

    def self.run_rspec(rspec_arguments_array, std_err = STDERR, std_out = STDOUT)
      new(rspec_arguments_array, std_err, std_out).run_rspec
    end

    def initialize(rspec_arguments_array, std_err, std_out)
      @rspec_arguments = rspec_arguments_array
      @std_err = std_err
      @std_out = std_out
    end

    def run_rspec
      pid = fork do
        load_updated_files
        run_specs(@rspec_arguments)
      end
      Process.wait(pid)
    end

    private

    def load_updated_files
      FileSelector.updated_source_files.each do |file|
        load file
      end
    end

    def run_specs(arguments_array)
      RSpec::Core::Runner.run(arguments_array, @std_err, @std_out)
    end

  end
end
