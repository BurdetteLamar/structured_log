require 'bundler/gem_tasks'
require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.libs << 'lib'
  t.test_files = FileList['test/**/*_test.rb']
end

namespace :build do

  desc 'Build README.md file from README.template.md'
  task :readme do
    require 'markdown_helper'
    markdown_helper = MarkdownHelper.new
    markdown_helper.include('readme/README.template.md', 'README.md')
    chdir('readme') do
      %w/
        sections
        time
        rescue
      /.each do |name|
        system("ruby #{name}.rb")
      end
    end
  end

end

task :default => :test
