require 'structured_log'

array = %w/foo bar baz bat/
StructuredLog.open(:file_path => 'array.xml') do |log|
  log.put_each_with_index('my_array', array)
end
