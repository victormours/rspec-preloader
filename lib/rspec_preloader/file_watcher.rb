require "git"

class FileWatcher
  def self.changed_files
    new.changed_files
  end

  def changed_files
    git.status.changed.keys.select do |filename|
      /.rb$/.match(filename)
    end.reject do |filename|
      /spec\//.match(filename)
    end
  end

  private

  def git
    @git ||= Git.open(Dir.pwd)
  end
end
