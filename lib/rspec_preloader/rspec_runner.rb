class RspecPreloader::RspecRunner

  def self.run_rspec(rspec_arguments_array)
    new(rspec_arguments_array).run_rspec
  end

  def initialize(rspec_arguments_array)
    @rspec_arguments = rspec_arguments_array
  end

  def run_rspec
    pid = fork do
      load_changed_files
      run_specs(@rspec_arguments)
    end
    Process.wait(pid)
  end

  private

  def load_changed_files
    FileWatcher.changed_files.each do |file|
      load file
    end
  end

  def run_specs(arguments_array)
    RSpec::Core::Runner.run(arguments_array, STDERR, STDOUT)
  end

end
