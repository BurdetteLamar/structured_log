require 'structured_log'

StructuredLog.open(:file_path => 'rescue.xml') do |log|
  log.section('Section with rescue', :rescue) do
    log.comment('This section will terminate because of the failure.')
    fail 'This exception will be rescued and logged.'
    log.comment('This comment will not be in the log.')
  end
  log.section('Another section') do
    log.comment('This comment will be reached and logged, because of rescue above.')
  end
end
