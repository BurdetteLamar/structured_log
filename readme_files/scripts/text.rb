require 'structured_log'

text = 'This section has text.'
StructuredLog.open('text.xml') do |log|
  log.section('with_text', text) do
    # Any code can be here.
  end
end
