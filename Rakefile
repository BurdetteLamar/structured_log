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
        target_file_path = File.join(
            target_dir_path,
            File.basename(source_file_path.sub(/rb$/, 'xml')),
        )
        unless uptodate?(target_file_path, [source_file_path])
          command = "ruby #{source_file_path}"
          system(command)
        end
      end
    end
    # TODO:  Implement dependencies
    markdown_helper = MarkdownHelper.new
    markdown_helper.include('readme_files/README.template.md', 'README.md')
  end

  desc 'Build YARD documentation'
  task :doc do
    require 'find'
    paths = []
    Find::find(__dir__).each do |path|
      next if File.directory?(path)
      next unless path.end_with?('.rb')
      paths.push(path)
    end
    puts paths.first
    # system("yard doc #{paths.first}")
  end

end

task :default => :test
