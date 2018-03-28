require 'structured_log'

StructuredLog.open('sections.xml') do |log|
  # Any code can be here.
  log.section('Outer') do
    # Any code can be here.
    log.section('Mid') do
      # Any code can be here.
      log.section('Inner') do
        # Any code can be here.
      end
      # Any code can be here.
    end
    # Any code can be here.
  end
  # Any code can be here.
end
