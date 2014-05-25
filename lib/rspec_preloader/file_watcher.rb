require "git"

class FileWatcher
  def self.changed_files
    new.changed_files
  end

  def changed_files
    git.status.changed.keys
  end

  private

  def git
    @git ||= Git.open(Dir.pwd)
  end
end
