class FileSelector
  def self.updated_source_files
    puts "loading #{new.updated_source_files}"
    new.updated_source_files
  end

  def updated_source_files
    all_updated_files.select do |filename|
      filename.include?('/app') || filename.include?('/lib')
    end.select do |filename|
      filename.include('.rb')
    end
  end

  private

  def all_updated_files
    file_statuses_and_names.select do |file_status_and_name|
        updated_files_statuses.include? file_status_and_name.first
    end
    .map(&:last)
    .map(&:chomp)
  end

  def file_statuses_and_names
    git_status.split("\n").map do |git_status_output_line|
      git_status_output_line.split(' ')
    end
  end

  def updated_files_statuses
    ['M', 'MM', 'A', '??']
  end

  def git_status
    `git status --porcelain`
  end
end
