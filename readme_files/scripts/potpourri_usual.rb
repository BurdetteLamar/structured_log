require 'structured_log'

attributes = {:a => 0, :b => 1}
text = 'This section has a potpourri.'

StructuredLog.open('potpourri_usual.xml') do |log|
  log.section('The usual', 'Mixed hash, string, and special symbols are logged as usual.') do
    log.section('Potpourri', attributes, text, :timestamp, :duration, :rescue) do
      sleep 1
    end
  end
end
