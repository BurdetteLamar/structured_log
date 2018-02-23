require 'structured_log'

StructuredLog.open(:file_path => 'rescue.xml') do |log|
  log.section('Section with rescue', :rescue) do
    fail 'Boo!'
    # Section ends after logging the exception.
  end
  log.section('Another section') do
    log.comment('This section is ok.')
  end
end