require_relative "spec_helper"
require "minitest/autorun"

class TestRspecPreloader < Minitest::Test

  def source_filename
    File.expand_path("fake_project/app/some_class.rb", __dir__)
  end

  def setup
    File.open(source_filename, 'w') do |file|
      file.puts "puts 'Loading source file'"
    end
  end

  def teardown
    File.delete(source_filename)
  end

  def preloader_output
    `cd #{File.dirname(__FILE__)}/fake_project; ruby ../../bin/rspec-preloader.rb`.split("\n")
  end

  def test_that_output_has_server_status
    assert_equal preloader_output[0], "Hello"
  end

  def test_spec_helper_gets_loaded
    assert_equal "Loading spec helper", preloader_output[1]
  end

  def test_changed_source_file_is_loaded
    assert_equal "Loading source file", preloader_output[2]
  end

  def test_specs_are_run
    assert_equal  "Running specs", preloader_output[3]
  end
end
