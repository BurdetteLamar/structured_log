require 'structured_log'

StructuredLog.open('comment.xml') do |log|
  log.comment('My comment can be any text.')
end
