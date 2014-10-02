class FileSelector
  def self.updated_source_files
    puts "loading #{new.updated_source_files}"
    new.updated_source_files
  end

  def updated_source_files
    all_updated_files.select do |filename|
      filename.include?('app/') || filename.include?('lib/')
    end.select do |filename|
      filename.end_with?('.rb')
    end
  end

  private

  def all_updated_files
    file_statuses_and_names.select do |file_status_and_name|
        updated_files_statuses.include? file_status_and_name.first
    end
    .map(&:last)
  end

  def updated_files_statuses
    ['M', 'MM', 'A', '??']
  end

  def file_statuses_and_names
    git_status_lines.map do |git_status_line|
      git_status_line.split(' ')
    end
  end

  def git_status_lines
    git_status.split("\n")
  end

  def git_status
    `git status --porcelain`
  end
end
