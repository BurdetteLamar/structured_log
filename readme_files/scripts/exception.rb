require 'structured_log'

StructuredLog.open('exception.xml') do |log|
  fail('Oops!')
end
