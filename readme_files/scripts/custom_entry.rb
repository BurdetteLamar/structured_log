require 'structured_log'

StructuredLog.open('custom_entry.xml') do |log|
  log.section('Without blocks') do
    log.put_element('element_with_text', 'No child elements, just this text.')
    log.put_element('element_with_attributes', {:a => 0, :b => 1})
    log.put_element('element_with_timestamp', :timestamp)
    log.put_element('element_with_data', 3.14159)
  end
end
