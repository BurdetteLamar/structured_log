require 'structured_log'

StructuredLog.open('sections.xml') do |log|
  log.section('Outer') do
    log.section('Mid') do
      log.section('Inner') do
        log.comment('I am nested.')
      end
    end
  end
end
