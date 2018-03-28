require 'structured_log'

StructuredLog.open('custom_section.xml') do |log|
  log.section('With blocks') do
    log.put_element('section_with_children') do
      log.put_element('child', :rank => 'Older')
      log.put_element('child', :rank => 'Younger')
    end
    log.put_element('section_with_duration', :duration, 'Block contains timed code to be timed.') do
      sleep 1
    end
    log.put_element('section_with_rescue', :rescue, 'Block contains code to be rescued if necessary.') do
    end
  end
end
