require "readline"
require_relative "spec_runner"

class RspecPreloader
  class CommandLine
    def self.run(rspec_arguments = [''])
      new(rspec_arguments).run
    end

    def initialize(rspec_arguments)
      @rspec_arguments = rspec_arguments
    end

    def run
      first_run
      command_line_loop
    end

    private

    def first_run
      return if @rspec_arguments == ""
      Readline::HISTORY << @rspec_arguments.join(" ")
      SpecRunner.run_rspec(@rspec_arguments)
    end

    def command_line_loop
      loop do
        rspec_arguments = Readline.readline("rspec > ", true)
        break if [nil, "exit"].include?(rspec_arguments)
        rspec_arguments_array = rspec_arguments.chomp.split(" ")
        SpecRunner.run_rspec(rspec_arguments_array)
      end
    end

  end
end
