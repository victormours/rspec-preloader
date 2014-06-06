require "minitest/autorun"
require "minitest/spec"

require 'tempfile'

describe "rspec-preloader" do

  it "outputs the same thing as Rspec" do
    puts preloader_output
    puts rspec_output
    preloader_output.must_include(rspec_output)
  end

  def preloader_output
    preloader_output_file = Tempfile.new("prealoader")

    system [
      "cd #{fake_project_path}",
      "echo exit | ruby #{preloader_bin_path} spec > #{preloader_output_file.path}"
    ].join(";")

    preloader_output_file.readlines
  end

  def rspec_output
    rspec_output_file = Tempfile.new("rspec")

    system [
      "cd #{fake_project_path}",
      "rspec spec > #{rspec_output_file.path}"
    ].join(";")

    rspec_output_file.readlines
  end

  def cd_to_fake_project
    "cd #{fake_project_path}"
  end

  def fake_project_path
    File.expand_path("fake_project", __dir__)
  end

  def preloader_bin_path
    File.expand_path("../bin/rspec-preloader", __dir__)
  end
end


  # def source_filename
  #   File.expand_path("fake_project/app/some_class.rb", __dir__)
  # end
  #
  # def setup
  #   File.open(source_filename, 'w') do |file|
  #     file.puts "puts 'Loading source file'"
  #   end
  # end
  #
  # def teardown
  #   File.delete(source_filename)
  # end
  #
  # def preloader_output
  #   `cd #{File.dirname(__FILE__)}/fake_project; ruby ../../bin/rspec-preloader.rb`.split("\n")
  # end
  #
  # def test_that_output_has_server_status
  #   assert_equal preloader_output[0], "Hello"
  # end
  #
  # def test_spec_helper_gets_loaded
  #   assert_equal "Loading spec helper", preloader_output[1]
  # end
  #
  # def test_changed_source_file_is_loaded
  #   assert_equal "Loading source file", preloader_output[2]
  # end
  #
  # def test_specs_are_run
  #   assert_equal  "Running specs", preloader_output[3]
  # end
