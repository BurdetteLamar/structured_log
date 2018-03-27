require 'bundler/gem_tasks'
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
    # TODO:  Implement dependencies
    markdown_helper = MarkdownHelper.new
    # The intermediate file must be in the same directory as the original source.
    intermediate_file_path = 'readme_files/README.md'
    markdown_helper.resolve('readme_files/README.template.md', intermediate_file_path)
    markdown_helper.include(intermediate_file_path, 'README.md')
    File.delete(intermediate_file_path)
  end

end

task :default => :test
