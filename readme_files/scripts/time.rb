require 'structured_log'

StructuredLog.open('time.xml') do |log|
  log.section('Section with timestamp', :timestamp) do
    log.comment('This section has a timestamp.')
  end
  log.section('Section with duration', :duration) do
    log.comment('This section has a duration.')
    sleep 1
  end
  log.section('Section with both', :duration, :timestamp) do
    log.comment('This section has both.')
    sleep 1
  end
end
