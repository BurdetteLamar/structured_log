require 'structured_log'

attributes = {:a => 0, :b => 1}
more_attributes = {:c => 2, :d => 3}
text = 'This section has a potpourri.'
float = 3.14159
boolean = false
fixnum = 1066
time = Time.new
exception = RuntimeError.new('Oops!')

StructuredLog.open('potpourri.xml') do |log|
  log.section('All together now', 'Order does not matter except in aggregating text and attributes.')  do
    args = [attributes, :rescue, text, float, :duration, more_attributes, boolean, :timestamp, fixnum, time, exception]
    log.section('Potpourri', *args) do
    end
    log.section('Reverse potpourri', *args.reverse) do
    end
  end
end
