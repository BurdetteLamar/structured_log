require 'rake/testtask'
require 'markdown_helper'

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.libs << 'lib'
  t.test_files = FileList['test/**/*_test.rb']
end

namespace :build do

  desc 'Build README.md file from README.template.md'
  task :readme do
    readme_dir_path = File.join(
        File.dirname(__FILE__),
        'readme_files',
    )
    source_dir_path = File.join(
        readme_dir_path,
        'scripts',
    )
    target_dir_path = File.join(
        readme_dir_path,
        'logs',
    )
    source_file_paths = Dir.glob("#{source_dir_path}/*.rb")
    # Run the scripts in the logs directory,
    # because (e.g.) in array.rb, the :file_path
    # to the output log file is the simple 'array.xml',
    # which keeps the file more readable.
    chdir(target_dir_path) do
      source_file_paths.each do |source_file_path|
        command = "ruby #{source_file_path}"
        system(command)
      end
    end
    git_top_dir_path = `git rev-parse --show-toplevel`.chomp
    log_file_paths = Dir.glob("#{target_dir_path}/*.xml")
    log_file_paths.each do |log_file_path|
      text = File.read(log_file_path)
      text.gsub!(git_top_dir_path, "C:/#{File.basename(git_top_dir_path)}")
      File.write(log_file_path, text)
    end
    markdown_helper = MarkdownHelper.new
    # noinspection RubyResolve
    markdown_helper.include('readme_files/README.template.md', 'README.md')
  end

end

task :default => :test
