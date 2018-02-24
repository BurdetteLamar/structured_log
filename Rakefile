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
    chdir('readme') do
      %w/
        sections
        time
        rescue
        array
        hash
        data
        cdata
      /.each do |name|
        source_file_name = "#{name}.rb"
        target_file_name = "#{name}.xml"
        unless uptodate?(target_file_name, [source_file_name])
          system("ruby #{source_file_name}")
          puts source_file_name, target_file_name
        end
      end
    end
    # TODO:  Implement dependencies
    markdown_helper = MarkdownHelper.new
    markdown_helper.include('readme/README.template.md', 'README.md')
  end

end

task :default => :test
