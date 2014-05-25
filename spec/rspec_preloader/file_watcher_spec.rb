require_relative "spec_helper"
require "minitest/autorun"

class TestFileWatcher < Minitest::Test

  def test_that_it_returns_changed_files
    assert_equal FileWatcher.changed_files, "app/some_class.rb"
  end
end
