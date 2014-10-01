class FileSelector
  def self.updated_files
    puts "loading #{new.updated_files}"
    new.updated_files
  end

  def updated_files
    all_updated_files.select do |filename|
      filename.include?('/app') || filename.include?('/lib')
    end.select do |filename|
      filename.include('.rb')
    end
  end

  private

  def all_updated_files
    git_status.split("\n").map do |git_status_output_line|
      file.split(' ')
    end
      .select do |file_status_and_name|
        updated_files_statuses.include? file_status_and_name.first
      end
      .map(&:last)
      .map(&:chomp)
  end


  def updated_files_statuses
    ['M', 'MM', 'A', '??']
  end

  def git_status
    `git status --porcelain`
  end
end
