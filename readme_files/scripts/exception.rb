require 'structured_log'

StructuredLog.open('exception.xml') do |_|
  fail('Oops!')
end
