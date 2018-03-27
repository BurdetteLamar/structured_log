require 'structured_log'

attributes = {:a => 0, :b => 1}
StructuredLog.open('attributes.xml') do |log|
  log.section('with_attributes', attributes) do
    log.comment('This section has attributes.')
  end
end
